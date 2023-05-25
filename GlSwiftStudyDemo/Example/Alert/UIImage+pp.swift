//
//  UIImage+pp.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/5/8.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import Foundation
import CoreGraphics

extension UIImage {
    func image(color: UIColor, size: CGSize) {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor);
            context.fill(rect);
        }
        
    }
}
