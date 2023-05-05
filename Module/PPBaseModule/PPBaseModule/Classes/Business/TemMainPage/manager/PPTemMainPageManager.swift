//
//  PPTemMainPageManager.swift
//  AdModule
//
//  Created by WJK on 2022/8/1.
//

import UIKit
import XHBFrame
import HandyJSON

@objc public class PPTemMainPageManager: NSObject {
    static  var gotoLogVCBlock : (() -> Void)?
    /// 展示 临时页面
    public static func showTemMainPageVC(_ gotoLogVC :@escaping () -> Void) {
        gotoLogVCBlock = gotoLogVC
        createVCs()

    }

    public static func gotoLogVC() {
        debugPrint("去登录")
        gotoLogVCBlock?()
    }

    private static func createVCs() {
        let tabClass: AnyClass? = NSClassFromString("ConfigModule.PPXHBTabbarViewController")
        guard let bclassType = tabClass as? XHBTabBarController.Type else {
            DDLogInfo("ConfigModule.PPXHBTabbarViewController 不存在")
            return
        }
        let tabVC = bclassType.init()
        //let tabVC = XHBTabBarController()
        XHBTabBarManager.shareInstance().tabBarController = tabVC

        var lotties =  [String]()
        var tabTitles =  [String]()
        var tabNomalNameImages =  [String]()
        var tabSelectedNameImages =  [String]()
        var vcStr =  [String]()

        let items = PPTabBarManager.shared.getTmpVCs()
        let momentIndex = PPTabBarManager.shared.getMomentIndex()
        for (index, item) in items.enumerated() {
            lotties.append(item.lottie)
            tabTitles.append(item.title)
            tabNomalNameImages.append(item.normalImage)
            tabSelectedNameImages.append(item.selectImage)
            //            vcStr.append(item.vcName)
            if index  == momentIndex {
                vcStr.append("MomentModule.PPTemMainPageVC")
            } else {

                vcStr.append("\(NAME_SPACE).ViewController")
            }
        }

        XHBTabBarManager.shareInstance().rootViewControllers(vcStr, titles: tabTitles, normalImageNames: tabNomalNameImages, selectImageNames: tabSelectedNameImages, lotties: lotties, bundle: Bundle.main)

        PPTabBarManager.shared .resetToTmpIndex()
    }

    @objc public static func savaUserAgree() {
        UserDefaults.standard.set(true, forKey: getUserAgreeKey())
    }

}
// MARK: -
public extension PPTemMainPageManager {
    /// 获取命名空间
    static let NAME_SPACE: String = {() -> String in
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as! String
    }()

    static func getUserAgree() -> Bool {
        return UserDefaults.standard.bool(forKey: getUserAgreeKey())
    }

    static  func getUserAgreeKey() -> String {
        "get_user_agree"
    }

}
