//
//  PPTeenagersPopUpView.swift
//  AdModule
//
//  Created by WJK on 2022/8/4.
// 青少年弹窗

import UIKit
import PPBaseModule
import  HBPublic

public let showTeenagersInfoView = "showTeenagersInfoView"

@objc public  class PPTeenagersPopUpView: UIView, AlertPopProtocol {
    public var app_level: GradedViewLevel = .sixth

    public var app_isShow: Bool = false

    private var completeBlock: ((_ result: Bool)->Void)?

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var maskVIew = UIView()
    var contentView = UIView()
    var icon = UIImageView()
    var title = UILabel()
    var contentLabel = UILabel()
    var inToTeenagersBtn = UIButton()
    var okBtn = UIButton()
}

public extension PPTeenagersPopUpView {
    @objc static func show(complete:((_ result: Bool)->Void)?) {
        if !isShowTeenager() {
            complete?(false)
            return
        }
        PPTeenagersPopUpView().show(complete: complete)
        saveTeenagers()
    }

   private static func saveTeenagers() {
        UserDefaults.standard.set(true, forKey: getTeenagersKey())

    }

    private static func isShowTeenager() -> Bool {

        return  !UserDefaults.standard.bool(forKey: getTeenagersKey())
    }

    private static func getTeenagersKey() -> String {
        return "Teenagers_Teenagers"
    }
}

extension PPTeenagersPopUpView {

   @objc func intoTeenagersAction() {
       self.hiden()
       XHBRouter.share().run(withURL: "MineModule.MMYoungController")
    }

   @objc func sureBtnAction() {
       self.hiden()
    }

    func show(complete:((_ result: Bool)->Void)?) {
        if self.superview != nil {
            complete?(false)
            return
        }
        self.completeBlock = complete

        PPAlertPopManager.shareInstance.addToQueneView(view: self)

        // 弹窗曝光埋点
        PPBuriedPointManagerEvent.popShow(type: .system, pop_content: "青少年模式")
    }

    func hiden() {
        PPAlertPopManager.shareInstance.removeToQueneView(view: self)
    }

    public func app_willBeShow(container: UIView) {
        container.addSubview(self)
    }

    public func app_willBeHidden(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.25) {
            self.contentView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2  )
        } completion: {_ in
            self.removeFromSuperview()
            // 当前弹框事件完成
            self.completeBlock?(true)
            self.completeBlock = nil
            completion(true)
        }
    }

}

// MARK: -
extension PPTeenagersPopUpView {
    func setupUI() {

        self.addSubview(maskVIew)
        maskVIew.frame = self.bounds
        maskVIew.backgroundColor = PPUIColor.bgNormalBlackAlpha03Color

        self.addSubview(contentView)
        contentView.backgroundColor = .white

        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(contentLabel)
        contentView.addSubview(inToTeenagersBtn)
        contentView.addSubview(okBtn)
        __setupUI()
    }

    func __setupUI() {
        icon.frame = CGRect(x: 0, y: 0, width: 198, height: 156)
        icon.image = UIImage.pp_imageNamed("teenagers")

        title.text = "青少年模式"
        title.font = .peiPei.aliFontMedium(ofSize: 20)
        title.textColor =  UIColor(red: 0.137, green: 0.157, blue: 0.129, alpha: 1)

        contentLabel.text = "为了呵护青少年健康成长，官方推出青少年模式，该模式下，部分功能将无法使用。请监护人主动选择并设置密码 "
        contentLabel.font = .peiPei.aliFontRegular(ofSize: 15)
        contentLabel.textColor =  PPUIColor.textNormalBlackAlpha055Color
        contentLabel.numberOfLines = 0

        inToTeenagersBtn.setTitle("进入青少年模式 >", for: .normal)
        inToTeenagersBtn.setTitleColor(UIColor(red: 0.19, green: 0.91, blue: 0.831, alpha: 1), for: .normal)
        inToTeenagersBtn.titleLabel?.font = UIFont.peiPei.aliFontMedium(ofSize: 15)
        inToTeenagersBtn.frame = CGRect(x: 0, y: 0, width: 259, height: 26)
        inToTeenagersBtn.addTarget(self, action: #selector(intoTeenagersAction), for: .touchUpInside)

        okBtn.setImage(.pp_imageNamed("pp_ok_btn"), for: .normal)
        okBtn.frame = CGRect(x: 0, y: 0, width: 259, height: 57)
        okBtn.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)

        icon.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(22)
            make.size.equalTo(CGSize(width: 198, height: 156))
            make.centerX.equalTo(contentView.snp.centerX)

        }

        title.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(32)
            make.centerX.equalTo(contentView.snp.centerX)
        }

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.centerX.equalTo(contentView.snp.centerX)
            make.left.equalTo(contentView.snp.left).offset(28)
            make.right.equalTo(contentView.snp.right).offset(-28)
        }

        inToTeenagersBtn.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(22)
            make.left.equalTo(contentView.snp.left).offset(28)
            make.right.equalTo(contentView.snp.right).offset(-28)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(26)
        }

        okBtn.snp.makeConstraints { make in
            make.top.equalTo(inToTeenagersBtn.snp.bottom).offset(20)

            make.centerX.equalTo(contentView.snp.centerX)
            make.left.equalTo(contentView.snp.left).offset(28)
            make.right.equalTo(contentView.snp.right).offset(-28)
            make.height.equalTo(57)
            make.bottom.equalTo(contentView.snp.bottom).offset(-30)
        }

        contentView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
            make.center.equalTo(self.snp.center)
        }

        contentView.setViewCornerRadius(16)
    }
}
