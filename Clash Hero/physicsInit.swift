//
//  physicsInit.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 01/02/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

extension BattleScene: SKPhysicsContactDelegate {
    func physicsInit() {
        self.physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print(contact)
    }
}
