//
//  DecoNode.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 30/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

class DecoNode: SKSpriteNode {
    static let blueFireTextures = [
        SKTexture(imageNamed: "0_0"),
        SKTexture(imageNamed: "0_1"),
        SKTexture(imageNamed: "0_2"),
        SKTexture(imageNamed: "0_3")
    ]
    static let base = SKTexture(imageNamed: "base")
    static let baseSize = DecoNode.base.size() / 2.5
    let fire: SKSpriteNode
    
    init() {
        self.fire = SKSpriteNode(texture: DecoNode.blueFireTextures.first!, color: UIColor.clear, size: DecoNode.blueFireTextures.first!.size() / 4)
        super.init(texture: DecoNode.base, color: UIColor.clear, size: DecoNode.baseSize)
        self.fire.position.y += DecoNode.baseSize.height / 2
        self.fire.run(SKAction.repeatForever(
            SKAction.animate(with: DecoNode.blueFireTextures, timePerFrame: 0.1, resize: false, restore: false)))
        self.addChild(self.fire)
        self.position.y -= BattleTextures.foregroundDiSize.height / 3
        self.position.x += BattleTextures.foregroundSize.width / 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
