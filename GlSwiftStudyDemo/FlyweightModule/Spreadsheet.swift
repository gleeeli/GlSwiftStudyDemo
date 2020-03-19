//
//  Spreadsheet.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2018/9/19.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class Spreadsheet: NSObject {
    
}

class Coordinate: Hashable,CustomStringConvertible {
    var hashValue: Int
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.col == rhs.col && lhs.row == rhs.row;
    }
    
    let col:Character
    let row:Int
    
    init(col:Character,row:Int) {
        self.col = col;
        self.row = row;
        self.hashValue = 0;
    }
    
//    var hashValue: Int{
//        return description.hasValue
//    }
    
    var description: String {
        return "\(col)\(row)"
    }
    
}
