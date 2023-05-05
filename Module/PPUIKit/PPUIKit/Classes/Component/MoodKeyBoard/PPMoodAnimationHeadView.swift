//
//  PPMoodAnimationHeadView.swift
//  MessageCenterModule
//
//  Created by WJK on 2022/4/1.
//

import UIKit
import Lottie

public class PPMoodAnimationHeadView: UIControl {
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 55, height: 25))
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let backAnimation = LOTAnimationView() /// 背景
    let frontAnimation = LOTAnimationView()/// 前景

}

public extension PPMoodAnimationHeadView {

    /// 设置动画
    /// - Parameters:
    ///   - name: 动画名称
    ///   - directionIsMy: true 是自己方向

    public func setanimationName(_ colorName: String, formName: String, directionIsMy: Bool) {

        let realColorName = PPMoodColorManager.getRealEmojiName(colorName, formName: formName, directionIsMy: directionIsMy)

        let realFormName = PPMoodColorManager.getRealFormName(colorName, formName: formName, directionIsMy: directionIsMy)

        backAnimation.stop()
        frontAnimation.stop()

        backAnimation.pp_setAnimationNamed(realFormName)
        frontAnimation.pp_setAnimationNamed(realColorName)

        backAnimation.loopAnimation = false
        frontAnimation.loopAnimation = false

        backAnimation.play()
        frontAnimation.play()

        backAnimation.isHidden = false
        frontAnimation.isHidden = false
    }

    public  func play() {
        backAnimation.play()
        frontAnimation.play()
    }
}

extension PPMoodAnimationHeadView {
    public  func hiddenheadView() {
        backAnimation.stop()
        frontAnimation.stop()
        backAnimation.isHidden = true
        frontAnimation.isHidden = true
    }
}

extension PPMoodAnimationHeadView {
    func setupUI() {

        self.addSubview(frontAnimation)
        self.addSubview(backAnimation)
        backAnimation.frame = self.bounds
        frontAnimation.frame = self.bounds

        self.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 55, height: 25))
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSelfAction))
        self.addGestureRecognizer(tap)
    }

   @objc func tapSelfAction() {
       self.sendActions(for: .touchUpInside)
    }
}
