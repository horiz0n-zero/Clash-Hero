//
//  BattleScene.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 24/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

class BattleScene: SKScene {
    
    let layout: Layout
    var heads: [Head]!
    var currentHeadSelection: Int = 0
    let headSelection = SKSpriteNode(texture: BattleTextures.headSelect, color: UIColor.clear, size: BattleTextures.headSize)
    var heroPosable: Hero? = nil
    let save: Saver
    var topTile: [BattleTile]!
    var bottomTile: [BattleTile]!
    var buildings: [Side]!
    var heros: [Hero] = []
    
    let queue: DispatchQueue
    
    init(layout: Layout, save: Saver) {
        self.save = save
        self.layout = layout
        self.queue = DispatchQueue(label: "com.z-zero.clash_hero", qos: .userInteractive)
        super.init(size: layout.size)
        self.backgroundColor = UIColor.black
        self.initHeads()
        self.drawMap()
        self.physicsInit()
        spawnRandomHero()
        spawnRandomHero()
        spawnRandomHero()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    deinit {
        self.removeAllActions()
        self.removeAllChildren()
    }
    
    fileprivate func selectHead(head: Head) {
        if head.index != self.currentHeadSelection {
            head.select()
            self.currentHeadSelection = head.index
            self.headSelection.position = self.heads[self.currentHeadSelection].position
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let first = touches.first else {
            return
        }
        let location = first.location(in: self)
        if location.y < BattleTextures.headSize.height {
            if let node = self.nodes(at: location).first {
                if node.name == "head" {
                    self.selectHead(head: node as! Head)
                }
                else if node.name == "heads" {
                    self.selectHead(head: node.parent! as! Head)
                }
            }
        }
        else {
            if self.heroPosable == nil {
                self.heroPosable = Hero(type: self.heads[self.currentHeadSelection].type, side: .player)
                self.heroPosable!.position = location
                self.addChild(self.heroPosable!)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let first = touches.first else {
            return
        }
        let location = first.location(in: self)
        if location.y < BattleTextures.headSize.height {
            if let node = self.nodes(at: location).first {
                if node.name == "head" {
                    self.selectHead(head: node as! Head)
                }
                else if node.name == "heads" {
                    self.selectHead(head: node.parent! as! Head)
                }
            }
        }
        else {
            if self.heroPosable != nil {
                self.heroPosable!.position = location
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let first = touches.first else {
            return
        }
        let location = first.location(in: self)
        if location.y > BattleTextures.headSize.height {
            if self.heroPosable != nil {
                
                self.heroPosable!.position = location
                let work = DispatchWorkItem(block: {
                    self.heroPosable!.baseAction.spawn?(self.heroPosable!)
                    self.turnFor(hero: self.heroPosable!)
                    self.heros.append(self.heroPosable!)
                    self.heroPosable = nil
                })
                self.queue.async(execute: work)
            }
        }
    }
    
    func spawnRandomHero() {
        let new = Hero(type: WireScene.wire().0, side: .enemy)
        
        let r = arc4random_uniform(UInt32(self.bottomTile.count))
        new.position = self.bottomTile[Int(r)].position
        self.addChild(new)
        self.heros.append(new)
        self.turnFor(hero: new)
    }
    
}

extension BattleScene {
    
    func turnFor(hero: Hero) {
        if hero.life <= 0 {
            hero.baseAction.death?(hero)
            if let index = self.heros.index(of: hero) {
                self.heros.remove(at: index)
            }
            return
        }
        // distance and target selection
        func distance(from: SKNode, to: SKNode) -> CGFloat {
            return sqrt(pow(from.position.x - to.position.x, 2) + pow(from.position.y - to.position.y, 2))
        }
        var array: [(CGFloat, Destroyable, Int)] = []
        for (i, build) in self.buildings.enumerated() {
            if build.side == hero.side {
                continue
            }
            let cdis = distance(from: (build as! SKNode).parent!, to: hero)
            array.append((cdis, build as! Destroyable, i))
        }
        for enemy in self.heros {
            if enemy.side == hero.side {
                continue
            }
            let cdis = distance(from: hero, to:  enemy)
            array.append((cdis, enemy, -1))
        }
        array.sort(by: {
            (a, b) in return a.0 < b.0
        })
        // choose target
        var time: TimeInterval!
        if array.count == 0 { // stay
            time = hero.animateStay()
        }
        else { // move or attack
            if var target = array.first {
                
                hero.rotateIn(direction: (target.1 as! SKNode).position)
                if target.0 <= hero.baseAction.range { // attack distance
                    time = hero.animateAttack()
                    target.1.life -= hero.atk // another time ! building spec case
                    hero.addLabel(to: target.1 as! SKSpriteNode, txt: "-\(hero.atk)")
                    if target.1.life <= 0 && target.2 != -1 {
                        self.buildings.remove(at: target.2)
                    }
                }
                else { // moving
                    time = hero.animateMove()
                    // calculate angle, plus impulsion
                    // hero.physicsBody!.applyImpulse(CGVector.init(dx: 20, dy: 20), at: (target.1 as! SKNode).position)
                }
            }
        }
        // next call using time
        unowned let ReferenceScene = self
        
        let work = DispatchWorkItem(block: {
            ReferenceScene.turnFor(hero: hero)
        })
        self.queue.asyncAfter(deadline: DispatchTime.now() + time, execute: work)
    }
    
}

extension BattleScene {
    
    fileprivate func initHeads() {
        let diff = (self.layout.size.width - BattleTextures.headSize.width * 4) / 5
        let y = BattleTextures.headSize.height / 2
        let xadd = diff + BattleTextures.headSize.width
        var xposition = diff + BattleTextures.headSize.width / 2
        
        
        self.heads = [Head]()
        for i in 0...3 {
            let head = Head(type: self.save.heros[self.save.heroSelected[i]].type, index: i)
            head.position.x = xposition
            head.position.y = y
            self.addChild(head)
            self.heads.append(head)
            xposition += xadd
        }
        self.headSelection.position = self.heads[0].position
        self.headSelection.zPosition = 2
        self.addChild(self.headSelection)
    }
    
    fileprivate func drawVisual(top: CGPoint, bottom: CGPoint, size: CGSize) {
        self.topTile[0].setDeco()
        self.topTile[Int(top.x - 1)].setDeco()
        self.topTile[Int(top.x * top.y - top.x)].setDeco()
        self.topTile.last!.setDeco()
        
        self.buildings = []
        if Int(top.x) % 2 == 1 {
            print("top % 2 == 1")
            let topi = Int(top.x) / 2
            let bottomi = Int(top.x * top.y - top.x / 2)
            self.topTile[topi].setCristal(ofSide: .enemy)
            self.buildings.append(self.topTile[topi].cristal!)
            self.topTile[bottomi].setCristal(ofSide: .player)
            self.buildings.append(self.topTile[bottomi].cristal!)
            // tower
            let start = Int(top.x * 2) + 1
            self.topTile[start].setTower(ofSide: .enemy)
            self.buildings.append(self.topTile[start].tower!)
            self.topTile[start + 1].setTower(ofSide: .enemy)
            self.buildings.append(self.topTile[start + 1].tower!)
            self.topTile[start + 2].setTower(ofSide: .enemy)
            self.buildings.append(self.topTile[start + 2].tower!)
            
            let end = Int(top.x * top.y - (top.x * 2)) - 2
            self.topTile[end].setTower(ofSide: .player)
            self.buildings.append(self.topTile[end].tower!)
            self.topTile[end - 1].setTower(ofSide: .player)
            self.buildings.append(self.topTile[end - 1].tower!)
            self.topTile[end - 2].setTower(ofSide: .player)
            self.buildings.append(self.topTile[end - 2].tower!)
        }
        else {
            let topi = Int(bottom.x) / 2
            let bottomi = Int(bottom.x * bottom.y - bottom.x / 2)
            self.bottomTile[topi].setCristal(ofSide: .enemy)
            self.buildings.append(self.bottomTile[topi].cristal!)
            self.bottomTile[bottomi].setCristal(ofSide: .player)
            self.buildings.append(self.bottomTile[bottomi].cristal!)
            // tower
            let start = Int(bottom.x * 2)
            self.bottomTile[start].setTower(ofSide: .enemy)
            self.buildings.append(self.bottomTile[start].tower!)
            self.bottomTile[start + 1].setTower(ofSide: .enemy)
            self.buildings.append(self.bottomTile[start + 1].tower!)
            self.bottomTile[start + 2].setTower(ofSide: .enemy)
            self.buildings.append(self.bottomTile[start + 2].tower!)
            
            let end = Int(bottom.x * bottom.y - (bottom.x * 2)) - 1
            self.bottomTile[end].setTower(ofSide: .player)
            self.buildings.append(self.bottomTile[end].tower!)
            self.bottomTile[end - 1].setTower(ofSide: .player)
            self.buildings.append(self.bottomTile[end - 1].tower!)
            self.bottomTile[end - 2].setTower(ofSide: .player)
            self.buildings.append(self.bottomTile[end - 2].tower!)
        }
    }
    
    fileprivate func drawMap() {
        let size = BattleTextures.foregroundSize / 2
        let disize = size / 2
        let height = self.frame.height - BattleTextures.headSize.height
        
        let xcount = Int(self.frame.width / size.width)
        let ycount = Int(height / disize.height)
        let ydidiff = (height - (disize.height * CGFloat(ycount))) / 2
        let xdidiff = (self.frame.width  - (size.width * CGFloat(xcount))) / 2
        var xpos: CGFloat = xdidiff
        var ypos: CGFloat = self.frame.height - ydidiff
        
        self.topTile = []
        for _ in 1...ycount {
            for _ in 1...xcount {
                let tile = BattleTile(texture: BattleTextures.foreground,
                                        color: UIColor.clear, size: size)
                tile.anchorPoint = CGPoint(x: 0, y: 1)
                tile.position = CGPoint(x: xpos, y: ypos)
                tile.zPosition = -ypos
                self.addChild(tile)
                self.topTile.append(tile)
                xpos += size.width
            }
            xpos = xdidiff
            ypos -= disize.height
        }
        // in rec
        let recxcount = xcount - 1
        let recycount = ycount - 1
        let recydidiff = (height - (disize.height * CGFloat(recycount))) / 2
        let recxdidiff = (self.frame.width  - (size.width * CGFloat(recxcount))) / 2
        xpos = recxdidiff
        ypos = self.frame.height - recydidiff
        
        self.bottomTile = []
        for _ in 1...recycount {
            for _ in 1...recxcount {
                let tile = BattleTile(texture: BattleTextures.foreground,
                                        color: UIColor.clear, size: size)
                tile.anchorPoint = CGPoint(x: 0, y: 1)
                tile.position = CGPoint(x: xpos, y: ypos)
                tile.zPosition = -ypos
                self.bottomTile.append(tile)
                self.addChild(tile)
                xpos += size.width
            }
            xpos = recxdidiff
            ypos -= disize.height
        }
        self.drawVisual(top: CGPoint.init(x: xcount, y: ycount),
                        bottom: CGPoint.init(x: recxcount, y: recycount), size: size)
    }
    
}









