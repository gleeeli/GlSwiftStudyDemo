//
//  BlockViewController.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2020/3/19.
//  Copyright © 2020 gleeeli. All rights reserved.
//

import UIKit

class BlockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"];
               var reversedNames = names.sorted(by: backward)
               print(reversedNames);
               
               _ = { reversedNames.remove(at: 0) }
               print(reversedNames.count)
               // 打印出 "5"
        
        reversedNames = names.sorted(by: {(s1:String, s2:String) -> Bool in return s1 < s2})
        print(reversedNames);
    }
    

    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }

}
