//
//  ViewController.swift
//  GlSwiftStudyDemo
//
//  Created by 小柠檬 on 2018/9/12.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"];
        var reversedNames = names.sorted(by: backward)
        print(reversedNames);
        
        _ = { reversedNames.remove(at: 0) }
        print(reversedNames.count)
        // 打印出 "5"
        
        let newarray = multipleReturn(num: [1,2,3]);
        print(newarray as Any)
        
        canChangeNumsParameters(param: 1,2,3)
    }
    
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    
    func multipleReturn(num:[Int]) -> (min:Int,max:Int)?{
        if num.isEmpty {
            return nil
        }
        return (0, 100)
    }
    
    func canChangeNumsParameters(param:Int...) -> () {
        for num in param {
            print("可变数组内容为:\(num)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

