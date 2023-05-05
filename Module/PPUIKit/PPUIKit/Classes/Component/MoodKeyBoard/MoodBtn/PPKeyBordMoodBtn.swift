//
//  KeyBordMoodBtn.swift
//  AdModule
//
//  Created by WJK on 2022/6/13.
//

import UIKit
import Lottie

// MARK: 心情按钮
public class PPKeyBordMoodBtn: UIButton {
    var isSelectIndex = 0
    var selectColor: UIColor?
    public override var isSelected: Bool {
        didSet {
            if self.isSelected {
                backImagev.image = UIImage.pp_imageNamed("mc_indicator_down")
                if isSelectIndex == 0 {
                    icon.setImage(UIImage.pp_imageNamed("mood_normal_green"), for: .normal)
                }
            } else {
                backImagev.image = UIImage.pp_imageNamed("mc_indicator_right")
                if isSelectIndex == 0 {
                    icon.setImage(UIImage.pp_imageNamed("mood_normal_gray"), for: .normal)
                }
            }
        }
    }
    // 选择
    public func select(color: UIColor, colorKey: String, form: String) {
        self.isSelectIndex = 1
        self.matchingView.pause()
        self.matchingView.isHidden = false
        icon.setImage(UIImage.pp_imageNamed(""), for: .normal)
        icon.backgroundColor = color
        let form = PPMoodColorManager.getRealFormName(colorKey, formName: form, directionIsMy: true)
        self.matchingView.pp_setAnimationNamed(form)
        self.matchingView.play()
//        self.matchingView.loopAnimation = true
    }

    /// 重置
    public  func resetSelect() {
        self.isSelectIndex = 0
        self.isSelected = self.isSelected
        self.matchingView.pause()
        self.matchingView.isHidden = true
        icon.backgroundColor = .white
    }

    lazy var icon: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))

        btn.setViewCornerRadius(btn.height/2.0)
        btn.setImage(UIImage.pp_imageNamed("mood_normal_gray"), for: .normal)
        btn.isUserInteractionEnabled = true
        btn.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
        return btn

    }()

    lazy var backImagev: UIImageView = {
        let imagev = UIImageView(frame: self.bounds)
        imagev.isUserInteractionEnabled = true
        imagev.image = UIImage.pp_imageNamed("mc_indicator_right")
        return imagev
    }()

    lazy var matchingView: LOTAnimationView = {
        let animationView = LOTAnimationView()
        animationView.frame = CGRect(x: 0, y: 0, width: 55, height: 25)
        animationView.loopAnimation = true
        animationView.isUserInteractionEnabled = false

        return animationView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc public func closeBtnAction() {
        self.isSelected = !self.isSelected
        self.sendActions(for: .touchUpInside)

    }

    func setupUI() {

        self.addSubview(icon)
        self.addSubview(matchingView)
        self.addSubview(backImagev)
        matchingView.snp.makeConstraints { make in
//            make.left.top.bottom.equalTo(self)
            make.size.equalTo(CGSize(width: 55, height: 25))
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-12.5)
        }

        icon.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(self)
            make.size.equalTo(CGSize(width: 36, height: 36))
            make.right.equalTo(self.right).offset(-13)
        }
        backImagev.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(4)
            make.centerY.equalTo(icon.snp.centerY)
        }

    }

}
