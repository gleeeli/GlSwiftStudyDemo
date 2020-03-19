//
//  Rceiver.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2018/9/13.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class Rceiver: NSObject {
    var targetView: UIView?
    var gradientLayer: CAGradientLayer?
    var cashapLayer: CAShapeLayer?
    
    override init() {
        super.init()
        gradientLayer = getBaseGradientLayer()
        cashapLayer = CAShapeLayer()
        cashapLayer?.fillColor = UIColor.blue.cgColor
        cashapLayer?.lineWidth = 1.0;
        cashapLayer?.strokeColor = UIColor.purple.cgColor;
        
        gradientLayer?.mask = cashapLayer;
    }
    
    func DoGradientAnimation(colors:[CGColor]){
        gradientLayer?.removeFromSuperlayer()
        
        gradientLayer?.colors = colors
        gradientLayer?.frame = (targetView?.bounds)!
        targetView?.layer.addSublayer(gradientLayer!)
        
        let radius = CGSize(width: (gradientLayer?.bounds.size.height)!, height: (gradientLayer?.bounds.size.height)!)
        
        cashapLayer?.frame = (targetView?.bounds)!
        
        let bezierpath = UIBezierPath.init(roundedRect: (gradientLayer?.bounds)!, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: radius)
        cashapLayer?.path = bezierpath.cgPath
        
        let rect = targetView?.frame
//        targetView?.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
//        var position = targetView?.layer.position
//        position?.x = 0
//        targetView?.layer.position = position!
        
        
        var startRect = rect
        startRect?.size.width = (rect?.size.height)! * 0.5
//        let bAnimation = CABasicAnimation(keyPath: "bounds")
//        bAnimation.duration = 5;
//        bAnimation.fromValue = startRect;
//        bAnimation.toValue = rect;
//        bAnimation.isRemovedOnCompletion = false
//        targetView?.layer.add(bAnimation, forKey: "bounds")
        
        targetView?.frame = startRect!
        UIView.animate(withDuration: 5.0) {
            self.targetView?.frame = rect!
        }
    }
    
    func DoBackAStep(colors:[CGColor]) {
        gradientLayer?.colors = colors
    }
    
    func getBaseGradientLayer() -> CAGradientLayer {
        let gradientlayer = CAGradientLayer()
        gradientlayer.startPoint = CGPoint(x: 0, y: 0)
        gradientlayer.endPoint = CGPoint(x: 1, y: 0)
        return gradientlayer
    }
}
