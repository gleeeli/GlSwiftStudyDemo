//
//  Invoker.swift
//  GlSwiftStudyDemo
//
//  Created by 小柠檬 on 2018/9/13.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class Invoker: NSObject {
    var command: ICommand?
    func setCommand(command: ICommand){
        self.command = command;
    }
    
    func runCommand(){
        command?.execute()
    }
    
}
