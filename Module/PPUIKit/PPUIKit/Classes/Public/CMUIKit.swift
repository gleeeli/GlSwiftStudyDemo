//
//  CMUIKit.swift
//  ConfigModule
//
//  Created by wuy on 2021/8/20.
//

import UIKit

public let CM_UIScreenWidth: CGFloat = UIScreen.main.bounds.size.width

public let CM_UIScreenHeight: CGFloat = UIScreen.main.bounds.size.height

public let CM_UINavgationBarHeight: CGFloat = 44.0

public let CM_UITabbarHeight: CGFloat = 44

public let CM_UIStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height

public let CM_UINavgationHeight: CGFloat = CM_UINavgationBarHeight + CM_UIStatusBarHeight

public let CM_UIIsiPhoneX: Bool = ((CM_UIScreenWidth >= 375.0 && CM_UIScreenHeight >= 812.0) ? true : false)

public let CM_UISafeAreaBottomMargin: CGFloat = (CM_UIIsiPhoneX ? 34.0 : 0.0)

public let CM_UISwiftWindow  = UIApplication.shared.delegate!.window!

public let CM_UISwiftScale: CGFloat = CM_UIScreenWidth / 375.0

/// USERINFO swift 文件使用
// public var USERINFO: AppUserInfo {
//    get {
//        return AppUserManager.defaultUser().userInfo
//    }
// }

@objcMembers public class CMUIKit: NSObject {

}
