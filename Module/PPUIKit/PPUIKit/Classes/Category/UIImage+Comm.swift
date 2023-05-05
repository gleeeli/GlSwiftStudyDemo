//
//  UIImage+Comm.swift
//  PPUIKit
//
//  Created by liguanglei on 2023/2/18.
//

import Foundation

public extension UIImage {
    /**
     默认头像
     */
    @objc class func pp_default_user_avatar() -> UIImage {
        return UIImage.pp_imageNamed("pp_default_user_avatar")
    }
}
