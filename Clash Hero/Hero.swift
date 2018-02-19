//
//  Hero.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 25/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

struct HeroStat {
    var life: Int
    var atk: Int
    var atkspeed: TimeInterval
    var movespeed: CGFloat
    var reloadTime: TimeInterval
}

extension Hero {
    static let stats: [HeroStat] = [
        HeroStat(life: 15_000, atk: 1000, atkspeed: 2, movespeed: 2, reloadTime: 3),
        HeroStat(life: 17_000, atk: 900, atkspeed: 1.2, movespeed: 1, reloadTime: 4),
        HeroStat(life: 22_000, atk: 1300, atkspeed: 1.5, movespeed: 1, reloadTime: 3),
        HeroStat(life: 23_000, atk: 1000, atkspeed: 1.2, movespeed: 1, reloadTime: 3),
        //
        HeroStat(life: 33_000, atk: 1700, atkspeed: 1, movespeed: 2, reloadTime: 5),
        HeroStat(life: 20_000, atk: 1000, atkspeed: 0.9, movespeed: 2, reloadTime: 4),
        HeroStat(life: 30_000, atk: 900, atkspeed: 0.8, movespeed: 0.5, reloadTime: 6),
        HeroStat(life: 40_000, atk: 500, atkspeed: 1, movespeed: 2, reloadTime: 4),
        HeroStat(life: 39_000, atk: 1500, atkspeed: 1, movespeed: 1.5, reloadTime: 5),
        //
        HeroStat(life: 90_000, atk: 5000, atkspeed: 1, movespeed: 2, reloadTime: 10),
        HeroStat(life: 65_000, atk: 3500, atkspeed: 1.2, movespeed: 1.5, reloadTime: 5),
        HeroStat(life: 45_000, atk: 2900, atkspeed: 1, movespeed: 2, reloadTime: 6),
        HeroStat(life: 35_000, atk: 2700, atkspeed: 1, movespeed: 2, reloadTime: 5),
        HeroStat(life: 75_000, atk: 4000, atkspeed: 1.5, movespeed: 1.5, reloadTime: 6),
        HeroStat(life: 60_000, atk: 3300, atkspeed: 1.2, movespeed: 1, reloadTime: 7),
        HeroStat(life: 70_000, atk: 3000, atkspeed: 1.5, movespeed: 2, reloadTime: 7),
        HeroStat(life: 65_000, atk: 3300, atkspeed: 1, movespeed: 1, reloadTime: 6),
        HeroStat(life: 80_000, atk: 3500, atkspeed: 1.5, movespeed: 2, reloadTime: 5),
        HeroStat(life: 74_000, atk: 2200, atkspeed: 2, movespeed: 1, reloadTime: 4),
        HeroStat(life: 50_000, atk: 4000, atkspeed: 0.7, movespeed: 1, reloadTime: 8),
        HeroStat(life: 25_000, atk: 1000, atkspeed: 1, movespeed: 1, reloadTime: 3),
        HeroStat(life: 60_000, atk: 3300, atkspeed: 1, movespeed: 1, reloadTime: 5),
        HeroStat(life: 65_000, atk: 3600, atkspeed: 1.5, movespeed: 1, reloadTime: 6),
        //
        HeroStat(life: 90_000, atk: 5000, atkspeed: 1, movespeed: 2, reloadTime: 10),
        HeroStat(life: 65_000, atk: 3500, atkspeed: 1.2, movespeed: 1.5, reloadTime: 5),
        HeroStat(life: 45_000, atk: 2900, atkspeed: 1, movespeed: 2, reloadTime: 6),
        HeroStat(life: 35_000, atk: 2700, atkspeed: 1, movespeed: 2, reloadTime: 5),
        HeroStat(life: 75_000, atk: 4000, atkspeed: 1.5, movespeed: 1.5, reloadTime: 6),
        HeroStat(life: 60_000, atk: 3300, atkspeed: 1.2, movespeed: 1, reloadTime: 7),
        HeroStat(life: 70_000, atk: 3000, atkspeed: 1.5, movespeed: 2, reloadTime: 7),
        HeroStat(life: 65_000, atk: 3300, atkspeed: 1, movespeed: 1, reloadTime: 6),
        HeroStat(life: 80_000, atk: 3500, atkspeed: 1.5, movespeed: 2, reloadTime: 5),
        HeroStat(life: 74_000, atk: 2200, atkspeed: 2, movespeed: 1, reloadTime: 4),
        HeroStat(life: 50_000, atk: 4000, atkspeed: 0.7, movespeed: 1, reloadTime: 8),
        HeroStat(life: 25_000, atk: 1000, atkspeed: 1, movespeed: 1, reloadTime: 3),
        HeroStat(life: 60_000, atk: 3300, atkspeed: 1, movespeed: 1, reloadTime: 5),
        HeroStat(life: 65_000, atk: 3600, atkspeed: 1.5, movespeed: 1, reloadTime: 6)
    ]
}

