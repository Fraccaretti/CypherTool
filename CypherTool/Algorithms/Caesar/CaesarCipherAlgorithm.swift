//
//  CaesarCipherAlgorithm.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 29/09/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import Foundation

final class CeasarCipher: CypherAlgorithm {
    
    private let shift: Int
    
    init(shift: Int) {
        self.shift = shift
    }
    
    func encrypt(_ text: String) throws -> String {
        let text = text.uppercased()
        return String(String.UnicodeScalarView(text.unicodeScalars.map { char in
            shiftLetter(ucs: char, by: shift)
        }))
    }
    
    func decrypt(_ text: String) throws -> String {
        let text = text.uppercased()
        return String(String.UnicodeScalarView(text.unicodeScalars.map { char in
            shiftLetter(ucs: char, by: -shift)
        }))
    }
    
    private func shiftLetter(ucs: UnicodeScalar, by shift: Int) -> UnicodeScalar {
        let firstLetter = Int(UnicodeScalar("A").value)
        let lastLetter = Int(UnicodeScalar("Z").value)
        let letterCount = lastLetter - firstLetter + 1

        let value = Int(ucs.value)
        switch value {
        case firstLetter...lastLetter:
            var offset = value - firstLetter
            offset += shift
            offset = (offset % letterCount + letterCount) % letterCount
            return UnicodeScalar(firstLetter + offset)!
        default:
            return ucs
        }
    }
}
