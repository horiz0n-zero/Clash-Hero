//
//  HeroTextures.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 24/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public struct HeroTextures {
    
    static let textures_init = [
        // MARK: Commun
        ("anye_0", "tireur d'elite", [5, 5, 7]),
        ("sage_0", "sorciere de givre", [5, 5, 7]),
        ("predator_0", "maraudeur", [5, 5, 5]),
        ("engineer_0", "ingenieur", [7, 5, 5]),
        // MARK: Rare
        ("wolfman_0", "loup garou", [5, 5, 5]),
        ("nightkiller_0", "assasin", [5, 5, 6]),
        ("najia_0", "reine serpent", [5, 5, 7]),
        ("hanbing_0", "demon des glaces", [5, 5, 6]),
        ("gladiator_0", "bourreau", [5, 5, 6]),
        // MARK: Epic
        ("doubledragon_0", "voltanica", [7, 7, 7]), //
        ("xxg_0", "dracula", [7, 7, 7]), //
        ("qiubite_0", "cupid", [7, 7, 7]), //
        ("qrjfs_0", "valentina", [7, 7, 7]), //
        ("stlong_0", "moltanica", [7, 7, 7]), //
        ("zhongjia_0", "belier", [7, 7, 7]), //
        ("ngnw_0", "ducilia", [7, 7, 7]), //
        ("meidusha_0", "medusia", [7, 7, 7]),
        ("icedragon_0", "artica", [7, 7, 7]), //
        ("chuan_0", "barbe blanche", [5, 5, 6]), //
        ("skeletonking_0", "skeletaur", [7, 7, 7]), //
        ("deathking_0", "roi fantome", [7, 7, 6]), //
        ("nangua_0", "citrouille", [5, 5, 6]), //
        ("santa_0", "pere noel", [7, 7, 7]), //
        // MARK: Shiny
        ("doubledragon_2", "voltanica foudroyant", [7, 7, 7]),
        ("xxg_2", "joke dracula", [7, 7, 7]),
        ("qiubite_2", "cupid des bois", [7, 7, 7]),
        ("qrjfs_2", "valentina glacee", [7, 7, 7]),
        ("stlong_2", "moltanica ancien", [7, 7, 7]),
        ("zhongjia_2", "belier rockeur", [7, 7, 7]),
        ("ngnw_2", "reine ducilia", [7, 7, 7]),
        ("meidusha_2", "meduse", [7, 7, 7]),
        ("icedragon_2", "dragon boisé", [7, 7, 7]),
        ("chuan_2", "poulpe blanc", [7, 7, 6]),
        ("skeletonking_2", "skeletaur spartiate", [7, 7, 7]),
        ("deathking_2", "roi des lanternes", [7, 7, 7]),
        ("nangua_2", "star citrouille", [7, 7, 7]),
        ("santa_2", "papa noel", [7, 7, 9])
    ]
    static let ability_args: [[[CVarArg]]] = [
        [[150, 3]],
        [[100], [25, 3]],
        [[20]],
        [[300]],
        //
        [[3, 35], [5]],
        [[400]],
        [[5], [3, 100]],
        [[25], [3]],
        [[300]],
        //
        [[5, 1500], [80, 10], [5]],
        [[]],
        [[60], [5]],
        [[], [1, 5]],
        [[], [150], [90], [5, 6]],
        [[]],
        [[300, 5], [2], [], [4]],
        [[2], [150, 100]],
        [[2], [10]],
        [[2, 70], [150, 5], [3]],
        [[500, 8], [15000], [10]],
        [[230], [1]],
        [[45], [6]],
        [[900], [3, 5]],
        //
        [[5, 1500], [80, 10], [5]],
        [[]],
        [[60], [5]],
        [[], [1, 5]],
        [[], [150], [90], [5, 6]],
        [[]],
        [[300, 5], [2], [], [4]],
        [[2], [150, 100]],
        [[2], [10]],
        [[2, 70], [150, 5], [3]],
        [[500, 8], [15000], [10]],
        [[230], [1]],
        [[45], [6]],
        [[900], [3, 5]]
    ]
    static let ability_description: [[String]] = [
        ["inflige %d%% atk a %d cibles proche"],
        ["inflige %d%% atk a une cible proche,", "reduit sa vit atk de %d%% pendant %d secondes"],
        ["reduit les degats recu de %d%%"],
        ["inflige %d%% atk a une cible aleatoire"],
        //
        ["pendant %d secondes, augmente vit atk de %d%%", "recuperation %d secondes"],
        ["inflige %d%% atk a une cible en face"],
        ["pendant %d secondes, empoisone les enemies", "leur infligeant %d%% de leur pv total et %d%% atk"],
        ["reduit vit akt et vit dep de %d%%", "a tout les enemies pendant %d secondes"],
        ["inflige %d%% atk a tout les cibles dans une zone"],
        //
        ["pendant %d secondes inflige un total de %d%% atk", "augmente son esquive de %d%% et recupere %d%% de pv", "recuperation %d secondes"],
        ["convoque des chauve souris"],
        ["monte l energie au max et augmente de %d%% atk", "de tout les alliers recuperation %d secondes"],
        ["tous les heros allier proche beneficie de", "+1 d energie toutes les %d secondes durant %d secondes"],
        ["crache le feu destructeur sur ses enemies", "leur infligeant %d%% atk et reduisant", "atk, vit atk et vit dep par %d%%",
         "pendant %d secondes recuperation %d secondes"],
        ["scelle l abilitee d un hero enemie aleatoire"],
        ["inflige %d%% atk a %d enemies aleatoires", "invoque %d ducitrouilles", "les ducitrouilles reduisent l energie de 1",
         "recuperation %d secondes"],
        ["petrifie pendant %d secondes un enemie aleatoire", "causant %d atk et recupere %d%% atk de ses pv"],
        ["gel les enemies en face pendant %d secondes", "causant %d%% de deg des pv total"],
        ["pendant %d secondes reduit les deg recu de %d%%", "et inflige %d%% atk a %d cibles aleatoires", "recuperation %d secondes"],
        ["augmente atk de %d%% pendant %d secondes", "et limite les degats recu par %d", "recuperation %d secondes"],
        ["inflige %d%% atk a une cible proche", "et reduit son energie de %d"],
        ["augment atk, vit atk, vit dep de %d%%", "pendant %d secondes"],
        ["inflige %d%% atk sur une zone aleatoire", "pendant %d secondes recuperation %d secondes"],
        //
        ["pendant %d secondes inflige un total de %d%% atk", "augmente son esquive de %d%% et recupere %d%% de pv", "recuperation %d secondes"],
        ["convoque des chauve souris"],
        ["monte l energie au max et augmente de %d%% atk", "de tout les alliers recuperation %d secondes"],
        ["tous les heros allier proche beneficie de", "+1 d energie toutes les %d secondes durant %d secondes"],
        ["crache le feu destructeur sur ses enemies", "leur infligeant %d%% atk et reduisant", "atk, vit atk et vit dep par %d%%",
         "pendant %d secondes recuperation %d secondes"],
        ["scelle l abilitee d un hero enemie aleatoire"],
        ["inflige %d%% atk a %d enemies aleatoires", "invoque %d ducitrouilles", "les ducitrouilles reduisent l energie de 1",
         "recuperation %d secondes"],
        ["petrifie pendant %d secondes un enemie aleatoire", "causant %d atk et recupere %d%% atk de ses pv"],
        ["gel les enemies en face pendant %d secondes", "causant %d%% de deg des pv total"],
        ["pendant %d secondes reduit les deg recu de %d%%", "et inflige %d%% atk a %d cibles aleatoires", "recuperation %d secondes"],
        ["augmente atk de %d%% pendant %d secondes", "et limite les degats recu par %d", "recuperation %d secondes"],
        ["inflige %d%% atk a une cible proche", "et reduit son energie de %d"],
        ["augment atk, vit atk, vit dep de %d%%", "pendant %d secondes"],
        ["inflige %d%% atk sur une zone aleatoire", "pendant %d secondes recuperation %d secondes"]
    ]
    static let ability_name: [String] = [
        "Fleches fendeuse",
        "Eclat givrant",
        "Technique",
        "Plan B",
        //
        "Enrage",
        "Coup bas",
        "Empoisonement",
        "Brouillard",
        "Choc",
        //
        "Haute tension",
        "Appel",
        "La fleche de cupid",
        "Don d'amour",
        "Souffle destructeur",
        "Scellation",
        "Sinistre Farce",
        "Sortilege",
        "Souffle de givre",
        "Surprise",
        "Vengeance",
        "Lumi eclats",
        "Rite endiablee",
        "Cadeau explosif",//
        "Haute tension",
        "Appel",
        "La fleche de cupid",
        "Don d'amour",
        "Souffle destructeur",
        "Scellation",
        "Sinistre Farce",
        "Sortilege",
        "Souffle de givre",
        "Surprise",
        "Vengeance",
        "Lumi eclats",
        "Rite endiablee",
        "Cadeau explosif"
    ]
    
    
    static let ability_icon: [SKTexture] = [
        SKTexture.init(imageNamed: "121"),
        SKTexture.init(imageNamed: "221"),
        SKTexture.init(imageNamed: "381"),
        SKTexture.init(imageNamed: "201"),
        //
        SKTexture.init(imageNamed: "141"),
        SKTexture.init(imageNamed: "101"),
        SKTexture.init(imageNamed: "401-1"),
        SKTexture.init(imageNamed: "461"),
        SKTexture.init(imageNamed: "21"),
        //
        SKTexture.init(imageNamed: "10007"),
        SKTexture.init(imageNamed: "601"),
        SKTexture.init(imageNamed: "501"),
        SKTexture.init(imageNamed: "981"),
        SKTexture.init(imageNamed: "591"),
        SKTexture.init(imageNamed: "571"),
        SKTexture.init(imageNamed: "10008"),
        SKTexture.init(imageNamed: "10006"),
        SKTexture.init(imageNamed: "961"),
        SKTexture.init(imageNamed: "891"),
        SKTexture.init(imageNamed: "881"),
        SKTexture.init(imageNamed: "10001"),
        SKTexture.init(imageNamed: "441"),
        SKTexture.init(imageNamed: "651"),
        //
        SKTexture.init(imageNamed: "10007"),
        SKTexture.init(imageNamed: "601"),
        SKTexture.init(imageNamed: "501"),
        SKTexture.init(imageNamed: "981"),
        SKTexture.init(imageNamed: "591"),
        SKTexture.init(imageNamed: "571"),
        SKTexture.init(imageNamed: "10008"),
        SKTexture.init(imageNamed: "10006"),
        SKTexture.init(imageNamed: "961"),
        SKTexture.init(imageNamed: "891"),
        SKTexture.init(imageNamed: "881"),
        SKTexture.init(imageNamed: "10001"),
        SKTexture.init(imageNamed: "441"),
        SKTexture.init(imageNamed: "651"),
    ]
    
    static var textures: [[[[SKTexture]]]]? = nil
    static let small_icon: [SKTexture] = [
        SKTexture.init(imageNamed: "311_s"),
        SKTexture.init(imageNamed: "411_s"),
        SKTexture.init(imageNamed: "491_s"),
        SKTexture.init(imageNamed: "401_s"),
        //
        SKTexture.init(imageNamed: "321_s"),
        SKTexture.init(imageNamed: "301_s"),
        SKTexture.init(imageNamed: "511_s"),
        SKTexture.init(imageNamed: "561_s"),
        SKTexture.init(imageNamed: "211_s"),
        //
        SKTexture.init(imageNamed: "1097_s"),
        SKTexture.init(imageNamed: "751_s"),
        SKTexture.init(imageNamed: "661_s"),
        SKTexture.init(imageNamed: "1081_s"),
        SKTexture.init(imageNamed: "731_s"),
        SKTexture.init(imageNamed: "741_s"),
        SKTexture.init(imageNamed: "1098_s"),
        SKTexture.init(imageNamed: "1096_s"),
        SKTexture.init(imageNamed: "1051_s"),
        SKTexture.init(imageNamed: "1021_s"),
        SKTexture.init(imageNamed: "1011_s"),
        SKTexture.init(imageNamed: "1091_s"),
        SKTexture.init(imageNamed: "531_s"),
        SKTexture.init(imageNamed: "781_s"),
        //
        SKTexture.init(imageNamed: "31097_s"),
        SKTexture.init(imageNamed: "30751_s"),
        SKTexture.init(imageNamed: "30661_s"),
        SKTexture.init(imageNamed: "31081_s"),
        SKTexture.init(imageNamed: "30731_s"),
        SKTexture.init(imageNamed: "30741_s"),
        SKTexture.init(imageNamed: "31098_s"),
        SKTexture.init(imageNamed: "31096_s"),
        SKTexture.init(imageNamed: "31051_s"),
        SKTexture.init(imageNamed: "31021_s"),
        SKTexture.init(imageNamed: "31011_s"),
        SKTexture.init(imageNamed: "31091_s"),
        SKTexture.init(imageNamed: "30531_s"),
        SKTexture.init(imageNamed: "30781_s")
    ]
    static let big_icon: [SKTexture] = [
        SKTexture.init(imageNamed: "311"),
        SKTexture.init(imageNamed: "411"),
        SKTexture.init(imageNamed: "491"),
        SKTexture.init(imageNamed: "401"),
        //
        SKTexture.init(imageNamed: "321"),
        SKTexture.init(imageNamed: "301"),
        SKTexture.init(imageNamed: "511"),
        SKTexture.init(imageNamed: "561"),
        SKTexture.init(imageNamed: "211"),
        //
        SKTexture.init(imageNamed: "1097"),
        SKTexture.init(imageNamed: "751"),
        SKTexture.init(imageNamed: "661"),
        SKTexture.init(imageNamed: "1081"),
        SKTexture.init(imageNamed: "731"),
        SKTexture.init(imageNamed: "741"),
        SKTexture.init(imageNamed: "1098"),
        SKTexture.init(imageNamed: "1096"),
        SKTexture.init(imageNamed: "1051"),
        SKTexture.init(imageNamed: "1021"),
        SKTexture.init(imageNamed: "1011"),
        SKTexture.init(imageNamed: "1091"),
        SKTexture.init(imageNamed: "531"),
        SKTexture.init(imageNamed: "781"),
        //
        SKTexture.init(imageNamed: "31097"),
        SKTexture.init(imageNamed: "30751"),
        SKTexture.init(imageNamed: "30661"),
        SKTexture.init(imageNamed: "31081"),
        SKTexture.init(imageNamed: "30731"),
        SKTexture.init(imageNamed: "30741"),
        SKTexture.init(imageNamed: "31098"),
        SKTexture.init(imageNamed: "31096"),
        SKTexture.init(imageNamed: "31051"),
        SKTexture.init(imageNamed: "31021"),
        SKTexture.init(imageNamed: "31011"),
        SKTexture.init(imageNamed: "31091"),
        SKTexture.init(imageNamed: "30531"),
        SKTexture.init(imageNamed: "30781")
    ]
    
    init() {
        HeroTextures.textures = [[[[SKTexture]]]]()
        for i in 0...HeroTextures.textures_init.count - 1 {
            var textures = [[[SKTexture]]]()
            var n: Int = 0
            var s: Int = 0
            
            for action in 1...3 {
                
                var action_textures = [[SKTexture]]()
                s = action * 100
                for directions in 0...4 {
                    n = s + directions * 10
                    let count = HeroTextures.textures_init[i].2[action - 1]
                    var tex = [SKTexture]()
                    
                    for c in 0...count {
                        let add = SKTexture.init(imageNamed: "\(HeroTextures.textures_init[i].0)/\(n + c).png")
                        tex.append(add)
                    }
                    action_textures.append(tex)
                }
                textures.append(action_textures)
            }
            HeroTextures.textures!.append(textures)
        }
        
        
    }
    
}






