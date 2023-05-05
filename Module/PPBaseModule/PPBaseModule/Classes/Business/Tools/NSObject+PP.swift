//
//  NSObject+PP.swift
//  PPBaseModule
//
//  Created by liguanglei on 2022/9/30.
//

import Foundation

extension NSObject {

    public func safeRemoveObserver(_ observer: NSObject, keyPath: String, context: UnsafeMutableRawPointer?) {
        let result = checkIfAlreadyAdded(keyPath: keyPath, context: context)

        if result {
            removeObserver(observer, forKeyPath: keyPath, context: context)
        }
    }

    fileprivate func address(_ o: UnsafeRawPointer) -> Int {
        return Int(bitPattern: o)
    }

    fileprivate func checkIfAlreadyAdded(keyPath: String, context: UnsafeMutableRawPointer?) -> Bool {

        guard self.observationInfo != nil else { return false }

        let info = Unmanaged<AnyObject>
            .fromOpaque(self.observationInfo!)
            .takeUnretainedValue()
        let infoStr = info.description ?? ""
        // print("监听信息：\(infoStr)")
        if infoStr.contains("Key path: \(keyPath)") {// 没找到好的判断方法暂时如此
            return true
        }

        return false
    }
}
