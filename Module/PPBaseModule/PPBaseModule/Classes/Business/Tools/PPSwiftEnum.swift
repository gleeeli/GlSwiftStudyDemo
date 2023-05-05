//
//  PPSwiftEnum.swift
//  PPBaseModule
//
//  Created by WJK on 2022/6/21.
//

import Foundation

/// 性别
@objc public enum GenderType: Int {
    case none = 0, // 无
         male = 1, // 男
         female = 2 // 女

    // 判断是否男性
    public static func isMale(_ sexStr: String) -> Bool {
        if GenderType(rawValue: Int(sexStr) ?? 0) == .male {
            return true
        }
        return false
    }

    // 判断是否女性
    public static func isFemale(_ sexStr: String) -> Bool {
        if GenderType(rawValue: Int(sexStr) ?? 0) == .female {
            return true
        }
        return false
    }

//    func descText() -> String {
//        switch self {
//        case .none:
//            return "不限"
//        case .male:
//            return "男"
//        case .female:
//            return "女"
//        }
//    }
}
