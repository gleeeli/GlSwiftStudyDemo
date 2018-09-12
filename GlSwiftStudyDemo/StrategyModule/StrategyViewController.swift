//
//  StrategyViewController.swift
//  GlSwiftStudyDemo
//
//  Created by 小柠檬 on 2018/9/12.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class StrategyViewController: UIViewController {
    //环境类
    let sequence = Sequence()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let result = sequence.addnumber(i: 10)
        print("当前数组内容：\(result)")
        
    }
    
    //点击乘法
    @IBAction func multipleBtnClick(_ sender: Any) {
        // 继承Strategy的乘法类
        let multipleStrategy = MultiplyStrategy()
        let multipleResult = sequence.calculate(category: multipleStrategy)
        print("calculate multiple result is \(multipleResult)")
    }
    
    
    //点击加法
    @IBAction func addBtnClick(_ sender: Any) {
        // 继承Strategy的block类
        let closureStrategy =  ClosureStrategy({values in
            var result = 0;
            for value in values {
                result = result + value;
            }
            return result;
        })
        let comResult = sequence.calculate(category: closureStrategy)
        print("calculate block result is \(comResult)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
