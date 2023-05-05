//
//  CMPanAlertView.swift
//  ConfigModule
//
//  Created by 林庆霖 on 2022/4/22.
//

import UIKit
import XHBSwiftKit
import RxSwift

open class PPCMPanAlertView: UIView {

    public static let automaticHeight: CGFloat = -1

    // 属性设置在constructView后不生效
    // 设置内容的高度，自适应约束设置为CMPanAlertView.automaticHeight
    public var contentHeight: CGFloat =  UIScreen.main.bounds.size.height / 2

    // 额外的高度计算，如键盘

    private var extraHeight: CGFloat = 0

    // 弹窗收起临界点，默认1/4
    private var _dismissPercent: CGFloat = 1/4
    public var dismissPercent: CGFloat {
        set {
            if newValue < 0 || newValue > 1 {
                return
            }
            _dismissPercent = newValue
        }
        get {
            return _dismissPercent
        }
    }

    public var backTapEnable: Bool = true {
        didSet {
            if backTapEnable {
                bgView.addGestureRecognizer(backTapGesture)
            } else {
                bgView.removeGestureRecognizer(backTapGesture)
            }
        }
    }

    public var cornerRadius: CGFloat = 16

    public override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: container.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: .init(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        container.layer.mask = mask
    }

    open func constructView() {
        guard nil != superview else {
            return
        }

        isHidden = true

        addSubview(bgView)
        addSubview(container)
        container.backgroundColor = PPUIColor.themeDark2Color
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        container.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.snp.bottom)
        }

        container.addSubview(panView)
        container.addSubview(contentView)
        container.addSubview(safeAreaView)
        panView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(panView.snp.bottom)
            make.left.right.equalToSuperview()
            if contentHeight != PPCMPanAlertView.automaticHeight {
                make.height.equalTo(contentHeight).priority(.required)
            }
        }
        safeAreaView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(contentView.snp.bottom)
            make.height.equalTo(CM_UISafeAreaBottomMargin)
        }
    }

    private var hasConstructNotification: Bool = false

    open func constructNotification() {
        if hasConstructNotification {
            return
        }
        hasConstructNotification = true
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification, object: nil).subscribe(onNext: {[weak self] notification in
            guard let self = self else { return }
            if let userInfo = notification.userInfo {
                let keyboardRect = userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect ?? CGRect.zero
                let duration = userInfo["UIKeyboardAnimationDurationUserInfoKey"] as! Double
                self.extraHeight = -keyboardRect.height
                self.updateContainer(offset: -self.container.height + self.extraHeight, animate: true, duration: duration)
            }
        }).disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification, object: nil).subscribe(onNext: {[weak self] notification in
            guard let self = self else { return }
            var duration = 0.25
            if let userInfo = notification.userInfo {
                duration = userInfo["UIKeyboardAnimationDurationUserInfoKey"] as? Double ?? 0
            }
            self.extraHeight = 0
            self.updateContainer(offset: -self.container.height, animate: true, duration: duration)
        }).disposed(by: disposeBag)
    }

    /**
     显示弹窗
     */
    @objc open func show() {
        guard let window = CM_UISwiftWindow else {
            return
        }
        window.addSubview(self)
        frame = window.bounds

        constructView()
        setNeedsLayout()
        layoutIfNeeded()

        constructNotification()

        isHidden = false
        animation { [self] in
            bgView.alpha = 1
        }
        popup()
    }

    open func constructAndPopUp() {
        constructView()
        setNeedsLayout()
        layoutIfNeeded()

        constructNotification()

        isHidden = false
        animation { [self] in
            bgView.alpha = 1
        }
        popup()
    }

    /**
     弹出弹窗至底部与视图底部贴合
     */
    @objc open func popup(animate: Bool = true) {
        updateContainer(offset: -container.height + extraHeight, animate: animate)
    }

    /**
     移除弹窗
     */
    @objc open func dismiss() {
        popdown()
        animation { [self] in
            bgView.alpha = 0
        } completion: { [self] _ in
            removeFromSuperview()
        }
    }

    @objc open func popdown() {
        updateContainer(offset: 0, animate: true)
    }

    /**
     更新弹窗的位置
     @param offset: 弹窗顶部与视图底部的偏移量
     */
    open func updateContainer(offset: CGFloat, animate: Bool = false, duration: TimeInterval = 0.25, completion: ((Bool) -> Void)? = nil) {
        let update: ((CGFloat) -> Void) = { [self] offset in
            let margin = min(max(offset, -container.height + extraHeight), 0)
            container.snp.updateConstraints { make in
                make.top.equalTo(self.snp.bottom).offset(margin)
            }
            setNeedsLayout()
            layoutIfNeeded()
        }

        if animate {
            animation(duration: duration, animation: {
                update(offset)
            }, completion: completion)
        } else {
            update(offset)
        }
    }

    open func animation(duration: TimeInterval = 0.25, animation: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: animation, completion: completion)
    }

    public let disposeBag = DisposeBag()

    public lazy var bgView = UIView().then {
        $0.alpha = 0
        $0.backgroundColor = PPUIColor.bgNormalBlackAlpha03Color
        $0.addGestureRecognizer(backTapGesture)
    }

    public lazy var container = UIView().then {
        $0.backgroundColor = .white
    }

    public lazy var panView: CMPanView = CMPanView().then {
        $0.minOffset = {
            return 0
        }
        $0.maxOffset = { [weak self] in
            return self?.container.height ?? 0
        }
        $0.finishedAtOffset = { [weak self] offset in
            guard let self = self else {
                return
            }
            if offset < self.container.height * self.dismissPercent {
                self.popup()
            } else {
                self.dismiss()
            }
        }
    }

    public lazy var contentView = UIView()

    public lazy var safeAreaView = UIView()

    private lazy var backTapGesture = UITapGestureRecognizer().then {
        $0.rx.event.subscribe { [weak self] _ in
            self?.dismiss()
        }.disposed(by: disposeBag)
    }
}
