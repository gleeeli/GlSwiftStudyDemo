//
//  Bundele+PPUIKit.swift
//  PPUIKit
//
//  Created by WJK on 2022/6/13.
//

import Foundation

extension Bundle {

    static var pp_resourceBundle: Bundle {
        if let resourceBundlePath = Bundle.init(for: NSClassFromString("PPUIKit.PPUIKitDelegate")!).path(forResource: "PPUIKit", ofType: "bundle") {
            return Bundle.init(path: resourceBundlePath)!
        } else {
            return Bundle.main
        }
    }

    static var pp_assetBundle: Bundle {
        if let resourceBundlePath = Bundle.init(for: NSClassFromString("PPUIKit.PPUIKitDelegate")!).path(forResource: "PPUIKitAsset", ofType: "bundle") {
            return Bundle.init(path: resourceBundlePath)!
        } else {
            return Bundle.main
        }
    }

}
