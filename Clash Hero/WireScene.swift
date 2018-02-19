//
//  WireScene.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 26/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

enum Rarity {
    case common
    case rare
    case epic
    case shiny
}

class WireScene: SKScene {
    
    static let presentTexture = SKTexture(imageNamed: "hero_card_0")
    static let commonTexture = SKTexture(imageNamed: "hero_bk_common")
    static let rareTexture = SKTexture(imageNamed: "hero_bk_rare")
    static let epicTexture = SKTexture(imageNamed: "hero_bk_epic")
    static let shinyTexture = SKTexture(imageNamed: "hero_bk_shiny")
    static let button = SKTexture(imageNamed: "quest-hero")
    static let textFrame = SKTexture(imageNamed: "name")
    static let battleTexture = SKTexture(imageNamed: "battle")
    static let houseTexture = SKTexture(imageNamed: "house")
    static let soulstone = SKTexture(imageNamed: "soulstone")
    
    let bkSprite: SKSpriteNode // background
    let wireButton: SKSpriteNode // button
    let wiredHero: SKSpriteNode // hero
    let textframe: SKSpriteNode // frame for text
    let textframeLabel: SKLabelNode
    let actionNode: SKNode
    let emiter: SKEmitterNode
    let house: SKSpriteNode
    let battle: SKSpriteNode
    let layout: Layout
    var saver: Saver
    let stone: SKSpriteNode
    
    init(layout: Layout, saver: Saver) {
        self.layout = layout
        self.saver = saver
        self.bkSprite = SKSpriteNode(texture: WireScene.presentTexture)
        self.bkSprite.zPosition = 0
        self.wireButton = SKSpriteNode(texture: WireScene.button)
        self.wireButton.size = BattleTextures.headSize
        self.wiredHero = SKSpriteNode(texture: HeroTextures.big_icon[0])
        self.wiredHero.isHidden = true
        self.wiredHero.zPosition = 2
        self.actionNode = SKNode()
        self.actionNode.zPosition = 1
        self.emiter = SKEmitterNode(fileNamed: "wire.sks")!
        self.emiter.isHidden = true
        self.actionNode.addChild(self.emiter)
        self.textframe = SKSpriteNode(texture: WireScene.textFrame)
        self.textframeLabel = SKLabelNode(fontNamed: "Herculanum")
        self.house = SKSpriteNode(texture: WireScene.houseTexture)
        self.house.size = BattleTextures.headSize
        self.battle = SKSpriteNode(texture: WireScene.battleTexture)
        self.battle.size = BattleTextures.headSize
        self.stone = SKSpriteNode(texture: WireScene.soulstone)
        super.init(size: layout.size)
        self.backgroundColor = UIColor.black
        self.bkSprite.position = CGPoint.init(x: layout.center.x, y: self.frame.maxY - self.bkSprite.size.height / 2)
        self.textframe.position = CGPoint(x: layout.center.x, y: self.frame.maxY - (self.bkSprite.size.height))
        self.textframe.isHidden = true
        self.textframe.zPosition = 3
        self.wiredHero.position = self.bkSprite.position
        self.actionNode.position = self.bkSprite.position
        self.wiredHero.position.y -= 9
        self.textframeLabel.position = self.textframe.position
        self.textframeLabel.position.y += 60
        self.textframeLabel.text = "15"
        self.textframeLabel.zPosition = 4
        self.textframeLabel.horizontalAlignmentMode = .center
        self.textframeLabel.verticalAlignmentMode = .bottom
        self.textframeLabel.fontColor = UIColor.black
        self.textframeLabel.fontSize = 27
        self.stone.position = self.textframeLabel.position
        self.stone.position.x += 40
        self.stone.position.y += 13
        self.wireButton.position = CGPoint(x: layout.center.x, y: self.textframe.position.y - self.textframe.size.height)
        self.battle.position = CGPoint(x: self.battle.size.width / 2, y: self.battle.size.height / 2)
        self.house.position = CGPoint(x: layout.size.width - self.house.size.width / 2, y: self.house.size.height / 2)
        self.addChild(self.textframeLabel)
        self.addChild(self.bkSprite)
        self.addChild(self.wireButton)
        self.addChild(self.wiredHero)
        self.addChild(self.actionNode)
        self.addChild(self.textframe)
        self.addChild(self.house)
        self.addChild(self.battle)
        self.addChild(self.stone)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    deinit {
        self.removeAllActions()
        self.removeAllChildren()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        if self.house.contains(location) {
            return self.loadHeroScene()
        }
        if self.battle.contains(location) {
            return self.loadBattleScene()
        }
        if self.wireButton.contains(location) {
            self.textframeLabel.position = self.textframe.position
            self.stone.isHidden = true
            self.bkSprite.run(fx.fx_getHero)
            self.textframe.isHidden = false
            let type = WireScene.wire()
            
            self.bkSprite.texture = type.1
            self.wiredHero.isHidden = false
            self.wiredHero.setScale(0)
            self.wiredHero.run(SKAction.scale(to: 1, duration: 0.3))
            self.wiredHero.texture = HeroTextures.big_icon[type.0.rawValue]
            self.textframeLabel.text = HeroTextures.textures_init[type.0.rawValue].1
            self.wireButton.run(SKAction.group([
                    SKAction.scaleX(to: 0.9, duration: 0.1),
                    SKAction.scaleY(to: 0.9, duration: 0.1)
                ]), completion: {
                    self.wireButton.run(SKAction.group([
                        SKAction.scaleX(to: 1, duration: 0.1),
                        SKAction.scaleY(to: 1, duration: 0.1)
                        ]))
            })
            self.wireAnimate(fileNamed: type.2)
            self.CheckingForAddingHero(type: type.0, rarity: type.3)
            if type.3 == Rarity.shiny {
                self.run(fx.fx_getHeroShiny)
            }
        }
    }
    
    func loadBattleScene() {
        let battle = BattleScene(layout: self.layout, save: self.saver)
        let transition = SKTransition.fade(withDuration: 1)
        
        self.run(fx.fx_GoBattle)
        self.view?.presentScene(battle, transition: transition)
    }
    
    func loadHeroScene() {
        let scene = HeroScene(layout: self.layout, save: self.saver)
        let transition = SKTransition.fade(withDuration: 1)
        
        self.run(fx.fx_clickButton)
        self.view?.presentScene(scene, transition: transition)
    }
    
    func CheckingForAddingHero(type: HeroType, rarity: Rarity) {
        
        var gotit: Bool = false
        
        for h in self.saver.heros {
            if h.type.rawValue == type.rawValue {
                gotit = true
                break
            }
        }
        if gotit == false {
            self.saver.heros.append(HeroSaved.init(type: type, rarity: rarity, abilityLevel: 1))
            self.saver.heroCount += 1
        }
    }
    
}

extension WireScene {
    
