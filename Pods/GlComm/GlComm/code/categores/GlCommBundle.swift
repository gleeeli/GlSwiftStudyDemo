//
//  GlCommBundle.swift
//  GlComm
//
//  Created by gleeeli on 2020/9/12.
//

import Foundation
extension Bundle{
  @objc public  static func GlCommBundle() -> Bundle {
        let path = Bundle.init(for: GlCommTest.self).resourcePath! + "/GlComm.bundle"
    print("图片所属bundle：\(path)")
        return Bundle.init(path: path)!
    }
}
