//
//  GeneralSequence.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2018/9/12.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit
enum CalculateType {
    case CalculateMultiple
    case CalculateAdd
}
class GeneralSequence: NSObject {
    var array = [1,2]
    
    override init() {
        
    }
    
    func addnumber(i:Int) -> Array<Int> {
        array.append(i)
        return array;
    }
    
    func calculate(type:CalculateType) -> Int {
        switch type {
        case .CalculateMultiple:
            var result = 1;
            for v in array {
                result = result * v;
            }
            return result;
        case .CalculateAdd:
            var result = 0;
            for value in array {
                result = result + value;
            }
            return result;
        default:
            return 0
        }
    }
}
