//
//  UILabel+YJExtension.swift
//  YJPublicSDK_Extension
//
//  Created by YJ on 2025/9/2.
//

import UIKit


public extension UILabel {
    
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    func font(_ fontSize: CGFloat, weight: UIFont.Weight = .regular) -> Self {
        self.font = .systemFont(ofSize: fontSize, weight: weight)
        return self
    }
    
    func textColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    func textAlignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
    func numberOfLines(_ lines: Int) -> Self {
        self.numberOfLines = lines
        return self
    }
    
}
