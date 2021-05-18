//
//  AffineCipherAlgorithm.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 20/10/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import Foundation

final class AffineCipherAlgorithm: CypherAlgorithm {
    
    private let keyA: Int
    private let keyB: Int
    
    init(keyA: Int,
         keyB: Int) {
        self.keyA = keyA
        self.keyB = keyB
    }
    
    func encrypt(_ text: String) throws -> String {
        let text = text.uppercased()

        var result: String = ""
        for i in 0...text.unicodeScalars.count - 1 {
            let textLetter = String(text[i])
            guard let textLetterUcs = UnicodeScalar(textLetter) else { throw CypherError.invalidInput }

            result += encodeLetter(ucs: textLetterUcs)
        }

        return result
    }
       
    func decrypt(_ text: String) throws -> String {
        let text = text.uppercased()

        var result: String = ""
        for i in 0...text.unicodeScalars.count - 1 {
            let textLetter = String(text[i])
            guard let textLetterUcs = UnicodeScalar(textLetter) else { throw CypherError.invalidInput }

            result += decodeLetter(ucs: textLetterUcs)
        }

        return result
    }

    private func encodeLetter(ucs: UnicodeScalar) -> String {
        let firstLetter = Int(UnicodeScalar("A").value)
        let lastLetter = Int(UnicodeScalar("Z").value)
        let letterCount = lastLetter - firstLetter + 1
        let value = Int(ucs.value)
        switch value {
        case firstLetter...lastLetter:
            var offsetValue = value - firstLetter
            offsetValue = ((offsetValue % letterCount) * keyA + keyB) % letterCount
            return String(UnicodeScalar(firstLetter + offsetValue)!)
        default:
            return String(ucs)
        }
    }

    private func decodeLetter(ucs: UnicodeScalar) -> String {
        let firstLetter = Int(UnicodeScalar("A").value)
        let lastLetter = Int(UnicodeScalar("Z").value)
        let letterCount = lastLetter - firstLetter + 1
        let value = Int(ucs.value)
        switch value {
        case firstLetter...lastLetter:
            var offsetValue = value - firstLetter
            
            offsetValue = (keyA.modInv(letterCount)) * (offsetValue - keyB) % letterCount
            return String(UnicodeScalar(firstLetter + offsetValue)!)
        default:
            return String(ucs)
        }
    }
}

public extension BinaryInteger {
    @inlinable
    func modInv(_ mod: Self) -> Self {
        var (m, n) = (mod, self)
        var (x, y) = (Self(0), Self(1))
 
        while n != 0 {
            (x, y) = (y, x - (m / n) * y)
            (m, n) = (n, m % n)
        }
 
        while x < 0 {
            x += mod
        }
 
        return x
    }
}
