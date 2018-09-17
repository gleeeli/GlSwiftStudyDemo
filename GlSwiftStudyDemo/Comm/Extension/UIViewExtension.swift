//
//  UIViewExtension.swift
//  GlSwiftStudyDemo
//
//  Created by 小柠檬 on 2018/9/13.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    public var gl_x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    public var gl_y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
}
