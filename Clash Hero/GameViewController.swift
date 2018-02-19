//
//  GameViewController.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 24/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var layout: Layout!
    var saver: Saver!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = HeroTextures()
        
        
        if let view = self.view as! SKView? {
            self.layout = Layout(size: view.frame.size)
            if FileManager.default.fileExists(atPath: self.layout.documents_save) == false {
                FileManager.default.createFile(atPath: self.layout.documents_save, contents: nil, attributes: nil)
                self.saver = Saver()
                self.saver.save(byWritingAt: self.layout.documents_save)
            }
            else {
                self.saver = Saver(byReadingAt: self.layout.documents_save)
            }
            //let scene = BattleScene(layout: self.layout)
            let scene = WireScene(layout: self.layout, saver: self.saver)
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.presentScene(scene)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
