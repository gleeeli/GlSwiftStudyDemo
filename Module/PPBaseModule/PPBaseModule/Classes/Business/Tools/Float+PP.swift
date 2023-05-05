//
//  Float+PP.swift
//  PPBaseModule
//
//  Created by liguanglei on 2022/9/7.
//

import Foundation
public extension Float {
    func interceptionDecimal(_ base: Int) -> String {
        let format = NumberFormatter.init()
        format.numberStyle = .decimal
        format.minimumFractionDigits = 0 // 最少小数位
        format.maximumFractionDigits = base // 最多小数位
        format.formatterBehavior = .default
        format.roundingMode = .down // 小数位以截取方式。不同枚举的截取方式不同
        return format.string(from: NSNumber(value: self)) ?? ""
    }
}
