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
    
    var foregroundMap: SKTileMapNode!
    let layout: Layout
    var heads: [Head]!
    var currentHeadSelection: Int = 0
    var mapNode: SKNode!
    static let mapValue = [
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [0, 1, 1, 0, 1, 1, 0],
        [0, 1, 0, 0, 0, 1, 0],
        [0, 1, 1, 0, 1, 1, 0],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1]
    ]
    let headSelection = SKSpriteNode(texture: BattleTextures.headSelect, color: UIColor.clear, size: BattleTextures.headSize)
    var heroPosable: Hero? = nil
    
    init(layout: Layout) {
        /*let set = SKTileSet(tileGroups: [SKTileGroup.init(tileDefinition: SKTileDefinition.init(texture: BattleTextures.foreground))],
                            tileSetType: .isometric)
    
        self.foregroundMap = SKTileMapNode(tileSet: set,
                                           columns: 5, rows: 5, tileSize: BattleTextures.tileSize, fillWith: set.tileGroups.first!)*/
        self.layout = layout
        super.init(size: layout.size)
        self.backgroundColor = UIColor.black
        //self.foregroundMap.position = self.layout.center
        //self.addChild(self.foregroundMap)
        self.initHeads()
        self.drawMap()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
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
                self.heroPosable = Hero(type: self.heads[self.currentHeadSelection].type)
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
                self.heroPosable = nil
            }
        }
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
            let head = Head(type: HeroType(rawValue: Int(arc4random_uniform(28)))!, index: i)
            head.position.x = xposition
            head.position.y = y
            self.addChild(head)
            self.heads.append(head)
            xposition += xadd
        }
        self.headSelection.position = self.heads[0].position
        self.addChild(self.headSelection)
    }
    
    fileprivate func drawMap() {
        self.mapNode = SKNode()
        self.mapNode.position = CGPoint(x: BattleTextures.foregroundDiSize.width, y: BattleTextures.headSize.height)
        self.addChild(self.mapNode)
       
        
    }
    
}









