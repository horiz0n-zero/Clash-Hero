//
//  HeroHead.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 26/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

class HeroHead: Head {
    let save: HeroSaved
    static let textureStoneCommon = SKTexture(imageNamed: "herotag_0")
    static let textureStoneRare = SKTexture(imageNamed: "herotag_1")
    static let textureStoneEpic = SKTexture(imageNamed: "herotag_2")
    static let textureStoneShiny = SKTexture(imageNamed: "herotag_3")
    static let textureS1 = SKTexture(imageNamed: "posy_pos_1")
    static let textureS2 = SKTexture(imageNamed: "posy_pos_2")
    static let textureS3 = SKTexture(imageNamed: "posy_pos_3")
    static let textureS4 = SKTexture(imageNamed: "posy_pos_4")
    static let textureGS1 = SKTexture(imageNamed: "posy_item_ept_1")
    static let textureGS2 = SKTexture(imageNamed: "posy_item_ept_2")
    static let textureGS3 = SKTexture(imageNamed: "posy_item_ept_3")
    static let textureGS4 = SKTexture(imageNamed: "posy_item_ept_4")
    let stone: SKSpriteNode
    var select: (SKSpriteNode, Int)? = nil
    
    init(save: HeroSaved, index: Int) {
        self.save = save
        var tex: SKTexture!
        switch save.rarity {
        case .common:
            tex = HeroHead.textureStoneCommon
        case .rare:
            tex = HeroHead.textureStoneRare
        case .epic:
            tex = HeroHead.textureStoneEpic
        case .shiny:
            tex = HeroHead.textureStoneShiny
        }
        self.stone = SKSpriteNode(texture: tex)
        super.init(type: save.type, index: index)
        let size = self.size.width / 4
        self.stone.size = CGSize(width: size, height: size)
        self.stone.position = CGPoint(x: self.size.width / 2 - size / 2, y: self.size.height / 2 - size / 2)
        self.addChild(self.stone)
    }
    
    func selectAt(index: Int) {
        self.unselect()
        var tex: SKTexture!
        switch index {
        case 0:
            tex = HeroHead.textureS1
        case 1:
            tex = HeroHead.textureS2
        case 2:
            tex = HeroHead.textureS3
        default:
            tex = HeroHead.textureS4
        }
        self.select = (SKSpriteNode(texture: tex, color: UIColor.clear, size: self.stone.size), index)
        self.select!.0.position = CGPoint(x: -self.stone.position.x, y: -self.stone.position.y)
        self.addChild(self.select!.0)
    }
    
    func unselect() {
        if self.select != nil {
            self.select!.0.removeFromParent()
            self.select = nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
