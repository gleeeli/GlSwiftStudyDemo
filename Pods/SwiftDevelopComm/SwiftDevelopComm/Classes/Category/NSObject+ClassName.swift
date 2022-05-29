//
//  NSObject+ClassName.swift
//  SwiftDevelopFramework
//
//  Created by gleeeli on 2020/3/29.
//  Copyright © 2020 GL. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// 返回类名字符串
    static var className: String {
        return String(describing: self)
    }
    
    /// 返回类名字符串
    var className: String {
        return String(describing: type(of: self))
    }
}
