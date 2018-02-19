//
//  CristalNode.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 30/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

class CristalNode: SKSpriteNode, Side, Destroyable {
    static let cristal_red = SKTexture(imageNamed: "cristalRed")
    static let cristal_blue = SKTexture(imageNamed: "cristalBlue")
    static let red = SKTexture(imageNamed: "red")
    static let blue = SKTexture(imageNamed: "blue")
    let emitter: SKEmitterNode
    static let cristalSize = CGSize(width: 101 / 1.5, height: 115 / 1.5)
    var side: SideIdentifier
    var life: Int {
        didSet {
            if self.life <= 0 {
                self.parent!.run(fx.fx_broken)
                self.removeFromParent()
            }
        }
    }
    
    init(side: SideIdentifier) {
        self.side = side
        self.life = 150_000
        self.emitter = SKEmitterNode(fileNamed: "Cristal.sks")!
        self.emitter.name = "emitter"
        switch side {
        case .player:
            super.init(texture: CristalNode.cristal_blue, color: UIColor.clear, size: CristalNode.cristalSize)
            self.xScale = self.xScale * -1
            self.emitter.particleTexture = CristalNode.blue
        default:
            super.init(texture: CristalNode.cristal_red, color: UIColor.clear, size: CristalNode.cristalSize)
            self.position.y -= BattleTextures.foregroundDiSize.height / 2
            self.zPosition += BattleTextures.foregroundDiSize.height
            self.emitter.particleTexture = CristalNode.red
        }
        self.position.x += BattleTextures.foregroundSize.width / 4
        self.addChild(self.emitter)
        self.physics_nodeStatic()
        self.physicsBody!.categoryBitMask = self.side == .enemy ? BodyType.Enemy.rawValue : BodyType.Player.rawValue | BodyType.Building.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
