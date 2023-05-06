//
//  PPAlertView.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/5/5.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import Foundation


@objc public class PPBaseAlertView: UIControl {
    public var curLevel: Int  = PPBaseAlertView.PPAlertLevelDefault
    public var onView: UIView? = UIApplication.shared.delegate?.window ?? nil
    var isTapBackHidden = false
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension PPBaseAlertView {
    static let PPAlertLevelLow: Int = 0
    static let PPAlertLevelDefault: Int = 1
    static let PPAlertLevelHight: Int = 2
}

extension PPBaseAlertView {
    func setUI() {
        self.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
    }
    
    @objc func cancelClick() {
        if self.isTapBackHidden {
            self.hiddenAlert {
                
            }
        }
    }
    
    func removeFromOnView(isAnimate: Bool, complete:@escaping ()->()) {
        if isAnimate {
            UIView.animate(withDuration: 0.2) {
                self.alpha = 0
            } completion: { _ in
                self.removeSelfFromSuperViewAndManager()
                complete()
            }
        }else {
            self.removeSelfFromSuperViewAndManager()
            complete()
        }
    }
    
    private func removeSelfFromSuperViewAndManager() {
        self.removeFromSuperview()
        PPAlertManager.share.haveRemoveFromOnView()
    }
    
    func showOnView() {
        if self.superview != onView {
            self.removeFromSuperview()
            onView?.addSubview(self)
            self.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            self.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
            }
        }
        //设置当前弹框正在显示
        PPAlertManager.share.haveShowOnView(view: self)
    }
}


extension PPBaseAlertView: PPAlertProtocol {
    public func showAlert() {
        PPAlertManager.share.showAlertViewIfCan(view: self)
    }

    public func hiddenAlert(_ complete: (()->())? = nil) {
        self.removeFromOnView(isAnimate: true) {[weak self] in
            guard let self = self else {
                return
            }
            PPAlertManager.share.removeAndFindNextAlert(view: self)
            complete?()
        }
        
    }
    
    public func hiddenWaitShowAlert(_ complete: (()->())? = nil) {
        self.removeFromOnView(isAnimate: false) {
            complete?()
        }
    }
    
    func showAlertOnView(view: UIView) {
        self.onView = view
        self.showAlert()
    }
}




