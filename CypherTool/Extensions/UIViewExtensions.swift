//
//  UIViewExtensions.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 29/09/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundCorners(withMultiplier multiplier: CGFloat) {
        self.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height * multiplier
    }
    
    func setOutlinedStyle(withBorderWidth width: CGFloat, borderColor: UIColor) {
        self.layer.masksToBounds = true
        self.layer.borderWidth = width
        self.layer.borderColor = borderColor.cgColor
    }
}
