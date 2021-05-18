//
//  VigenereCipherAlgorithm.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 06/10/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import Foundation

final class VigenereCipher: CypherAlgorithm {
    
    private let key: String
    
    init(key: String) {
        self.key = key
    }
    
    func encrypt(_ text: String) throws -> String {
        let text = text.uppercased()
        guard key.count == text.count else { throw CypherError.invalidKeyLenght }
    
        var result: String = ""
        for i in 0...text.unicodeScalars.count - 1 {
            let textLetter = String(text[i])
            let keyLetter = String(key[i])
            guard let textLetterUcs = UnicodeScalar(textLetter),
                let keyLetterUcs = UnicodeScalar(keyLetter) else { throw CypherError.invalidInput }
            
            result += encodeLetter(ucs: textLetterUcs, withKeyUcs: keyLetterUcs)
        }
        
        return result
    }
    
    func decrypt(_ text: String) throws -> String {
        let text = text.uppercased()
        guard key.count == text.count else { throw CypherError.invalidKeyLenght }
        
        var result: String = ""
        for i in 0...text.unicodeScalars.count - 1 {
            let textLetter = String(text[i])
            let keyLetter = String(key[i])
            guard let textLetterUcs = UnicodeScalar(textLetter),
                let keyLetterUcs = UnicodeScalar(keyLetter) else { throw CypherError.invalidInput }
            
            result += decodeLetter(ucs: textLetterUcs, withKeyUcs: keyLetterUcs)
        }
        
        return result
    }
    
    private func encodeLetter(ucs: UnicodeScalar, withKeyUcs keyUcs: UnicodeScalar) -> String {
        let firstLetter = Int(UnicodeScalar("A").value)
        let lastLetter = Int(UnicodeScalar("Z").value)
        let letterCount = lastLetter - firstLetter + 1
        let keyValue = Int(keyUcs.value)
        guard firstLetter...lastLetter ~= keyValue else { return String(ucs) }
        
        let value = Int(ucs.value)
        switch value {
        case firstLetter...lastLetter:
            var offsetValue = value - firstLetter
            let offsetKeyValue = keyValue - firstLetter
            offsetValue = ((offsetValue % letterCount) + (offsetKeyValue % letterCount) + letterCount) % letterCount
            return String(UnicodeScalar(firstLetter + offsetValue)!)
        default:
            return String(ucs)
        }
    }
    
    private func decodeLetter(ucs: UnicodeScalar, withKeyUcs keyUcs: UnicodeScalar) -> String {
           let firstLetter = Int(UnicodeScalar("A").value)
           let lastLetter = Int(UnicodeScalar("Z").value)
           let letterCount = lastLetter - firstLetter + 1
           let keyValue = Int(keyUcs.value)
           guard firstLetter...lastLetter ~= keyValue else { return String(ucs) }
           
           let value = Int(ucs.value)
           switch value {
           case firstLetter...lastLetter:
               var offsetValue = value - firstLetter
               let offsetKeyValue = keyValue - firstLetter
               offsetValue = ((offsetValue % letterCount) - (offsetKeyValue % letterCount) + letterCount) % letterCount
               return String(UnicodeScalar(firstLetter + offsetValue)!)
           default:
               return String(ucs)
           }
       }
}
