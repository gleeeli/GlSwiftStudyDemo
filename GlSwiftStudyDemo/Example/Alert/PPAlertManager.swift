//
//  PPAlertManager.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/5/5.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import Foundation

@objc public class PPAlertManager: NSObject {
    public static let share = PPAlertManager()
    private var alertViews: [PPBaseAlertView] = []
    private weak var curAlertView: PPBaseAlertView?
    
    private override init() {
        super.init()
    }
    
    func showAlertViewIfCan(view: PPBaseAlertView)  {
        if !self.isExistAlertView(view: view) {
            alertViews.append(view)
        }
        
        if self.alertViews.count > 1 {//当前已经有弹窗在显示
            self.sortAlerViews()
            
            if  let curAlertView = self.curAlertView, let firstView = self.alertViews.first {
                if curAlertView.curLevel < firstView.curLevel {
                    curAlertView.hiddenWaitShowAlert {
                        firstView.showOnView()
                    }
                    
                }
            }else if let firstView = self.alertViews.first {
                firstView.showOnView()
            }
                
        }else if self.curAlertView == nil {
            view.showOnView()
            
        }
    }
    
    /// 移除弹框，自动弹出下一个
    func removeAndFindNextAlert(view: PPBaseAlertView) {
        self.removeAlertView(view: view)
        self.findNextAlertView()
    }
    

    func findNextAlertView() {
        self.sortAlerViews()
        
        if self.alertViews.count > 0, let firstView = self.alertViews.first {
            firstView.showAlert()
        }
    }
}

extension PPAlertManager {
    func isExistAlertView(view: PPBaseAlertView) -> Bool {
        var isExist = false
        self.alertViews.forEach { item in
            if item.isEqual(view) {
                isExist = true
            }else {
                isExist = false
            }
        }
        
        return isExist
    }
    
    /// 移除某个弹框
    func removeAlertView(view: PPBaseAlertView) {
        for (index,item) in self.alertViews.enumerated().reversed() {
            if item.isEqual(view) {
                self.alertViews.remove(at: index)
                print("移除alert: \(view)")
            }
        }
    }
    
    //所有弹框排序
    func sortAlerViews() {
        self.alertViews = alertViews.sorted { item1, item2 in
            if item1.curLevel > item2.curLevel {
                return true
            }else {
                return false
            }
        }
    }
}


extension PPAlertManager {
    func haveShowOnView(view: PPBaseAlertView) {
        self.curAlertView = view
    }
    
    func haveRemoveFromOnView() {
        self.curAlertView = nil
    }
}
