//
//  CypherAlgorithmsConstants.swift
//  CipherTool
//
//  Created by Piotr Fraccaro on 29/09/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import Foundation

class CypherAlgorithmsConstants {
    
    static let availableAlgorithmsNames: [String] = ["Caesar", "Vigenère", "Affine", "Playfair"]
    static let caesarShiftsCount: Int = 26
}

enum AvailableCypherAlgorithm: String {
    case caesar = "Caesar"
    case vigenere = "Vigenère"
    case affine = "Affine"
    case playfair = "Playfair"
}
