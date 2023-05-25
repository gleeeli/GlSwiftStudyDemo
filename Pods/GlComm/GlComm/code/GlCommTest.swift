//
//  GlCommTest.swift
//  GlComm
//
//  Created by gleeeli on 2020/9/12.
//

import UIKit

@objc public class GlCommTest: NSObject {
    public var name:String = ""
    @objc public var name2:String = "2222"
    @objc public var name3:String = "2222"

    @objc public func testPint(msg:String) {
        print("GlComm--msg:\(msg)")
        
         print("第二次更改，GlComm--msg:\(msg)")
        
        let my1 = GlCommTool.init().my1
        
//        let tool1 = GlcommTool2.init()
        
    }
    
    @objc public func getImg(name:String) -> UIImage {
         let img = UIImage.GlCommImg(named: name)
        
         return img
    }
    


}
