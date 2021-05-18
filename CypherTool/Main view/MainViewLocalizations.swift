//
//  MainViewLocalizations.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 29/09/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import Foundation

struct MainViewLocalizations {
    
    let viewControllerTitle: String = "Cypher Tool".localize()
    let inputTextViewPlaceholder: String = "Enter the text you want to encrypt/decrypt here. Only letters will be encrypted!".localize()
    let outputTextViewPlaceholder: String = "You will see encrypted/decrypted text here.".localize()
    let selectAlgorithmText: String = "Select cypher algorithm"
    let encryptText: String = "Encrypt".localize()
    let decryptText: String = "Decrypt".localize()
    let replaceTextsText: String = "Replace texts".localize()
    let invalidInputErrorText: String = "Input can contains letters only.".localize()
    let chooseAlgorithmText: String = "Choose algorithm".localize()
    let chooseShiftText: String = "Choose shift".localize()
    let enterCypherKey: String = "Enter cypher key here".localize()
    let enterCypherKeyA: String = "Key A".localize()
    let enterCypherKeyB: String = "Key B".localize()
    let invalidKeyLenghtMessage: String = "Invalid key lenght".localize()
}

private extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
