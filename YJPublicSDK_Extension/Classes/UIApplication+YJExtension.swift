//
//  UIApplication+YJExtension.swift
//  YJPublicSDK_Extension
//
//  Created by YJ on 2025/9/10.
//

import UIKit


extension UIApplication {
    
    var window: UIWindow? {
        if #available(iOS 13.0, *) {
            // 方式1: 从活跃的窗口场景中查找关键窗口
            if let window = findKeyWindowInConnectedScenes() {
                return window
            }
            // 方式2: 作为备选方案，从所有windows中查找关键窗口
            return findKeyWindowFromWindows()
        } else {
            if let delegateWindow = delegate?.window as? UIWindow {
                return delegateWindow
            }
            return keyWindow
        }
    }
    
    @available(iOS 13.0, *)
    private func findKeyWindowInConnectedScenes() -> UIWindow? {
        let foregroundActiveScenes = connectedScenes.filter {
            $0.activationState == .foregroundActive
        }
        
        for scene in foregroundActiveScenes {
            if let windowScene = scene as? UIWindowScene {
                // 在第一个处于前台活跃状态的场景中寻找关键窗口
                if let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    return keyWindow
                }
                // 如果没找到关键窗口，返回场景中的第一个窗口
                return windowScene.windows.first
            }
        }
        return nil
    }
    
    private func findKeyWindowFromWindows() -> UIWindow? {
        return windows.first { $0.isKeyWindow }
    }
    
    
    
    static func getCurrentVC(controller: UIViewController? = UIApplication.shared.window?.rootViewController) -> UIViewController? {
        // 处理模态展示的控制器
        if let presented = controller?.presentedViewController {
            return getCurrentVC(controller: presented)
        }
        
        // 处理导航控制器
        if let navigationController = controller as? UINavigationController {
            return getCurrentVC(controller: navigationController.visibleViewController)
        }
        
        // 处理标签栏控制器
        if let tabBarController = controller as? UITabBarController {
            if let selected = tabBarController.selectedViewController {
                return getCurrentVC(controller: selected)
            }
        }
        
        // 返回当前控制器
        return controller
    }
    
}
