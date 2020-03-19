//
//  Invoker.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2018/9/13.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class Invoker: NSObject {
    var cmdArray: Array<ICommand>?
    
    override init() {
        super.init()
        cmdArray = Array.init()
    }
    
    func runCommand(command: ICommand){
        command.execute()
        cmdArray?.append(command)
    }
    
    //后退一步
    func back() {
        if (cmdArray?.count)! > 1 {
            cmdArray?.removeLast();
            cmdArray?.last?.takeAStepBack()
        }
    }
}
