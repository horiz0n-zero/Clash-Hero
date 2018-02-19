//
//  spawn_death.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 31/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

extension Hero {
    static func spawnProto(_ hero: Hero) {
        let node = SKSpriteNode(texture: Hero.protoTexture[0])
        
        hero.addChild(node)
        node.zPosition = -1
        node.position.y -= hero.size.height
        node.anchorPoint = CGPoint(x: 0.5, y: 0)
        node.run(fx.fx_heroSpawn)
        node.run(SKAction.animate(with: Hero.protoTexture, timePerFrame: 0.1, resize: true, restore: false), completion: {
            node.removeFromParent()
        })
    }
    
    static func deathProto(_ hero: Hero) {
        hero.removeFromParent()
    }
}

extension Hero {
    fileprivate static let protoTexture = [
        SKTexture(imageNamed: "p_0"),
        SKTexture(imageNamed: "p_1"),
        SKTexture(imageNamed: "p_2"),
        SKTexture(imageNamed: "p_3"),
        SKTexture(imageNamed: "p_4"),
        SKTexture(imageNamed: "p_5")
    ]
}
