//
//  String+Comm.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/8/14.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import Foundation

// 下标截取任意位置的便捷方法
extension String {
    
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    subscript (r: NSRange) -> String {
        if let range = Range(r) {
            return String(self[range])
        }else {
            return ""
        }
        
    }
    
}
//不包含后几个字符串的方法
extension String {
    func dropLastCutom(_ n: Int = 1) -> String {
        return String(characters.dropLast(n))
    }
    var dropLast: String {
        return dropLastCutom()
    }
}
