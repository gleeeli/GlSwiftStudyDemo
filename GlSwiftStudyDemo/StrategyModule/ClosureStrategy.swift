//
//  ClosureStrategy.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2018/9/12.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class ClosureStrategy: Strategy {
    private let closure:([Int]) -> Int;
    init(_ closure:@escaping ([Int]) -> Int) {
        self.closure = closure;
    }
    
    func execute(values: [Int]) -> Int {
        return self.closure(values);
    }
    

}