struct HeroStatBaseAction {
    var range: CGFloat// 0 == contact
    var attack: ((Hero) -> ())?
    var contact: ((Hero) -> ())?
    var spawn: ((Hero) -> ())?
    var death: ((Hero) -> ())?
}

extension Hero {
    static let baseAction = [
        HeroStatBaseAction(range: 2, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        //
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        //
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        //
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto),
        HeroStatBaseAction(range: 1, attack: nil, contact: nil,
                           spawn: Hero.spawnProto, death: Hero.deathProto)
    ]
}

class Hero: SKSpriteNode, Side, Creature, Destroyable, Attack, Move, HeroSelectable {
    
    // battle scene ref
    var buildings: UnsafeMutablePointer<[Destroyable]>!
    var heros: UnsafeMutablePointer<[Hero]>!
    //
    
    let textures: [[[SKTexture]]]
    var action: HeroAction = HeroAction.stay
    var direction: HeroDirection = HeroDirection.down
    var face_left: Bool = true
    var side: SideIdentifier
    var life: Int
    var atk: Int
    var atkspeed: TimeInterval
    var movespeed: CGFloat
    var reloadTime: TimeInterval
    let stat: HeroStat // reference
    var baseAction: HeroStatBaseAction
    var death: ((Hero) -> ())?
    
    init(type: HeroType, side: SideIdentifier) {
        self.baseAction = Hero.baseAction[type.rawValue]
        self.death = self.baseAction.death
        self.side = side
        self.textures = HeroTextures.textures![type.rawValue]
        self.stat = Hero.stats[type.rawValue]
        self.life = self.stat.life
        self.atk = self.stat.atk
        self.atkspeed = self.stat.atkspeed
        self.movespeed = self.stat.movespeed
        self.reloadTime = self.stat.reloadTime
        super.init(texture: self.textures[0][0][0], color: UIColor.clear, size: self.textures[0][0][0].size())
        self.setScale(0.5)
        self.baseAction.range = self.baseAction.range * sqrt(pow(self.size.width, 2) + pow(self.size.height, 2))
        
        self.physics_nodeDynamic()
        self.physicsBody!.categoryBitMask = self.side == .enemy ? BodyType.Enemy.rawValue : BodyType.Player.rawValue | BodyType.Hero.rawValue
        self.physicsBody!.collisionBitMask = self.side == .enemy ? BodyType.Player.rawValue : BodyType.Enemy.rawValue
    }
    
    subscript() -> [SKTexture] {
        get {
            return self.textures[self.action.rawValue][self.direction.rawValue]
        }
        // set execute code
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotateIn(direction: CGPoint) {
        let angle = atan2(direction.y - self.position.y, direction.x - self.position.x)
        
        print(angle, self.position, direction)
    }
    
    func animateAttack() -> TimeInterval {
        self.action = .attack
        let frameSpeed = self.atkspeed / TimeInterval(self[].count)
        self.run(SKAction.animate(with: self[], timePerFrame: frameSpeed, resize: true, restore: false))
        return frameSpeed * TimeInterval(self[].count)
    }
    func animateStay() -> TimeInterval {
        self.action = .stay
        let frameSpeed = self.atkspeed / TimeInterval(self[].count)
        self.run(SKAction.animate(with: self[], timePerFrame: frameSpeed, resize: true, restore: false))
        return frameSpeed * TimeInterval(self[].count)
    }
    func animateMove() -> TimeInterval {
        self.action = .move
        let frameSpeed = TimeInterval(self.movespeed) / TimeInterval(self[].count)
        self.run(SKAction.animate(with: self[], timePerFrame: frameSpeed, resize: true, restore: false))
        return frameSpeed * TimeInterval(self[].count)
    }
}

extension Hero {
    func addLabel(to: SKSpriteNode, txt: String) {
        let label = SKLabelNode(fontNamed: "Herculanum")
        
        label.position.y = to.size.height / 2
        label.position.x += CGFloat(Int(arc4random_uniform(50)) - 25)
        label.position.y += CGFloat(Int(arc4random_uniform(50)) - 25)
        label.fontColor = UIColor.green
        label.fontSize = 20
        label.text = txt
        to.addChild(label)
        label.run(SKAction.fadeAlpha(to: 0.0, duration: 1), completion: {
            label.removeFromParent()
        })
    }
}







