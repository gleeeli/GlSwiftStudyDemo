//
//  MBProgressHUD+Toast.swift
//  SwiftDevelopFramework
//
//  Created by gleeeli on 2020/6/15.
//  Copyright © 2020 GL. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {
    private class func show(_ text: String?, icon: String?) {
        
        guard let view:UIView = UIApplication.shared.keyWindow else { return }
        // 快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        // 允许背景可点击
        hud.isUserInteractionEnabled = false
        hud.label.text = text
        
        // 设置图片
        if let icon = icon {
            let image = UIImage(named: "SLMBProgressHUDBundle.bundle/\(icon)")?.withRenderingMode(.alwaysTemplate)
            hud.customView = UIImageView(image: image)
        }
        // 再设置模式
        hud.mode = .customView
        hud.isSquare = true
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
    
        // 0.9秒之后再消失
        hud.hide(animated: true, afterDelay: 0.89)
    }
    
    private class func showMessage(_ message: String?, btnTitle: String?, target: Any?, action: Selector) {
        guard let view:UIView = UIApplication.shared.keyWindow else { return }
        // 快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        // 允许背景可点击
        hud.isUserInteractionEnabled = false
        hud.label.text = message
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        // 需要蒙版效果
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.5)
        hud.button.setTitle(btnTitle, for: .normal)
        hud.button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    /// 仅显示文字提示
    public class func showToast(_ message: String?) {
        guard let view:UIView = UIApplication.shared.keyWindow else { return }
//        let hud = MBProgressHUD.showAdded(to: view, animated: false)
        let hud = MBProgressHUD.init(view: view)
        view.addSubview(hud)
        // 允许背景可点击
        hud.isUserInteractionEnabled = false
        hud.mode = .text
        hud.isSquare = false;
        hud.label.text = message
        hud.backgroundView.blurEffectStyle = .dark;
        //设置字后面的背景色颜色
        hud.bezelView.blurEffectStyle = .dark;
        //文字颜色
        hud.label.textColor = UIColor.white;
        hud.removeFromSuperViewOnHide = true;
        hud.show(animated: true)
        hud.hide(animated: true, afterDelay: 2)
        
    }
    
    /// 显示菊花
    public class func showLoading(_ message: String?) -> MBProgressHUD? {
        guard let view:UIView = UIApplication.shared.keyWindow else { return nil}
        // 快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = false
        hud.label.text = message
        
        //设置字后面的背景色颜色
        hud.bezelView.blurEffectStyle = .dark;
        
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        // 需要蒙版效果
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.5)
        hud.backgroundView.blurEffectStyle = .light;
        hud.contentColor = UIColor.white;
        return hud
    }
    
    /// 普通信息提示
    public class func showInfo(_ message: String?) {
        self.show(message, icon: "info")
    }
    /// 显示正确提示
    public class func showSuccess(_ message: String?) {
        self.show(message, icon: "success")
    }
    /// 显示错误提示
    public class func showError(_ message: String?) {
        self.show(message, icon: "error")
    }
    /// 隐藏
    public class func hide() {
        guard let view:UIView = UIApplication.shared.keyWindow else { return }
        self.hide(for: view, animated: true)
    }
}
