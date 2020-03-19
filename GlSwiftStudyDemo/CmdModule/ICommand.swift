//
//  ICommand.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2018/9/13.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import Foundation
protocol ICommand {
//    var startTime: TimeInterval?{
//        get {
//        return 0
//        }
//        set {
//        startTime = newValue
//        }
//    }
    func execute()
    func takeAStepBack()
}
