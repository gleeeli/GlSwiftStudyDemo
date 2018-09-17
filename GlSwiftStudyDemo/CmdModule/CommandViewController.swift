//
//  CommandViewController.swift
//  GlSwiftStudyDemo
//
//  Created by 小柠檬 on 2018/9/13.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class CommandViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reciver = Rceiver()
        let invoker  = Invoker()
        invoker.setCommand(command: ConcreteCommandA(receiver: reciver))
        invoker.runCommand()
        invoker.setCommand(command: ConcreateCommandB(receiver: reciver))
        invoker.runCommand()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
