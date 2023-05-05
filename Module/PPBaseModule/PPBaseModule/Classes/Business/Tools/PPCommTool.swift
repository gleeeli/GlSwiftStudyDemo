//
//  PPCommTool.swift
//  PPBaseModule
//
//  Created by liguanglei on 2022/10/11.
//

import Foundation

@objc public class PPCommTool: NSObject {
    @objc public class func getAppVersion() -> Float {
        return ( UIDevice.current.systemVersion as NSString).floatValue
    }
}
