//
//  HeroPresentScene.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 26/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

class HeroPresentScene: SKScene {
    let layout: Layout
    var save: Saver
    let heroPresent: HeroPresent
    let ability: AbilityHallow
    let hero: HeroSaved
    
    init(layout: Layout, save: Saver, hero: HeroSaved) {
        self.hero = hero
        self.layout = layout
        self.save = save
        self.heroPresent = HeroPresent(hero: hero)
        
        self.heroPresent.setScale(1.8)
        self.save.save(byWritingAt: self.layout.documents_save)
        self.ability = AbilityHallow(size: CGSize.init(width: layout.size.width, height: self.heroPresent.size.width / 1.2), save: hero)
        super.init(size: layout.size)
        self.backgroundColor = UIColor.black
        self.run(fx.fx_clickButton)
        self.addChild(self.heroPresent)
        self.addChild(self.ability)
        // pos
        self.heroPresent.position = CGPoint(x: self.heroPresent.size.width * 1.2 / 2,
                                            y: self.layout.size.height - self.heroPresent.size.height / 2)
        self.ability.position = CGPoint(x: self.layout.center.x,
                                        y: self.heroPresent.position.y - (self.heroPresent.size.height / 2) - self.ability.spriteL.size.height / 2)
        self.DrawValues()
        
    }
    deinit {
        self.removeAllActions()
        self.removeAllChildren()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = HeroScene(layout: self.layout, save: self.save)
        
        self.view?.presentScene(scene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HeroPresent: SKSpriteNode {
    
    let heroSprite: SKSpriteNode
    static let frameTexture = SKTexture(imageNamed: "frame")
    static let frameShinyTexture = SKTexture(imageNamed: "frame_shiny")
    static let particuleCommon = SKTexture(imageNamed: "commonP")
    static let particuleRare = SKTexture(imageNamed: "rareP")
    static let particuleEpic = SKTexture(imageNamed: "epicP")
    static let particuleShiny = SKTexture(imageNamed: "shinyP")
    let frameSprite: SKSpriteNode
    let frameLabel: SKLabelNode
    let emmiter: SKEmitterNode
    
    init(hero: HeroSaved) {
        var tex: SKTexture!
        
        self.emmiter = SKEmitterNode(fileNamed: "present.sks")!
        self.emmiter.name = "present"
        
        switch hero.rarity {
        case .common:
            tex = WireScene.commonTexture
            self.emmiter.particleTexture = HeroPresent.particuleCommon
        case .rare:
            tex = WireScene.rareTexture
            self.emmiter.particleTexture = HeroPresent.particuleRare
        case .epic:
            tex = WireScene.epicTexture
            self.emmiter.particleTexture = HeroPresent.particuleEpic
        case .shiny:
            tex = WireScene.shinyTexture
            self.emmiter.particleTexture = HeroPresent.particuleShiny
        }
        let size = tex.size() / 2
        if hero.rarity == Rarity.shiny {
            self.frameSprite = SKSpriteNode(texture: HeroPresent.frameShinyTexture,
                                            color: UIColor.clear,
                                            size: CGSize(width: size.width * 1.2, height: size.width / 3))
        }
        else {
            self.frameSprite = SKSpriteNode(texture: HeroPresent.frameTexture,
                                            color: UIColor.clear,
                                            size: CGSize(width: size.width, height: size.width / 3.3))
        }
        self.heroSprite = SKSpriteNode(texture: HeroTextures.big_icon[hero.type.rawValue])
        self.heroSprite.size = size * 0.9
        self.heroSprite.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.heroSprite.position = CGPoint(x: 0, y: -(size.height / 2) + self.frameSprite.size.height / 4)
        self.frameSprite.position = self.heroSprite.position
        self.frameSprite.zPosition = 2
        self.heroSprite.zPosition = 1
        self.frameLabel = SKLabelNode(fontNamed: "Herculanum")
        self.frameLabel.fontColor = UIColor.black
        self.frameLabel.position = self.frameSprite.position
        self.frameLabel.text = HeroTextures.textures_init[hero.type.rawValue].1
        self.frameLabel.zPosition = 3
        self.frameLabel.fontSize = 10
        self.frameLabel.verticalAlignmentMode = .center
        self.frameLabel.horizontalAlignmentMode = .center
        self.emmiter.position = self.frameLabel.position
        super.init(texture: tex, color: UIColor.clear, size: size)
        self.addChild(self.heroSprite)
        self.addChild(self.frameSprite)
        self.addChild(self.frameLabel)
        self.addChild(self.emmiter)
        self.heroSprite.run(SKAction.repeatForever(SKAction.sequence([
                SKAction.scaleY(to: 0.95, duration: 2),
                SKAction.scaleY(to: 1, duration: 2)
            ])))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class HallowSprite: SKNode {
    
    let spriteL: SKSpriteNode
    let spriteR: SKSpriteNode
    private static let spriteTexture = SKTexture(imageNamed: "hallow_bkg")
    
    init(size: CGSize) {
        self.spriteL = SKSpriteNode(texture: HallowSprite.spriteTexture)
        self.spriteR = SKSpriteNode(texture: HallowSprite.spriteTexture)
        super.init()
        self.spriteL.size = CGSize(width: size.width / 2, height: size.height)
        self.spriteR.size = self.spriteL.size
        self.spriteL.anchorPoint = CGPoint(x: 1, y: 0.5)
        self.spriteR.anchorPoint = CGPoint(x: 1, y: 0.5)
        self.spriteR.xScale = self.spriteR.xScale * -1
        self.addChild(self.spriteR)
        self.addChild(self.spriteL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

class AbilityHallow: HallowSprite {
    
    let sprite: SKSpriteNode
    let spriteName: SKLabelNode
    let descriptionLabel: [SKLabelNode]
    
    init(size: CGSize, save: HeroSaved) {
        
        let spriteSize = size.height / 3
        self.sprite = SKSpriteNode(texture: HeroTextures.ability_icon[save.type.rawValue], color: UIColor.clear,
                                   size: CGSize.init(width: spriteSize, height: spriteSize))
        self.spriteName = SKLabelNode(fontNamed: "Herculanum")
        var descriptionLabel = [SKLabelNode]()
        for (i, txt) in HeroTextures.ability_description[save.type.rawValue].enumerated() {
            let new = SKLabelNode(fontNamed: "Herculanum")
            
            new.text = String(format: txt, arguments: HeroTextures.ability_args[save.type.rawValue][i])
            new.fontSize = 13
            new.fontColor = UIColor.black
            new.verticalAlignmentMode = .center
            new.horizontalAlignmentMode = .center
            descriptionLabel.append(new)
        }
        self.descriptionLabel = descriptionLabel
        super.init(size: size)
        self.sprite.position = CGPoint(x: -self.spriteL.size.width + spriteSize,
                                       y: self.spriteL.size.height / 2 - spriteSize)
        self.spriteName.position = self.sprite.position
        self.spriteName.position.x += self.sprite.size.width / 2
        self.spriteName.text = HeroTextures.ability_name[save.type.rawValue]
        self.spriteName.fontColor = UIColor.gray
        self.spriteName.horizontalAlignmentMode = .left
        self.spriteName.verticalAlignmentMode = .center
        self.spriteName.fontSize = 23
        
        
        self.addChild(self.spriteName)
        self.addChild(self.sprite)
        var labelY: CGFloat = self.sprite.position.y - self.sprite.size.height / 1.5
        
        for label in self.descriptionLabel {
            label.position.y = labelY
            labelY -= 15
            self.addChild(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HeroPresentScene {
    func DrawValues() {
        let ystart = self.frame.height - (self.heroPresent.size.height / 4)
        let xpos = self.heroPresent.position.x + self.heroPresent.size.width / 2 + 30
        
        let atk = HeroValue(texture: HeroValue.atkTexture, value: Hero.stats[self.hero.type.rawValue].atk, time: nil)
        atk.position = CGPoint(x: xpos, y: ystart)
        let atkspeed = HeroValue(texture: HeroValue.atkspeedTexture, value: nil, time: CGFloat(Hero.stats[self.hero.type.rawValue].atkspeed))
        atkspeed.position = atk.position
        atkspeed.position.y -= 50
        let life = HeroValue(texture: HeroValue.lifeTexture, value: Hero.stats[self.hero.type.rawValue].life, time: nil)
        life.position = atkspeed.position
        life.position.y -= 50
        let movespeed = HeroValue(texture: HeroValue.moveTexture, value: nil, time: Hero.stats[self.hero.type.rawValue].movespeed)
        movespeed.position = life.position
        movespeed.position.y -= 50
        let time = HeroValue(texture: HeroValue.sandboxTexture, value: Int(Hero.stats[self.hero.type.rawValue].reloadTime), time: nil)
        time.position = movespeed.position
        time.position.y -= 50                   
        self.addChild(atk)
        self.addChild(atkspeed)
        self.addChild(life)
        self.addChild(movespeed)
        self.addChild(time)
    }
}

extension Formatter {
    static let valueDisplay: Formatter = {
        let form = NumberFormatter()
        form.groupingSeparator = " "
        form.numberStyle = .decimal
        return form
    }()
}
extension Int {
    var displayable: String {
        return Formatter.valueDisplay.string(for: self) ?? ""
    }
}

class HeroValue: SKSpriteNode {
    
    static let atkTexture = SKTexture(imageNamed: "ico_attack")
    static let atkspeedTexture = SKTexture(imageNamed: "ico_attackspeed")
    static let lifeTexture = SKTexture(imageNamed: "ico_hp")
    static let moveTexture = SKTexture(imageNamed: "ico_movespeed")
    static let sandboxTexture = SKTexture(imageNamed: "ico_sandclock")
    static let frameT = SKTexture(imageNamed: "button_bkg_gray")
    let label: SKLabelNode
    let frameLabel: SKSpriteNode
    
    init(texture: SKTexture, value: Int?, time: CGFloat?) {
        self.label = SKLabelNode(fontNamed: "Herculanum")
        self.frameLabel = SKSpriteNode(texture: HeroValue.frameT, color: UIColor.clear, size: HeroValue.frameT.size())
        self.frameLabel.zPosition = -1
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        if let value = value {
            self.label.text = value.displayable
        }
        else if let time = time {
            self.label.text = "\(time)"
        }
        self.label.fontColor = UIColor.white
        self.label.verticalAlignmentMode = .center
        self.label.horizontalAlignmentMode = .left
        self.label.fontSize = 23
        self.addChild(self.label)
        self.setScale(0.5)
        self.label.position.x += 50
        self.frameLabel.position.x += 50
        self.addChild(self.frameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
























