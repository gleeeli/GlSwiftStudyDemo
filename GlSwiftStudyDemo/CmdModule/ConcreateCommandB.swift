//
//  ConcreateCommandB.swift
//  GlSwiftStudyDemo
//
//  Created by 小柠檬 on 2018/9/13.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class ConcreateCommandB: ICommand {

    var receiver: Rceiver?;
    init(receiver: Rceiver) {
        self.receiver = receiver;
    }
    
    func execute() {
        self.receiver?.DoB();
    }
}
