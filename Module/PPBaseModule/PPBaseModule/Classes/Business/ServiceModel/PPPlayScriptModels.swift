//
//  PPPlayScriptModels.swift
//  PPBaseModule
//
//  Created by liguanglei on 2022/11/3.
//

import Foundation

//1.选择用户，2.私信
@objc public enum PPPlayScriptSource: NSInteger {
case userSelected = 1 // 用户选择
case chatVc = 2// 私信入口
}
