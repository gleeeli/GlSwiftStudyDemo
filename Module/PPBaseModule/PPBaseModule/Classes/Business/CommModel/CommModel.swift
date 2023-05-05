//
//  CommModel.swift
//  AdModule
//
//  Created by liguanglei on 2022/11/11.
//

import Foundation

@objc public enum MCMKeyBoardBarViewType: NSInteger {
    case comm
    case plot // 剧情模式
    case plotRetain // 剧情保留态
    case testr
}


public enum PPPayCheckPurchaseSecretType {
    case unknow
    case storyAccountBalanceInsufficient //则表示用户有趣值不足
    case success
    case failure
}


@objc public enum SSStoryDetailType: NSInteger {
    case story = 1 //故事
    case secret = 2 // 秘密
}


@objc public enum PPStoryPublishSubSouce: NSInteger {
    case sayHellowOrtoExchange //打招呼或者去交换
}

@objc public class PPStoryPublishOtherData: NSObject {
    public var subSource: PPStoryPublishSubSouce? //打招呼或者去交换
    public var isMeHaveStory: Bool? = nil //我是否有故事
}
