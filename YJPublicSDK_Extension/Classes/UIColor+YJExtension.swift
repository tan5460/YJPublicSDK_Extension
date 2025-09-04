//
//  UIColor+YJExtension.swift
//  YJPublicSDK_Extension
//
//  Created by YJ on 2025/9/2.
//

import UIKit


public extension UIColor {
    
    ///根据十六进制数字创建颜色 eg: 0xFFEEDD
    static func hex(_ hex: Int, alpha: CGFloat = 1) -> UIColor {
        let r = CGFloat((hex & 0xFF0000) >> 16)/255.0
        let g = CGFloat((hex & 0xFF00) >> 8)/255.0
        let b = CGFloat(hex & 0xFF)/255.0
        return self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    /// 通过 HEX 字符串初始化 UIColor
    /// - Parameters:
    /// - hex: HEX 字符串（支持格式：#RGB、#RRGGBB、#RRGGBBAA 或省略 #）
    /// - alpha: 透明度（默认 1.0），若 HEX 包含 Alpha 通道则覆盖此值
    /// - 解析错误时返回 .black
    static func hex(hexString: String, alpha: CGFloat = 1) -> UIColor {
        var formattedHex = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // 移除前缀 #
        if formattedHex.hasPrefix("#") {
            formattedHex = String(formattedHex.dropFirst())
        }
        
        // 处理短格式（如 RGB → RRGGBB）
        if [3, 4].contains(formattedHex.count) {
            formattedHex = formattedHex.map { "\($0)\($0)" }.joined()
        }
        
        // 验证 HEX 有效性
        guard let hexValue = UInt32(formattedHex, radix: 16), [6, 8].contains(formattedHex.count) else {
            return .black
        }
        
        // 解析 RGB/RGBA 值
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = alpha
        switch formattedHex.count {
        case 6: // RRGGBB
            r = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            g = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
            b = CGFloat(hexValue & 0x0000FF)        / 255.0
        case 8: // RRGGBBAA
            r = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
            g = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
            a = CGFloat(hexValue & 0x000000FF)         / 255.0
        default:
            return .black
        }
        return self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    ///随机颜色
    class var random: UIColor {
        let r = CGFloat(arc4random()%255)/255.0
        let g = CGFloat(arc4random()%255)/255.0
        let b = CGFloat(arc4random()%255)/255.0
        return self.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    ///渐变色值计算
    convenience init(fromColor: UIColor, toColor: UIColor, progress: CGFloat) {
        var fromR : CGFloat = 0
        var fromG : CGFloat = 0
        var fromB : CGFloat = 0
        var fromA : CGFloat = 0
        fromColor.getRed(&fromR, green: &fromG, blue: &fromB, alpha: &fromA)
        
        var toR : CGFloat = 0
        var toG : CGFloat = 0
        var toB : CGFloat = 0
        var toA : CGFloat = 0
        toColor.getRed(&toR, green: &toG, blue: &toB, alpha: &toA)
        
        let newProgress = min(1, progress)
        let newR = fromR + (toR - fromR) * newProgress
        let newG = fromG + (toG - fromG) * newProgress
        let newB = fromB + (toB - fromB) * newProgress
        let newA = fromA + (toA - fromA) * newProgress
        self.init(red: newR, green: newG, blue: newB, alpha: newA)
    }
    
}
