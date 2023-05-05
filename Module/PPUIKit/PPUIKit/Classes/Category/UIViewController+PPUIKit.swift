//
//  UIViewController+PPUIKit.swift
//  PPUIKit
//
//  Created by liguanglei on 2022/10/29.
//

import UIKit

public extension UIViewController {
    
    private struct PPAssociatedKeys {
        static var ppbackImageViewkey = "peipeibackImageView"
    }

    private var ppBackImageView: UIImageView {
        get {
            if let bgImageView = objc_getAssociatedObject(self, &PPAssociatedKeys.ppbackImageViewkey) as? UIImageView {
                return bgImageView
            }
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            objc_setAssociatedObject(self, &PPAssociatedKeys.ppbackImageViewkey, imageView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return imageView
        }
    }
    
    func clearOtherMyClassVcFromNavigationVCs() {
        if var vcs = self.navigationController?.viewControllers {
            vcs.removeAll {[weak self] vc in
                guard let self = self else {
                    return false
                }
                if vc != self, vc.isKind(of: self.classForCoder) {
                    return true
                }
                return false
            }
            self.navigationController?.viewControllers = vcs
        }
    }
    
    func setIos11PhoneNavigation() {
        if #available(iOS 13, *) {

        } else {//处理低端机iOS11，无效的bug
            self.navigationController?.navigationBar.barTintColor = PPUIColor.bgDarkGradient4Color
        }
    }
    
    func setBackImageView(image: UIImage?) {
        self.ppBackImageView.image = image
        if self.ppBackImageView.superview != self.view {
            self.ppBackImageView.removeFromSuperview()
            self.view.addSubview(self.ppBackImageView)
            self.ppBackImageView.snp.makeConstraints { make in
                make.top.leading.bottom.trailing.equalToSuperview()
            }
        }
        self.view.sendSubviewToBack(self.ppBackImageView)
    }
    
    func setStoryDefaultBackImage() {
        self.setBackImageView(image: UIImage.pp_imageNamed("pp_comm_bg_image"))
    }
}
