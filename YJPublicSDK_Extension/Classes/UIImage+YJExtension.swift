//
//  UIImage+YJExtension.swift
//  YJPublicSDK_Extension
//
//  Created by YJ on 2025/9/2.
//

import UIKit


public extension UIImage {
    
    /// 生成纯色图片
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片尺寸
    static func create(color: UIColor, size: CGSize = CGSizeMake(1, 1)) -> UIImage? {
        guard size.width > 0 && size.height > 0 else { return nil }
        
        let render = UIGraphicsImageRenderer(size: size, format: .default())
        let image = render.image { context in
            color.setFill()
            context.fill(context.format.bounds)
        }
        return image
    }
    
    ///渲染成指定颜色的图片
    func render(toColor: UIColor) -> UIImage {
        let render = UIGraphicsImageRenderer(size: size)
        return render.image { context in
            let cgContext = context.cgContext
            draw(in: CGRect(origin: .zero, size: size))
            cgContext.setFillColor(toColor.cgColor)
            cgContext.setBlendMode(.sourceAtop)
            cgContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    /// 调整图片尺寸并适配内容模式
    /// - Parameters:
    ///   - targetSize: 目标尺寸
    ///   - contentMode: 内容模式，默认为 .scaleAspectFit
    /// - Returns: 调整后的图片，如果调整失败则返回 self
    func resized(toSize targetSize: CGSize, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        if size.width == 0 || size.height == 1 || targetSize.width == 0 || targetSize.height == 0 {
            return self
        }
        
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        // 根据内容模式计算缩放比例和绘制区域
        let scale: CGFloat
        var newSize: CGSize
        var drawRect: CGRect
        
        switch contentMode {
        case .scaleToFill, .redraw:
            // 拉伸填充整个区域，不考虑宽高比
            newSize = targetSize
            drawRect = CGRect(origin: .zero, size: newSize)
            
        case .scaleAspectFit:
            // 保持宽高比，适应目标区域
            scale = min(widthRatio, heightRatio)
            newSize = CGSize(width: size.width * scale, height: size.height * scale)
            let x = (targetSize.width - newSize.width) / 2
            let y = (targetSize.height - newSize.height) / 2
            drawRect = CGRect(x: x, y: y, width: newSize.width, height: newSize.height)
            
        case .scaleAspectFill:
            // 保持宽高比，填充整个区域，可能会裁剪
            scale = max(widthRatio, heightRatio)
            newSize = CGSize(width: size.width * scale, height: size.height * scale)
            let x = (targetSize.width - newSize.width) / 2
            let y = (targetSize.height - newSize.height) / 2
            drawRect = CGRect(x: x, y: y, width: newSize.width, height: newSize.height)
            
        case .center:
            // 居中显示，不缩放
            newSize = size
            let x = (targetSize.width - newSize.width) / 2
            let y = (targetSize.height - newSize.height) / 2
            drawRect = CGRect(x: x, y: y, width: newSize.width, height: newSize.height)
            
        case .top:
            // 顶部对齐，不缩放
            newSize = size
            let x = (targetSize.width - newSize.width) / 2
            drawRect = CGRect(x: x, y: 0, width: newSize.width, height: newSize.height)
            
        case .bottom:
            // 底部对齐，不缩放
            newSize = size
            let x = (targetSize.width - newSize.width) / 2
            let y = targetSize.height - newSize.height
            drawRect = CGRect(x: x, y: y, width: newSize.width, height: newSize.height)
            
        case .left:
            // 左对齐，不缩放
            newSize = size
            let y = (targetSize.height - newSize.height) / 2
            drawRect = CGRect(x: 0, y: y, width: newSize.width, height: newSize.height)
            
        case .right:
            // 右对齐，不缩放
            newSize = size
            let x = targetSize.width - newSize.width
            let y = (targetSize.height - newSize.height) / 2
            drawRect = CGRect(x: x, y: y, width: newSize.width, height: newSize.height)
            
        case .topLeft:
            // 左上角对齐，不缩放
            newSize = size
            drawRect = CGRect(origin: .zero, size: newSize)
            
        case .topRight:
            // 右上角对齐，不缩放
            newSize = size
            let x = targetSize.width - newSize.width
            drawRect = CGRect(x: x, y: 0, width: newSize.width, height: newSize.height)
            
        case .bottomLeft:
            // 左下角对齐，不缩放
            newSize = size
            let y = targetSize.height - newSize.height
            drawRect = CGRect(x: 0, y: y, width: newSize.width, height: newSize.height)
            
        case .bottomRight:
            // 右下角对齐，不缩放
            newSize = size
            let x = targetSize.width - newSize.width
            let y = targetSize.height - newSize.height
            drawRect = CGRect(x: x, y: y, width: newSize.width, height: newSize.height)
        @unknown default:
            // 拉伸填充整个区域，不考虑宽高比
            newSize = targetSize
            drawRect = CGRect(origin: .zero, size: newSize)
        }
        
        // 确保绘制区域在目标尺寸范围内
        drawRect = drawRect.intersection(CGRect(origin: .zero, size: targetSize))
        
        // 使用 UIGraphicsImageRenderer 创建新图像
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1 // 使用固定缩放因子，避免受屏幕缩放影响
        format.opaque = false // 支持透明背景
        
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        let resizedImage = renderer.image { context in
            // 设置背景为透明
            UIColor.clear.set()
            context.fill(CGRect(origin: .zero, size: targetSize))
            
            // 绘制图像
            self.draw(in: drawRect)
        }
        
        return resizedImage
    }
    
    /// 调整图片分辨率
    /// - Parameter maxPixel: 最大分辨率（宽或高的最大值）
    /// - Returns: 调整后图片
    func resized(maxPixel: CGFloat) -> UIImage {
        let originalMaxPixel = max(size.width, size.height)
        
        // 如果图片已经小于目标分辨率，直接返回
        if originalMaxPixel <= maxPixel || originalMaxPixel == 0 {
            return self
        }
        
        // 计算新的尺寸，保持宽高比
        let ratio = maxPixel / originalMaxPixel
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        return self.resized(toSize: newSize)
    }
    
    
    
    /// 压缩图片到指定分辨率大小以下和最大文件大小以下。会丢失透明通道，转换成JPEG格式。
    /// - Parameters:
    ///   - maxPixel: 最大分辨率（宽或高的最大值）
    ///   - maxFileSize: 最大文件大小（字节）
    /// - Returns: 压缩后的图片，JPEG格式
    func compress(maxPixel: CGFloat, maxFileSize: Int) -> UIImage? {
        //最低图片质量
        var minQuality = 0.8
        //质量压缩最大尝试次数
        let maxAttempts = 5
        
        var pixel = maxPixel
        var resizedImage: UIImage = self
        while true {
            //调整分辨率
            resizedImage = self.resized(maxPixel: pixel)
            //判断最低质量图片是否符合要求，否则继续调整降低分辨率以保证图片质量
            guard let lowestData = resizedImage.jpegData(compressionQuality: minQuality) else { return nil }
            if (lowestData.count < maxFileSize) {
                break
            } else {
                //继续缩小分辨率
                pixel = pixel * 0.9
            }
        }
        
        //在最低质量图片符合要求后，使用二分法调整质量，以获取最好效果。
        var compressionQuality: CGFloat = 1
        var bestData: Data?
        for _ in 0 ..< maxAttempts {
            guard let data = resizedImage.jpegData(compressionQuality: compressionQuality) else { return nil }
            
            // 检查是否满足大小要求
            if data.count <= maxFileSize {
                return UIImage(data: data)
            }
            
            // 如果当前数据是最小的，保存它
            if bestData == nil || data.count < bestData!.count {
                bestData = data
            }
            
            // 使用二分法调整质量
            if data.count > maxFileSize {
                let nextQuality = (compressionQuality + minQuality) / 2.0
                compressionQuality = nextQuality
            } else {
                let nextQuality = (1.0 + compressionQuality) / 2.0
                minQuality = compressionQuality
                compressionQuality = nextQuality
            }
        }
        
        return UIImage(data: bestData!)
    }
}
