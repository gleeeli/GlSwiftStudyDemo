//
//  UIAlertViewController.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/5/5.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import UIKit
import GlComm

class UIAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertView = PPCommAlertView(title: "这是标题", content: "这是内容", cancelTitle: "取消按钮", confirmTitle: "确定按钮") { alertView, btnType, index in
            if btnType == .cancelBtn {
                print("点击取消")
            }else {
                
            }
        }
        //alertView.curLevel = PPBaseAlertView.PPAlertLevelHight
        alertView.showAlert()

        
        let alertView2 = PPCommAlertView(title: "这是标题2", content: "这是内容2", cancelTitle: "取消按钮2", confirmTitle: "确定按钮2") { alertView, btnType, index in
            if btnType == .cancelBtn {
                print("点击取消")
            }else {
                
            }
        }
        alertView2.curLevel = PPBaseAlertView.PPAlertLevelHight
        alertView2.showAlert()
        
        
        let config = PPCommAlertConfig()
        config.title = "标题3"
        config.content = "内容3"
        config.isTapBackHidden = true
        let alertView3 = PPCommAlertView(config: config)
        alertView3.showAlert()
    }
}
