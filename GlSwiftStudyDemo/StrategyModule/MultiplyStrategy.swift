//
//  MultiplyStrategy.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2018/9/12.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class MultiplyStrategy: Strategy {
    func execute(values: [Int]) -> Int {
        var result = 1;
        for v in values {
            result = result * v;
        }
        return result;
    }
    

}
