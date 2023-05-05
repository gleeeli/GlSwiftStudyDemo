//
//  PPUnitManager.swift
//  AdModule
//
//  Created by WJK on 2022/8/8.
//

import UIKit
import HBPublic

/// 单位 管理
@objc public  class PPUnitManager: NSObject {
    /// 充值单位 - 金币
    /// - Returns: 充值单位 - 金币
    @objc  public static func rechargeUnit() -> String {
        return "金币"
    }

    @objc  public static func getSplitTime() -> Double{
        return 10000000000.0
    }
}
