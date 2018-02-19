//
//  creature.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 30/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

enum HeroAction: Int {
    case stay = 0
    case move = 1
    case attack = 2
}

enum HeroDirection: Int {
    case down = 0
    case down_face = 1
    case face = 2
    case up_face = 3
    case up = 4
}

protocol Creature {
    var action: HeroAction { get set }
    var direction: HeroDirection { get set }
    var face_left: Bool { get set }
}
