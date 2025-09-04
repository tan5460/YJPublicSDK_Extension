//
//  UIButton+YJExtension.swift
//  YJPublicSDK_Extension
//
//  Created by YJ on 2025/9/2.
//

import Foundation


public extension UIButton {
    
    func font(_ fontSize: CGFloat, weight: UIFont.Weight = .regular) -> Self {
        self.titleLabel?.font = .systemFont(ofSize: fontSize, weight: weight)
        return self
    }
    
    func title(_ text: String?, color: UIColor?, state: UIControl.State) -> Self {
        self.setTitle(text, for: state)
        if let color = color {
            self.setTitleColor(color, for: state)
        }
        return self
    }
    
    func image(_ image: UIImage?, state: UIControl.State) -> Self {
        self.setImage(image, for: state)
        return self
    }
    
    func backgroundColorImage(_ color: UIColor, state: UIControl.State) -> Self {
        self.setBackgroundImage(UIImage.create(color: color), for: state)
        return self
    }
    
    func horizontalAlignment(_ alignment: UIControl.ContentHorizontalAlignment) -> Self {
        self.contentHorizontalAlignment = alignment
        return self
    }
    
    func verticalAlignment(_ alignment: UIControl.ContentVerticalAlignment) -> Self {
        self.contentVerticalAlignment = alignment
        return self
    }
}

public extension UIButton {
    
    enum ButtonImagePosition {
        case top, bottom, left, right
    }
    
    func setImagePosition(_ position: ButtonImagePosition, spacing: CGFloat = 5) {
        guard let image = imageView?.image, let title = titleLabel?.text else { return }
        
        let imageSize = image.size
        let titleSize = (title as NSString).size(withAttributes: [.font: titleLabel!.font!])
        
        switch position {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing),
                                           left: 0,
                                           bottom: 0,
                                           right: -titleSize.width)
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -imageSize.width,
                                           bottom: -(imageSize.height + spacing),
                                           right: 0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: titleSize.height + spacing,
                                           left: 0,
                                           bottom: 0,
                                           right: -titleSize.width)
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -imageSize.width,
                                           bottom: imageSize.height + spacing,
                                           right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -spacing/2,
                                           bottom: 0,
                                           right: spacing/2)
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: spacing/2,
                                           bottom: 0,
                                           right: -spacing/2)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: titleSize.width + spacing/2,
                                           bottom: 0,
                                           right: -titleSize.width - spacing/2)
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -imageSize.width - spacing/2,
                                           bottom: 0,
                                           right: imageSize.width + spacing/2)
        }
    }
}
