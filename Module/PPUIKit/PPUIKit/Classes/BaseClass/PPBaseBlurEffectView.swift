//
//  PPBaseBlurEffectView.swift
//  PPUIKit
//
//  Created by liguanglei on 2023/2/17.
//

import UIKit

open class PPBaseBlurEffectView: UIView {

    private var style: UIBlurEffect.Style = .light
    //接着创建一个承载模糊效果的视图
    public lazy var  blurView: UIVisualEffectView = {
        //首先创建一个模糊效果
        let  blurEffect =  UIBlurEffect (style: self.style)
        let blur = UIVisualEffectView (effect: blurEffect)
        return blur
    }()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public init(_ style: UIBlurEffect.Style? = .dark, _ alpha: CGFloat = 0.4) {
        super.init(frame: CGRect.zero)
        self.style = style ?? .dark
        setUI()
        self.blurView.alpha = alpha
    }
    
    public init(frame: CGRect,  style: UIBlurEffect.Style) {
        super.init(frame: frame)
        self.style = style
        setUI()
        self.blurView.alpha = 0.4
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        self.blurView.alpha = 0.4
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setUI() {
        self.addSubview(blurView)
    }
    
    public func setDefaultRadius() {
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置模糊视图的大小（全屏）
        blurView.frame.size =  self.bounds.size
    }

}
