//
//  Saver.swift
//  Clash Hero
//
//  Created by Antoine FeuFeu on 26/01/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

struct HeroSaved {
    var type: HeroType
    var rarity: Rarity
    var abilityLevel: Int
    
    static let zero = HeroSaved(type: .barbeShiny, rarity: .shiny, abilityLevel: 1)
}

struct Saver {
    var soulStoneCount: Int
    var heroCount: Int
    var heros: [HeroSaved]
    var heroSelected: [Int]
    
    init() {
        self.soulStoneCount = 150_000
        self.heroCount = 4
        self.heros = [
            HeroSaved.init(type: .demon, rarity: .rare, abilityLevel: 1),
            HeroSaved.init(type: .ingenieur, rarity: .common, abilityLevel: 1),
            HeroSaved.init(type: .tireurelite, rarity: .common, abilityLevel: 1),
            HeroSaved.init(type: .marauder, rarity: .common, abilityLevel: 1)
        ]
        self.heroSelected = [0, 1, 2, 3]
    }
    
    init(byReadingAt path: String) {
        guard let file = FileHandle.init(forReadingAtPath: path) else {
            fatalError()
        }
        let soulstone = file.readData(ofLength: MemoryLayout<Int>.size)
        let herocount = file.readData(ofLength: MemoryLayout<Int>.size)
        
        self.soulStoneCount = 0
        self.heroCount = 0
        if soulstone.copyBytes(to: UnsafeMutableBufferPointer.init(start: &self.soulStoneCount, count:  MemoryLayout<Int>.size))
            !=  MemoryLayout<Int>.size {
            fatalError()
        }
        if herocount.copyBytes(to: UnsafeMutableBufferPointer.init(start: &self.heroCount, count:  MemoryLayout<Int>.size))
            !=  MemoryLayout<Int>.size {
            fatalError()
        }
        if self.heroCount != 0 {
            self.heros = Array(repeating: HeroSaved.zero, count: self.heroCount)
            let size = MemoryLayout<HeroSaved>.size * self.heroCount
            let dataHeros = file.readData(ofLength: size)
            
            if dataHeros.copyBytes(to: UnsafeMutableBufferPointer.init(start: &self.heros, count: size)) != size {
                fatalError()
            }
        }
        else {
            self.heros = []
        }
        let selecSize = MemoryLayout<Int>.size * 4
        let selected = file.readData(ofLength: selecSize)
        self.heroSelected = Array(repeating: 0, count: 4)
        if selected.copyBytes(to: UnsafeMutableBufferPointer.init(start: &self.heroSelected, count: selecSize)) != selecSize {
            fatalError()
        }
    }
    
    mutating func save(byWritingAt path: String) {
        guard let up = FileHandle.init(forUpdatingAtPath: path) else {
            fatalError()
        }
        up.truncateFile(atOffset: 0)
        up.closeFile()
        guard let file = FileHandle.init(forWritingAtPath: path) else {
            fatalError()
        }
        file.write(Data.init(bytesNoCopy: &self.soulStoneCount, count: MemoryLayout<Int>.size, deallocator: .none))
        self.heroCount = self.heros.count
        file.write(Data.init(bytesNoCopy: &self.heroCount, count: MemoryLayout<Int>.size, deallocator: .none))
        file.write(Data.init(bytesNoCopy: &self.heros,
                             count: MemoryLayout<HeroSaved>.size * self.heroCount, deallocator: .none))
        file.write(Data.init(bytesNoCopy: &self.heroSelected, count: MemoryLayout<Int>.size * 4, deallocator: .none))
        file.closeFile()
    }
}
