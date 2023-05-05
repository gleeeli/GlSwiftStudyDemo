//
//  PPTabBarManager.swift
//  DiscoveryModule
//
//  Created by 林庆霖 on 2022/5/27.
//

import Foundation
import HBPublic
import HandyJSON
import XHBFrame
import RxSwift
import HBPublic

extension XHBInterface {
    func getTabBarList() -> String {
        return self.gwDomain + "/peipeix-material" + "/v1/Config/getTabList" + "?ticket_id=\(XHBConfigure.ticketId())"
    }
}

@objc public enum PPTabBarType: Int {
    case discovery = 9  // 配配（发现）
    case square = 2     // 动态广场
    case message = 8    // 消息
    case mine = 6       // 我的
    case moment = 7     // 贴贴（瞬间）
    case script = 10    // 梦境（剧本）时空
    case story = 11     // 故事（广场）
}

@objcMembers
public class PPTabBarManager: NSObject {
    static public let shared: PPTabBarManager = {
        let instance = PPTabBarManager()
        return instance
    }()

    private override init() {
        super.init()
        getLocalConfig()
    }
    // 当前设置的item
    private var items: [PPTabBarItem] = []

    private var defaultIndex = "2"

    private var defaultTabList = ["10", "9", "2", "8", "6"]

    // 可配置的item
    private var configItems: [PPTabBarType: PPTabBarItem] = [:]

    private var disposeBag = DisposeBag()

    // 需要跳转页面的tab
    private var shouldPushItems: [PPTabBarType?] = [.discovery, .script]
    // 可以双击的tab
    private var canDoubleClickItems: [PPTabBarType?] = [.message, .moment]

// MARK: 不同意协议 跳转临时页面 ---开始 ------------------
    // 7 必须有 否者 临时页面会有问题 PPTemMainPageVC
    private var TmpDefaultTabList = [ "7", "10", "2", "8", "6"]
// MARK: 不同意协议 跳转临时页面 ---结束----------

    @discardableResult
    public func redirect(to type: PPTabBarType, source: ExposureSource = .other) -> Bool {
        // 判断当前tab 点击时需要跳转二级页
        if shouldPushItems.contains(type) {
            if let item = getItem(type: type) {
                XHBRouter.share().run(withURL: item.route, params: [
                    "query": [
                        "source": source
                    ]
                ])
                return true
            }
            return false
        }

        var index = HBEnumTabState.none
        for (idx, item) in items.enumerated() {
            if type == item.type {
                index = HBEnumTabState(rawValue: idx) ?? .none
            }
        }
        XHBTabBarManager.shareInstance().toRootVC(withTab: index)
        return index != .none
    }

    /// 是否可以直接跳转 需要跳转页面的tab
    public func canImmediateJump( type: PPTabBarType) -> Bool {
        return  shouldPushItems.contains(type)
    }

    /// 跳转到对应的根VC
    @discardableResult  public func toRootVC( type: PPTabBarType) -> Bool {

        var index = HBEnumTabState.none
        for (idx, item) in items.enumerated() {
            if type == item.type {
                index = HBEnumTabState(rawValue: idx) ?? .none
            }
        }
        if index != .none {
            XHBTabBarManager.shareInstance().toRootVC(withTab: index)
        }
        return index != .none
    }

    @discardableResult
    public func redirect(item: PPTabBarItem?, source: ExposureSource = .other) -> Bool {
        /// 未同意用户协议
        if !PPTemMainPageManager.getUserAgree() {
            PPTemMainPageManager.gotoLogVC()
            return false
        }
        guard let item = item else {
            return false
        }
        return redirect(to: item.type, source: source)
    }

    public func setBadge(_ value: Int, at type: PPTabBarType) {
        var index = HBEnumTabState.none
        for (idx, item) in items.enumerated() {
            if type == item.type {
                index = HBEnumTabState(rawValue: idx) ?? .none
            }
        }
        XHBTabBarManager.shareInstance().setBadgeWithValue(Int32(value), index: index)
    }

    public func getItem(vcName: String?) -> PPTabBarItem? {
        guard let vcName = vcName else {
            return nil
        }
        for item in items {
            if vcName == item.vcName {
                return item
            }
        }
        return nil
    }

    public func getItem(type: PPTabBarType) -> PPTabBarItem? {
        for item in items {
            if item.type == type {
                return item
            }
        }
        return nil
    }

    public func canClick(item: PPTabBarItem?) -> Bool {
        guard let item = item else { return false }
        return !shouldPushItems.contains(item.type)
    }

    public func canDoubleClick(item: PPTabBarItem?) -> Bool {

        guard let item = item else { return false }
        return canDoubleClickItems.contains(item.type)

    }

    public func requestTabBarList(completion: @escaping (([PPTabBarItem]) -> Void)) {
        requestTabBarList()
            .timeout(.seconds(10), scheduler: MainScheduler.instance)
            .catchAndReturn((defaultTabList, defaultIndex))
            .subscribe { [weak self] (list, index) in
                guard let self = self else { return }
                self.writeTabBarList(list, index: index)
                self.items = self.getTabBarItems()
                completion(self.items)
            }
            .disposed(by: disposeBag)
    }

