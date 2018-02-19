//
//  side.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 30/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

enum SideIdentifier {
    case player
    case enemy
}

protocol Side {
    
    var side: SideIdentifier { get }
    
}
