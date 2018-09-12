//
//  Strategy.swift
//  GlSwiftStudyDemo
//
//  Created by 小柠檬 on 2018/9/12.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import Foundation
protocol Strategy {
    func execute(values:[Int]) -> Int
}
