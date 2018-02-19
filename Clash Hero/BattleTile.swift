//
//  BattleTile.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 30/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

class BattleTile: SKSpriteNode {
    
    var deco: DecoNode? = nil
    var cristal: CristalNode? = nil
    var tower: TowerNode? = nil
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    func setDeco() {
        self.deco = DecoNode()
        self.addChild(self.deco!)
    }
    
    func setCristal(ofSide: SideIdentifier) {
        self.cristal = CristalNode(side: ofSide)
        self.addChild(self.cristal!)
    }
    
    func setTower(ofSide: SideIdentifier) {
        self.tower = TowerNode(side: ofSide)
        self.addChild(self.tower!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
