//
//  MOMomentLianmaizhongView.swift
//  AdModule
//
//  Created by WJK on 2022/7/18.
//

import UIKit
import Lottie

public class MOMomentLianmaizhongView: UIView {
    lazy var animationView: LOTAnimationView = {
        // 22 22
        var size: CGFloat = 11
        if self.width == 83 {
            size =  13
        }
        let anim = LOTAnimationView(frame: CGRect(x: 4, y: (self.height - size) / 2.0, width: size, height: size))
        anim.pp_setAnimationNamed("Lianmaizhong")
        return anim
    }()

    lazy var contentLabel: UILabel = {
        // 22 22
        var size: CGFloat = 11
        if self.width == 83 {
            size =  14
        }
        let anim = UILabel()
        anim.font = .peiPei.aliFontRegular(ofSize: size)
        anim.textColor = .white
        anim.text = "连麦中"
        anim.sizeToFit()
        anim.centerY = self.height / 2.0
        anim.left = 17
        return anim
    }()

    public  override init(frame: CGRect) {
        var frameTmp  = CGRect(x: 6, y: 6, width: 58, height: 18)
        if frame != .zero {
            frameTmp = frame
        }
        super.init(frame: frameTmp)
        self.layer.borderWidth = 1
        self.layer.borderColor = PPUIColor.textNormalWhiteAlpha04Color.cgColor
        self.layer.cornerRadius = self.height / 2.0
        self.layer.masksToBounds = true

        self.addSubview(animationView)
        self.addSubview(contentLabel)

        self.backgroundColor = PPUIColor.bgNormalBlackAlpha03Color
        animationView.centerY = self.height / 2.0
        contentLabel.centerY = self.height / 2.0

        let x = (self.width - animationView.width - contentLabel.width - 2 ) / 2.0

        animationView.left = x
        contentLabel.left = animationView.right + 2

    }

    public override var isHidden: Bool {
        didSet {
            if isHidden {
                self.animationView.stop()
            } else {
                self.animationView.loopAnimation = true
                self.animationView.play()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
