//
//  GradientCommand.swift
//  GlSwiftStudyDemo
//
//  Created by 小柠檬 on 2018/9/18.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class GradientCommand: ICommand {
    var receiver: Rceiver?;
    var colors : [CGColor]?
    var startTime: TimeInterval?
    
    init(receiver: Rceiver, colors:[CGColor]) {
        self.receiver = receiver;
        self.colors = colors;
    }
    
    func execute() {
        startTime = NSDate().timeIntervalSince1970
        self.receiver?.DoGradientAnimation(colors: colors!);
    }
    
    func takeAStepBack() {
        self.receiver?.DoBackAStep(colors: colors!)
    }
}
