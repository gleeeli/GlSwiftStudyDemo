//
//  Sequence.swift
//  GlSwiftStudyDemo
//
//  Created by 小柠檬 on 2018/9/12.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class Sequence: NSObject {
    var array = [1,2]
    
    override init() {
        
    }
    
    func addnumber(i:Int) -> Array<Int> {
        array.append(i)
        return array;
    }
    
    func calculate(category:Strategy) -> Int {
        return (category.execute(values: self.array))
    }
}
