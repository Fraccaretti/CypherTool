//
//  PlayfairCipherAlgorithm.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 26/01/2020.
//  Copyright © 2020 Piotr Fraccaro. All rights reserved.
//

import Foundation

final class PlayfairCipher: CypherAlgorithm {
    
    
    func encrypt(_ text: String) throws -> String {
        <#code#>
    }
    
    func decrypt(_ text: String) throws -> String {
        <#code#>
    }
    
    func getMatrix(forText text: String) -> [[Character]] {
        var charsArray: [[Character]] = [[]]
        let firstLetter = Int(UnicodeScalar("A").value)
        let lastLetter = Int(UnicodeScalar("Z").value)
        
        for i in 0..<5 {
            for j in 0..<5 {
                var index = i * 5 + j
                
            }
        }
    }
}
