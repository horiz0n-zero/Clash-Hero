//
//  HeroScene.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 26/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

class HeroScene: SKScene {
    
    let layout: Layout
    var save: Saver
    let labelCount: SKLabelNode
    let wire: SKSpriteNode
    static let heroArrowTexture = SKTexture(imageNamed: "hero_arrow")
    var currentIndex: Int = 0
    var currentPage: Int = 0
    var currentPageCount: Int = 0
    static var scurrentIndex: Int = 0
    static var scurrentPage: Int = 0
    static var scurrentPageCount: Int = 0
    var selectionNode: SKSpriteNode? = nil
    var selectionHead: [HeroHead?]
    
    init(layout: Layout, save: Saver) {
        self.layout = layout
        self.save = save
        self.labelCount = SKLabelNode(fontNamed: "Herculanum")
        self.wire = SKSpriteNode(texture: WireScene.button)
        self.selectionHead = Array(repeating: nil, count: 4)
        super.init(size: self.layout.size)
        self.backgroundColor = UIColor.black
        self.labelCount.position = CGPoint(x: layout.center.x, y: layout.size.height)
        self.labelCount.verticalAlignmentMode = .top
        self.labelCount.horizontalAlignmentMode = .center
        self.labelCount.fontColor = UIColor.gray
        self.labelCount.text = "\(save.heroCount)/37"
        self.addChild(self.labelCount)
        self.wire.size = BattleTextures.headSize
        self.wire.position = CGPoint(x: self.wire.size.width / 2, y: self.wire.size.height / 2)
        self.addChild(self.wire)
        
        // <- 1 2 3 4 ->
        let left = SKSpriteNode(texture: HeroScene.heroArrowTexture,
                                color: UIColor.clear, size: self.wire.size)
        left.xScale = left.xScale * -1
        let s = left.size.width / 2
        left.position = CGPoint(x: s, y: left.size.height + s)
        left.name = "left"
        self.addChild(left)
        let right = SKSpriteNode(texture: HeroScene.heroArrowTexture,
                                 color: UIColor.clear, size: self.wire.size)
        right.position = CGPoint(x: self.frame.size.width - s, y: left.position.y)
        right.name = "right"
        self.addChild(right)
        // 1 2 3 4
        let diff = self.frame.width - (left.size.width * 2)
        let size = diff / 4
        let semi = size / 2
        
        let s1 = SKSpriteNode(texture: HeroHead.textureGS1, color: UIColor.clear, size: CGSize(width: size, height: size))
        s1.position = CGPoint(x: right.size.width + semi, y: left.position.y)
        s1.name = "select"
        s1.lightingBitMask = 0
        let s2 = SKSpriteNode(texture: HeroHead.textureGS2, color: UIColor.clear, size: CGSize(width: size, height: size))
        s2.position = CGPoint(x: s1.position.x + size, y: left.position.y)
        s2.name = "select"
        s2.lightingBitMask = 1
        let s3 = SKSpriteNode(texture: HeroHead.textureGS3, color: UIColor.clear, size: CGSize(width: size, height: size))
        s3.position = CGPoint(x: s2.position.x + size, y: left.position.y)
        s3.name = "select"
        s3.lightingBitMask = 2
        let s4 = SKSpriteNode(texture: HeroHead.textureGS4, color: UIColor.clear, size: CGSize(width: size, height: size))
        s4.position = CGPoint(x: s3.position.x + size, y: left.position.y)
        s4.name = "select"
        s4.lightingBitMask = 3
        self.addChild(s1)
        self.addChild(s2)
        self.addChild(s3)
        self.addChild(s4)
        self.drawHeadAt(start: self.currentIndex)
    }
    deinit {
        self.removeAllActions()
        self.removeAllChildren()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        func switchToPresentScene(byLoading head: HeroHead) {
            let scene = HeroPresentScene(layout: self.layout, save: self.save, hero: head.save)
            
            HeroScene.scurrentIndex = self.currentIndex
            HeroScene.scurrentPage = self.currentPage
            HeroScene.scurrentPageCount = self.currentPageCount
            self.view?.presentScene(scene)
        }
        
        guard let first = touches.first, self.selectionNode == nil else {
            return
        }
        let location = first.location(in: self)
        if self.wire.contains(location) {
            let scene = WireScene(layout: self.layout, saver: self.save)
            let transition = SKTransition.fade(withDuration: 1)
            self.view?.presentScene(scene, transition: transition)
        }
        else {
            if let node = self.nodes(at: location).first {
                if node.name == "head" {
                    switchToPresentScene(byLoading: node as! HeroHead)
                }
                else if node.name == "heads" {
                    switchToPresentScene(byLoading: node.parent! as! HeroHead)
                }
                else if node.name == "left" {
                    if self.currentPage != 0 {
                        self.run(fx.fx_clickButton)
                        for node in self.children {
                            if node.name == "head" {
                                node.removeFromParent()
                            }
                        }
                        self.currentPage -= 1
                        self.currentIndex -= self.currentPageCount
                        self.drawHeadAt(start: self.currentIndex)
                    }
                }
                else if node.name == "right" {
                    if self.currentIndex + self.currentPageCount < self.save.heroCount {
                        self.run(fx.fx_clickButton)
                        for node in self.children {
                            if node.name == "head" {
                                node.removeFromParent()
                            }
                        }
                        self.currentPage += 1
                        self.currentIndex += self.currentPageCount
                        self.drawHeadAt(start: self.currentIndex)
                    }
                }
                else if node.name == "select" {
                    var tex: SKTexture!
                    switch (node as! SKSpriteNode).lightingBitMask {
                    case 0:
                        tex = HeroHead.textureS1
                    case 1:
                        tex = HeroHead.textureS2
                    case 2:
                        tex = HeroHead.textureS3
                    default:
                        tex = HeroHead.textureS4
                    }
                    self.selectionNode = SKSpriteNode(texture: tex, color: UIColor.clear, size: (node as! SKSpriteNode).size)
                    self.selectionNode!.position = node.position
                    self.selectionNode!.zPosition = 10
                    self.selectionNode!.lightingBitMask = (node as! SKSpriteNode).lightingBitMask
                    self.addChild(self.selectionNode!)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let spriteSelect = self.selectionNode {
            let location = touches.first!.location(in: self)
            spriteSelect.position = location
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let spriteSelect = self.selectionNode {
            for node in self.nodes(at: spriteSelect.position) {
                if node.name == "head" {
                    if (node as! HeroHead).select != nil {
                        self.run(fx.fx_incorect)
                        break
                    }
                    let index = Int(spriteSelect.lightingBitMask)
                    
                    if let last = self.selectionHead[index] {
                        last.unselect()
                    }
                    self.save.heroSelected[index] = (node as! HeroHead).index
                    (node as! HeroHead).selectAt(index: index)
                    break
                }
                else if node.name == "heads" {
                    if (node.parent! as! HeroHead).select != nil {
                        self.run(fx.fx_incorect)
                        break
                    }
                    let index = Int(spriteSelect.lightingBitMask)
                    
                    if let last = self.selectionHead[index] {
                        last.unselect()
                    }
                    self.save.heroSelected[index] = (node.parent! as! HeroHead).index
                    (node.parent! as! HeroHead).selectAt(index: index)
                    break
                }
            }
            spriteSelect.removeFromParent()
            self.selectionNode = nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func drawHeadAt(start: Int) {
        
        let height = self.frame.size.height -
            (self.childNode(withName: "left")!.position.y +
                (self.childNode(withName: "left")! as! SKSpriteNode).size.height / 2 + self.labelCount.fontSize)
        let xcount = Int(self.frame.width /  (BattleTextures.headSize.width * 1.1))
        let ycount = Int(height / (BattleTextures.headSize.height * 1.1))
        //if HeroScene.scurrentPage != 0 {
            //self.currentIndex = HeroScene.scurrentIndex
            //self.currentPageCount = HeroScene.scurrentPageCount
          //  self.currentPage = HeroScene.scurrentPage
        //}
        //else {
            self.currentPageCount = xcount * ycount
        //}
        
        let diffx = (self.frame.width - CGFloat(xcount) * BattleTextures.headSize.width) / CGFloat(xcount + 1)
        let diffy =  (height - CGFloat(xcount) * BattleTextures.headSize.height) / CGFloat(xcount + 1)

        let demix = BattleTextures.headSize.width / 2
        let demiy = BattleTextures.headSize.height / 2
        
        var xpos: CGFloat = demix + diffx
        var ypos: CGFloat = self.frame.height - (self.labelCount.fontSize * 2)
        var count = start
        
        for _ in 1...ycount {
            for _ in 1...xcount {
                if count >= self.save.heroCount {
                    return
                }
                let head = HeroHead(save: self.save.heros[count], index: count)
                
                if self.save.heroSelected.contains(count) {
                    let index = self.save.heroSelected.index(of: count)!
                    self.selectionHead[index] = head
                    head.selectAt(index: index)
                }
                count += 1
            
                head.position = CGPoint(x: xpos, y: ypos)
                self.addChild(head)
                xpos += diffx + BattleTextures.headSize.width
            }
            xpos = demix + diffx
            ypos -= diffy + demiy
        }
    }
    
}