    func wireAnimate(fileNamed: String) {
        let eclat = SKSpriteNode(imageNamed: fileNamed + "E")
        let eclatActionScale = SKAction.scale(to: 2.5, duration: 0.5)
        let eclatActionRotate = SKAction.rotate(byAngle: 2, duration: 0.5)
        
        eclat.setScale(0)
        eclatActionScale.timingMode = .easeIn
        eclatActionRotate.timingMode = .easeInEaseOut
        self.actionNode.addChild(eclat)
        eclat.run(SKAction.group([
                eclatActionRotate, eclatActionScale
            ]), completion: {
                eclat.run(SKAction.group([
                    eclatActionRotate, SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    ]), completion: {
                        eclat.removeFromParent()
                })
        })
        //
        let flash = SKSpriteNode(imageNamed: fileNamed + "F")
        
        flash.position.y -= 42
        flash.alpha = 0.3
        flash.yScale = 0.3
        flash.xScale = 0.8
        self.actionNode.addChild(flash)
        flash.run(SKAction.group([
                SKAction.scaleX(to: 3, duration: 0.3),
                SKAction.scaleY(to: 3, duration: 0.3)
            ]), completion: {
                flash.run(SKAction.fadeAlpha(to: 0.0, duration: 0.3), completion: {
                    flash.removeFromParent()
                })
        })
        //
        self.emiter.particleTexture = SKTexture(imageNamed: fileNamed + "P")
        self.emiter.resetSimulation()
        self.emiter.isHidden = false
    }
    
}

extension WireScene {
    static func wire() -> (HeroType, SKTexture, String, Rarity) {
        let r = arc4random_uniform(100)
        
        switch r {
        case 0...50:
            return (randomIn([.sorciergivre, .tireurelite, .ingenieur, .marauder]), WireScene.commonTexture, "common", .common)
        case 50...80:
            return (randomIn([.bourreau, .demon, .reine, .assasin, .loup]), WireScene.rareTexture, "rare", .rare)
        case 80...95:
            let rr = arc4random_uniform(100)
            
            switch rr {
            case 0...50:
                return (randomIn([.fantome, .cupid, .dracula, .valentina, .medusia]), WireScene.epicTexture, "epic", .epic)
            case 50...80:
                return (randomIn([.skeletaur, .perenoel, .barbe, .belier, .ducilia]), WireScene.epicTexture, "epic", .epic)
            default:
                return (randomIn([.moltanica, .artica, .voltanica, .citrouille]), WireScene.epicTexture, "epic", .epic)
            }
        default:
            let rr = arc4random_uniform(100)
            
            switch rr {
            case 0...50:
                return (randomIn([.fantomeShiny, .cupidShiny, .draculaShiny, .valentinaShiny, .medusiaShiny]), WireScene.shinyTexture, "shiny",
                    .shiny)
            case 50...80:
                return (randomIn([.skeletaurShiny, .perenoelShiny, .barbeShiny, .belierShiny, .duciliaShiny]), WireScene.shinyTexture, "shiny",
                    .shiny)
            default:
                return (randomIn([.moltanicaShiny, .articaShiny, .voltanicaShiny, .citrouilleShiny]), WireScene.shinyTexture, "shiny",
                    .shiny)
            }
        }
    }
}
