//
//  TowerNode.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 30/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

class TowerNode: SKSpriteNode, Side, Destroyable {
    
    static let towerTexture = SKTexture(imageNamed: "tower")
    static let towerSize = CGSize(width: 67 / 2, height: 123 / 2)
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
        self.life = 50_000
        super.init(texture: TowerNode.towerTexture,
                   color: UIColor.clear, size: TowerNode.towerSize)
        self.position.x += BattleTextures.foregroundSize.width / 4
        self.physics_nodeStatic()
        self.physicsBody!.categoryBitMask = self.side == .enemy ? BodyType.Enemy.rawValue : BodyType.Player.rawValue | BodyType.Building.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
