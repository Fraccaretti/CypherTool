//
//  UIFontExtensions.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 29/09/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import UIKit

enum FontStyle: String {
    case bold = "HelveticaNeue-Bold"
    case regular = "HelveticaNeue-Regular"
    case italic = "HelveticaNeue-Italic"
    case light = "HelveticaNeue-Light"
}

extension UIFont {
    
    static func getAppFont(withSize size: CGFloat, style: FontStyle) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
