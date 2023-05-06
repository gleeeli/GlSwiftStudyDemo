//
//  PPAlertProtocol.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/5/5.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import Foundation


@objc public protocol PPAlertProtocol: NSObjectProtocol {
    var onView: UIView? {get} //添加在那个view上面
    
    var curLevel: Int { get}
    
    func showAlert()
    
    func hiddenAlert(_ complete: (()->())? )
    
    // 显示优先级过低不够，先隐藏，后面再显示
    func hiddenWaitShowAlert(_ complete:(()->())?)
}
