//
//  UIView+YJExtension.swift
//  YJPublicSDK_Extension
//
//  Created by YJ on 2025/9/1.
//

import UIKit

//MARK: - 扩展常用视图方法

public extension UIView {
    
    /// 移除所有子视图
    func removeAllSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    /// 设置视图圆角，
    /// - Parameters:
    ///   - corner: 圆角位置
    ///   - radius: 圆角半径
    ///   - frame: 圆角遮罩在视图上的frame，默认为视图本身bounds。如果视图本身尺寸为0，则不设置圆角
    func setCorner(corner: UIRectCorner?, radius: CGFloat, frame: CGRect = .zero) {
        guard let corner = corner else {
            layer.mask = nil
            return
        }
        
        if (frame == .zero && self.frame.width == 0 && self.frame.height == 0) {
            layer.mask = nil
            return
        }
        let rect = frame == .zero ? bounds : frame
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSizeMake(radius, radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
        layer.contentsScale = UIScreen.main.scale
    }
}

//MARK: - 扩展视图常用属性的链式调用方法

public extension UIView {
    
    func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        return self
    }
    
    func borderWidth(_ width: CGFloat) -> Self {
        layer.borderWidth = width
        return self
    }
    
    func borderColor(_ color: UIColor) -> Self {
        layer.borderColor = color.cgColor
        return self
    }
    
    func masksToBounds() -> Self {
        layer.masksToBounds = true
        return self
    }
    
    func backgroundColor(_ color: UIColor?) -> Self {
        self.backgroundColor = color
        return self
    }
    
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
}



