//
//  CypherAlgorithm.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 29/09/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import Foundation

protocol CypherAlgorithm {
    
    func encrypt(_ text: String) throws -> String
    func decrypt(_ text: String) throws -> String
}