    public func requestTabBarList() -> Single<([String], String?)> {
        Single<([String], String?)>.create { [weak self] ob in
//            ob(.success((self!.defaultTabList, self!.defaultIndex)))
//            return Disposables.create()
            let task = XHBNetworking.request(withURL: XHBInterface.sharedInstance()?.getTabBarList(), method: .hbhttpGet, parameterDic: nil) { response in
                if response?.isSuccess == true,
                   let array = response?.responseData as? [[String: Any]],
                   !array.isEmpty {
                    var temp = [String]()
                    var index: String?
                    for dict in array {
                        var typeStr = ""
                        if let typeStr2 = dict["tab_type"] as? String {
                            typeStr = typeStr2
                        }
                        if let type = dict["tab_type"] as? Int {
                            typeStr = "\(type)"
                        }

                        if typeStr != "" {
                            if let type = PPTabBarType(rawValue: Int(typeStr) ?? 0),
                               let title = dict["tab_title"] as? String {
                                self?.configItems[type]?.title = title
                            }
                            temp.append(typeStr)
                            // 记录选中的tab
                            if let state = dict["selected_state"] as? Bool, state {
                                index = typeStr
                            }
                        }
                    }
                    if !temp.isEmpty {
                        ob(.success((temp, index)))
                    } else {
                        ob(.failure(HBRxError.parseReponseError(from: response)))
                        PPMonitorManager.sendLog(event: PPMonitorEvent.tabbarListReqFail, andContent: "code: \(response?.errorCode ?? 0), msg: \(response?.message ?? "")")
                    }
                } else {
                    ob(.failure(HBRxError.parseReponseError(from: response)))
                    PPMonitorManager.sendLog(event: PPMonitorEvent.tabbarListReqFail, andContent: "code: \(response?.errorCode ?? 0), msg: \(response?.message ?? "")")
                }
            } failureBlock: { response in
                ob(.failure(HBRxError.parseReponseError(from: response)))
                PPMonitorManager.sendLog(event: PPMonitorEvent.tabbarListReqFail, andContent: "code: \(response?.errorCode ?? 0), msg: \(response?.message ?? "")")
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }

    public func resetToDefaultIndex() {
        var defaultItem: PPTabBarItem? = items.first
        let (_, index) = readTabBarList()
        if let index = Int(index),
           let type = PPTabBarType(rawValue: index) {
            for item in items {
                if type == item.type {
                    defaultItem = item
                    break
                }
            }
        }
        redirect(item: defaultItem)
    }

    private func getTabBarItems() -> [PPTabBarItem] {
        let (list, _) = readTabBarList()
        var items = [PPTabBarItem]()
        for i in list {
            if let i = Int(i),
               let type = PPTabBarType(rawValue: i),
               let item = configItems[type] {
                item.type = type
                items.append(item)
            }
        }
        return items
    }

    private func readTabBarList() -> ([String], String) {
        if let list = UserDefaults.standard.object(forKey: kTabBarListKey) as? [String] {
            if let index = UserDefaults.standard.object(forKey: kTabBarSelectedKey) as? String {
                return (list, index)
            } else {
                return (list, defaultIndex)
            }
        } else {
            return (defaultTabList, defaultIndex)
        }
    }

    private func writeTabBarList(_ typelist: [String], index: String?) {
        UserDefaults.standard.set(typelist, forKey: kTabBarListKey)
        UserDefaults.standard.set(index, forKey: kTabBarSelectedKey)
        UserDefaults.standard.synchronize()
    }

    private var kTabBarListKey: String {
        return "kTabBarListKey_" + USERINFTicketId

    }

    private var kTabBarSelectedKey: String {
        return "kTabBarSelectedKey_" + USERINFTicketId

    }

    private func getLocalConfig() {
        let path = Bundle.main.path(forResource: "TabBarConfig", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let dict = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
        var items = [PPTabBarType: PPTabBarItem]()
        for (key, value) in dict {
            if let type = PPTabBarType(rawValue: Int(key)!),
               let item = JSONDeserializer<PPTabBarItem>.deserializeFrom(dict: value as? [String: Any]) {
                items[type] = item
                if item.route == "screenplay/introduce" {
                    item.vcName = "UIViewController"
                }
            }
        }
        configItems = items
    }

}

// MARK: - 判断控制器
extension PPTabBarManager {

}
// MARK: 不同意协议 跳转临时页面 ---------------------
// MARK: - 临时主页
public extension PPTabBarManager {

    func getTmpVCs() -> [PPTabBarItem] {

        var tabBarItem = [PPTabBarItem]()
        for string in TmpDefaultTabList {
            if let tmpTabBarType =  PPTabBarType(rawValue: Int(string) ?? 99), let  tabItemTmp =   self.configItems[tmpTabBarType] {
                tabBarItem.append(tabItemTmp)
            }
        }
        return tabBarItem
    }

     func resetToTmpIndex() {

         XHBTabBarManager.shareInstance().toRootVC(withTab: HBEnumTabState(rawValue: getMomentIndex()) ?? .none)
    }

    @objc func getMomentIndex() -> Int {
        var index = HBEnumTabState.none
        for (idx, item) in self.TmpDefaultTabList.enumerated() {
            if "7" == item {
                index = HBEnumTabState(rawValue: idx) ?? .none
            }
        }
        return index.rawValue
    }
}

@objcMembers
public class PPTabBarItem: NSObject, HandyJSON {
    public var title: String = ""
    public var vcName: String = ""
    public var normalImage: String = ""
    public var selectImage: String = ""
    public var lottie: String = ""
    public var route: String = ""
    public var type: PPTabBarType!

    required public override init() {}

    public  func getTabBarType() -> PPTabBarType {
        return type
    }
}
