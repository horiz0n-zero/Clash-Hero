//
//  Head.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 24/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

class Head: SKSpriteNode {
    let type: HeroType
    let sprite: SKSpriteNode
    let spriteName: SKLabelNode
    let index: Int
    private static let spriteSize = CGSize(width: 80, height: 72)
    
    init(type: HeroType, index: Int) {
        self.type = type
        self.index = index
        self.sprite = SKSpriteNode(texture: HeroTextures.small_icon[type.rawValue], color: UIColor.clear, size: Head.spriteSize)
        self.sprite.position.y = -17
        self.sprite.position.x = 4
        self.sprite.anchorPoint = CGPoint(x: 0.5, y: 0)
        //
        self.spriteName = SKLabelNode(text: HeroTextures.textures_init[type.rawValue].1)
        self.spriteName.fontColor = UIColor.black
        self.spriteName.fontSize = 13
        self.spriteName.position.y = -30
        //
        super.init(texture: BattleTextures.head, color: UIColor.clear, size: BattleTextures.headSize)
        self.addChild(self.sprite)
        self.addChild(self.spriteName)
        self.name = "head"
        self.sprite.name = "heads"
        self.spriteName.name = "heads"
        self.zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func select() {
        self.run(fx.fx_click)
        
    }
    
}
