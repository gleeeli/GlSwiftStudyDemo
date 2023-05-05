//
//  UIView+PPUIKit.swift
//  PPUIKit
//
//  Created by 林庆霖 on 2022/6/8.
//

import Foundation
import PPBaseModule

@objc public enum PanActionArea: Int {
    case bar
    case all
}

@objc public enum PanBarStyle: Int {
    case light
    case dark
}

public enum PanBarActionType {
    case enabled(target: UIView? = nil, area: PanActionArea = .bar, barStyle: PanBarStyle = .light, minOffset: (() -> CGFloat)? = nil, maxOffset: (() -> CGFloat)? = nil, finishedOffset: ((CGFloat) -> Void)? = nil)
    case disabled
}

public extension PeiPeiExtension where Base: UIView {
    @discardableResult
    func panEnabled(_ enabled: PanBarActionType) -> CMPanView? {
        switch enabled {
        case .enabled(let target, let area, let barStyle, let minOffset, let maxOffset, let finishedOffset):
            guard let panBar = base.panBar else {
                return nil
            }
            panBar.target = target
            panBar.area = area
            panBar.barStyle = barStyle
            panBar.minOffset = minOffset
            panBar.maxOffset = maxOffset
            panBar.finishedAtOffset = finishedOffset
            base.addSubview(panBar)
            panBar.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(40)
            }
        case .disabled:
            base.panBar?.removeFromSuperview()
            base.panBar = nil
        }
        return base.panBar
    }
}

extension UIView {
    private struct AssociatedKeys {
        static var panBar = "panBar"
    }
    fileprivate var panBar: CMPanView? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.panBar, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let view = objc_getAssociatedObject(self, &AssociatedKeys.panBar) as? CMPanView {
                return view
            } else {
                let view = CMPanView()
                objc_setAssociatedObject(self, &AssociatedKeys.panBar, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return view
            }
        }
    }
    
    /// UIView转UIImage
    public func toImage() -> UIImage {
        //第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        self.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}


public extension UIView {
    ///各圆角大小
    public struct PPCornerRadii {
        public var topLeft : CGFloat = 0
        public var topRight : CGFloat = 0
        public var bottomLeft : CGFloat = 0
        public var bottomRight : CGFloat = 0
        
        public init(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
            self.topLeft = topLeft
            self.topRight = topRight
            self.bottomLeft = bottomLeft
            self.bottomRight = bottomRight
        }
    }
    
    ///添加4个不同大小的圆角
    func addCorner(cornerRadii: PPCornerRadii) {
       let path = createPathWithRoundedRect(bounds: self.bounds, cornerRadii:cornerRadii)
       let shapLayer = CAShapeLayer()
       shapLayer.frame = self.bounds
       shapLayer.path = path
       self.layer.mask = shapLayer
    }
    
    ///切圆角函数绘制线条
    func createPathWithRoundedRect( bounds:CGRect,cornerRadii:PPCornerRadii) -> CGPath
    {
        let minX = bounds.minX
        let minY = bounds.minY
        let maxX = bounds.maxX
        let maxY = bounds.maxY
        
        //获取四个圆心
        let topLeftCenterX = minX +  cornerRadii.topLeft
        let topLeftCenterY = minY + cornerRadii.topLeft
         
        let topRightCenterX = maxX - cornerRadii.topRight
        let topRightCenterY = minY + cornerRadii.topRight
        
        let bottomLeftCenterX = minX +  cornerRadii.bottomLeft
        let bottomLeftCenterY = maxY - cornerRadii.bottomLeft
         
        let bottomRightCenterX = maxX -  cornerRadii.bottomRight
        let bottomRightCenterY = maxY - cornerRadii.bottomRight
        
        //虽然顺时针参数是YES，在iOS中的UIView中，这里实际是逆时针
        let path :CGMutablePath = CGMutablePath();
         //顶 左
        path.addArc(center: CGPoint(x: topLeftCenterX, y: topLeftCenterY), radius: cornerRadii.topLeft, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: false)
        //顶右
        path.addArc(center: CGPoint(x: topRightCenterX, y: topRightCenterY), radius: cornerRadii.topRight, startAngle: CGFloat.pi * 3 / 2, endAngle: 0, clockwise: false)
        //底右
        path.addArc(center: CGPoint(x: bottomRightCenterX, y: bottomRightCenterY), radius: cornerRadii.bottomRight, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: false)
        //底左
        path.addArc(center: CGPoint(x: bottomLeftCenterX, y: bottomLeftCenterY), radius: cornerRadii.bottomLeft, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: false)
        path.closeSubpath();
         return path;
    }
}
