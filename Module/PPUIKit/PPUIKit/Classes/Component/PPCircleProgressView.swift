//
//  PPCircleProgressView.swift
//  MessageCenterModule
//
//  Created by liguanglei on 2022/12/1.
//

import UIKit

public class PPCircleProgressView: UIView {
    var progess: Float = 0.0 // 环形进度
    var lineWidth: CGFloat = 0.0 // 环形的宽
    private var foreLayer: CAShapeLayer? // 进度条的layer层（可做私有属性）
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // 覆写父类构造器后这个方法是必须实现的
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 遍历构造器传入frame，以及进度条宽度
    public convenience init(frame: CGRect, lineWidth: CGFloat) {
        self.init(frame: frame)
        self.lineWidth = lineWidth
        seup(rect: frame) // 绘制自定义视图的函数
    }
    
    func seup(rect: CGRect) -> Void {
        // 背景圆环（灰色背景）
//        let shapeLayer: CAShapeLayer = CAShapeLayer.init()
//        // 设置frame
//        shapeLayer.frame = CGRect.init(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
//        shapeLayer.lineWidth = self.lineWidth
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.strokeColor = UIColor.init(red: 50/255, green: 40/255, blue: 50/255, alpha: 1).cgColor
        
        let center: CGPoint = CGPoint.init(x: rect.size.width/2, y: rect.size.height/2)
        // 画出曲线（贝塞尔曲线）
        let startAngle = CGFloat(1.5 * Double.pi)// CGFloat(-0.5 * Double.pi)
        let endAngle = CGFloat(-0.5 * Double.pi)// CGFloat(1.5 * Double.pi)
        let bezierPath: UIBezierPath = UIBezierPath.init(arcCenter: center, radius: (rect.size.width - self.lineWidth)/2, startAngle: startAngle, endAngle: endAngle, clockwise: false)
//        shapeLayer.path = bezierPath.cgPath // 将曲线添加到layer层
        
//        self.layer.addSublayer(shapeLayer) // 添加蒙版
        
        // 渐变色 加蒙版 显示蒙版区域
        let gradientLayer: CAGradientLayer = CAGradientLayer.init()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = NSArray.init(array: [PPUIColor.themeP0Color.cgColor, PPUIColor.themeP0Color.cgColor]) as? [Any]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
        
        self.layer.addSublayer(gradientLayer) // 将渐变色添加带layer的子视图
        
        self.foreLayer = CAShapeLayer.init()
        self.foreLayer?.frame = self.bounds
        self.foreLayer?.fillColor = UIColor.clear.cgColor
        self.foreLayer?.lineWidth = self.lineWidth
        
        self.foreLayer?.strokeColor = UIColor.red.cgColor
        self.foreLayer?.strokeEnd = 0
        self.foreLayer?.lineCap = .round // 设置画笔
        self.foreLayer?.path = bezierPath.cgPath
        // 修改渐变layer层的遮罩, 关键代码
        gradientLayer.mask = self.foreLayer
    }
    
    public func setProgress(value: Float) -> Void {
        
        progess = value // 设置当前属性的值
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.foreLayer?.strokeEnd = CGFloat(progess) // 视图改变的关键代码
        CATransaction.commit()
    }
}
