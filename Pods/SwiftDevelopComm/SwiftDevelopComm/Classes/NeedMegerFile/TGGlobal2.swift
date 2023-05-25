//
//  TGGlobal2.swift
//  SwiftDevelopFramework
//
//  Created by luo luo on 2020/5/1.
//  Copyright © 2020 GL. All rights reserved.
//

import Foundation

//****日志打印
//fileprivate  let TAG: String = "<#content#>"    
func LLog(TAG :String, _ items: Any...) -> Void {
    print(TAG,items)
}

func PrintLog<T>(_ message: T, fileName: String = #file, lineNumber: Int = #line){
    //文件名、方法、行号、打印信息
    print("\((fileName as NSString).lastPathComponent)[\(lineNumber)] : \(message)")
}
//****end
