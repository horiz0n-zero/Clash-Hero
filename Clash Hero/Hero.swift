//
//  Hero.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 25/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

class Hero: SKSpriteNode {
    
    let textures: [[[SKTexture]]]
    
    init(type: HeroType) {
        self.textures = HeroTextures.textures![type.rawValue]
        super.init(texture: self.textures[0][0][0], color: UIColor.clear, size: self.textures[0][0][0].size())
        self.run(SKAction.repeatForever(
            SKAction.animate(with: self.textures[0][0], timePerFrame: 0.1, resize: true, restore: false)
        ))
        self.setScale(0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
