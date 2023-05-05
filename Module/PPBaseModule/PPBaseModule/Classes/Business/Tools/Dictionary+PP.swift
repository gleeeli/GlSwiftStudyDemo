//
//  Dictionary+PP.swift
//  PPBaseModule
//
//  Created by WJK on 2022/6/16.
//

import Foundation
extension Dictionary {

   public mutating func setObjectSafe(any: Any?, key: String) {
        if let anyTmp = any as? Value, !NSString.isEmpty(key) {
            if let anyString =  anyTmp as? String {
                if !NSString.isEmpty(anyString) {
                    self.updateValue(anyTmp, forKey: key as! Key )
                }
            } else {
                self.updateValue(anyTmp, forKey: key as! Key )
            }

        }
    }
}
