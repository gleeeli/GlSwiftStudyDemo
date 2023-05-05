//
//  PPGradedView.swift
//  DemoSwiftModule
//
//  Created by WJK on 2022/10/12.
//

import UIKit

public enum GradedViewLevel: Int {
    case first = 1
    case second = 2
    case third = 3
    case fourth = 4
    case fifth = 5
    case sixth = 6
    case seventh = 7
    case eighth = 8
    case ninth = 9
}

public class PPGradedView: UIView, AlertPopProtocol {

    public var app_level: GradedViewLevel = .eighth
    public var app_isShow: Bool = false

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 展示动画
    public func app_willBeShow(container: UIView) {
        container.addSubview(self)
    }

    /// 隐藏动画
    public func app_willBeHidden(completion:@escaping (_ isFinished: Bool) -> Void ) {
        self.removeFromSuperview()
        completion(true)

    }

    func showView(_ isShow: Bool) {
        if self.app_isShow == isShow {
            return
        }
        self.app_isShow = isShow

        if app_isShow {
            PPAlertPopManager.shareInstance.addToQueneView(view: self)
        } else {
            PPAlertPopManager.shareInstance.removeToQueneView(view: self)
        }
    }
}
