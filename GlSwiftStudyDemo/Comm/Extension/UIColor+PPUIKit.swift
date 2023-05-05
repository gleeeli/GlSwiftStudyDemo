//
//  UIColor+PPUIKit.swift
//  PPUIKit
//
//  Created by liguanglei on 2022/12/5.
//

import Foundation
import UIKit

public extension UIColor {
    /**
     * UIColor的扩展类 将16进制颜色转换为RGB
     * @param hexString 16进制颜色字符串
     */
    convenience init(hexString: String, alpha: CGFloat) {
        let scanner:Scanner = Scanner(string:hexString)
        var valueRGB:UInt32 = 0
        if scanner.scanHexInt32(&valueRGB) == false {
            self.init(red: 0, green: 0,blue: 0, alpha: alpha)
        }else{
            self.init(
                red:CGFloat((valueRGB & 0xFF0000)>>16)/255.0,
                green:CGFloat((valueRGB & 0x00FF00)>>8)/255.0,
                blue:CGFloat(valueRGB & 0x0000FF)/255.0,
                alpha:alpha
            )
        }
    }
}
