//
//  fx.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 25/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

struct fx {
    static let fx_click = SKAction.playSoundFileNamed("click.caf", waitForCompletion: false)
    static let fx_incorect = SKAction.playSoundFileNamed("incorect.caf", waitForCompletion: false)
    static let fx_getHero = SKAction.playSoundFileNamed("Get_Hero.mp3", waitForCompletion: false)
    static let fx_getHeroShiny = SKAction.playSoundFileNamed("Selected.mp3", waitForCompletion: false)
    static let fx_GoBattle = SKAction.playSoundFileNamed("Make_War.mp3", waitForCompletion: false)
    static let fx_clickButton = SKAction.playSoundFileNamed("click_button.mp3", waitForCompletion: false)
    static let fx_heroSpawn = SKAction.playSoundFileNamed("setHero.mp3", waitForCompletion: false)
    static let fx_broken = SKAction.playSoundFileNamed("broken.mp3", waitForCompletion: false)
}
