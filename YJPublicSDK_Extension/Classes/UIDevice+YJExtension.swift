//
//  UIDevice+YJExtension.swift
//  YJPublicSDK_Extension
//
//  Created by YJ on 2025/9/10.
//

import Foundation

public extension UIDevice {
    
    ///获取当前设备型号标识符
    func getDeviceModelIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }

   
    
}
