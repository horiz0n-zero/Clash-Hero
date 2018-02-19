//
//  Layout.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 24/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public struct Layout {
    let size: CGSize
    let center: CGPoint
    let documents_save: String
    
    init(size: CGSize) {
        self.size = size
        self.center = CGPoint(x: size.width / 2, y: size.height / 2)
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        self.documents_save = documents.path + "/save.ch"
    }
}
