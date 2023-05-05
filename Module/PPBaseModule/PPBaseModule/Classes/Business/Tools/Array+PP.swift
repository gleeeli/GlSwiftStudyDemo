//
//  +PP.swift
//  PPBaseModule
//
//  Created by WJK on 2022/6/16.
//

import Foundation

enum JSONError: Error {
    case notArray
    case notNSDictionary
}
extension Array {
 public func get(index: Int) -> Any? {
        if  self.count <= index {
            return nil
        }
        return self[index]
    }

}
