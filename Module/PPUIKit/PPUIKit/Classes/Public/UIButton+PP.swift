//
//  UIButton+PP.swift
//  PPUIKit
//
//  Created by liguanglei on 2023/2/16.
//

import Foundation


public extension UIButton {
    func setDarkDisableBackground(state: UIControl.State) {
        let image = UIImage.pp_imageNamed("pp_theme_btn_bg_disable_dark")
        self.setBackgroundImage(image, for: state)
    }
    
    func setNormalDarkBackground(state: UIControl.State) {
        let image = UIImage.pp_imageNamed("pp_theme_btn_bg_normal_dark")
        self.setBackgroundImage(image, for: state)
    }
    
    func setNormalBackground(state: UIControl.State) {
        let image = UIImage.pp_imageNamed("pp_theme_btn_bg_normal")
        self.setBackgroundImage(image, for: state)
    }
    
    func setNormalPressBackground() {
        let image = UIImage.pp_imageNamed("pp_theme_btn_bg_press")
        self.setBackgroundImage(image, for: .highlighted)
    }
    
    func setNormalDisableBackground(state: UIControl.State) {
        let image = UIImage.pp_imageNamed("pp_theme_btn_bg_disable")
        self.setBackgroundImage(image, for: state)
    }
    
    
}
