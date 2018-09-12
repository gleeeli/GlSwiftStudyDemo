//
//  NotStrategyViewController.swift
//  GlSwiftStudyDemo
//
//  Created by 小柠檬 on 2018/9/12.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class NotStrategyViewController: UIViewController {
    //环境类
    let sequence = GeneralSequence()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let result = sequence.addnumber(i: 10)
        print("当前数组内容：\(result)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    //点击乘法
    @IBAction func multipleBtnClick(_ sender: Any) {
       let result = sequence.calculate(type: CalculateType.CalculateMultiple)
        print("calculate multiple result is \(result)")
    }
    
    
    //点击加法
    @IBAction func addBtnClick(_ sender: Any) {
       let result = sequence.calculate(type: CalculateType.CalculateAdd)
        print("calculate block result is \(result)")
    }

}
