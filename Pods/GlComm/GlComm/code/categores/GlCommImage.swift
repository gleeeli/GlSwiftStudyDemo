//
//  GlCommImage.swift
//  GlComm
//
//  Created by gleeeli on 2020/9/12.
//

import Foundation

@objc public extension UIImage{
    @objc static func GlCommImg(named:String) -> UIImage {
        let bundle = Bundle.GlCommBundle()
        let image = UIImage.init(named: named, in: bundle, compatibleWith: nil)
        return image!
    }
}
