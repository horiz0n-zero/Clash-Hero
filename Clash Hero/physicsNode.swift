//
//  physics_node_static.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 01/02/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    
    func physics_nodeStatic() {
        let radius = sqrt(pow(self.size.width, 2) + pow(self.size.height, 2)) / 2
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.isDynamic = false
        self.physicsBody!.usesPreciseCollisionDetection = true
        //
        let shape = SKShapeNode(circleOfRadius: radius)
        shape.fillColor = UIColor.clear
        shape.strokeColor = UIColor.blue
        self.addChild(shape)
        //
    }
}

extension Hero {
    
    func physics_nodeDynamic() {
        let radius = sqrt(pow(self.size.width, 2) + pow(self.size.height, 2)) / 2
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.isDynamic = true
        self.physicsBody!.usesPreciseCollisionDetection = true
        let shape = SKShapeNode(circleOfRadius: radius)
        shape.fillColor = UIColor.clear
        shape.strokeColor = UIColor.blue
        self.addChild(shape)
    }
}
