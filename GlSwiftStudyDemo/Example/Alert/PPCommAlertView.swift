//
//  PPAlertView.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/5/6.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import Foundation

@objc public class PPCommAlertConfig: NSObject {
    public var image: UIImage?
    public var title: String?
    public var content: String?
    // content下面需要插入view，调用这个block
    public var configureExtraView:((_ contentView: UIView) -> UIView)?
    public var cancelTitle: String? {
        didSet {
            if let cancelTitle = self.cancelTitle {
                self.cancelAttributeTitle = NSAttributedString(string: cancelTitle)
            }
            
        }
    }
    public var confirmTitle: String? {
        didSet {
            if let confirmTitle = self.confirmTitle {
                self.confirmAttributeTitle = NSAttributedString(string: confirmTitle)
            }
            
        }
    }

    public var cancelAttributeTitle: NSAttributedString?
    public var confirmAttributeTitle: NSAttributedString?
    
    // 点击确定，取消按钮
    public var actionCallBack: ((_ alertView: PPCommAlertView, _ btnType: PPCommAlertBtnType, _ index: Int) -> Void)?
    //点击周围空白处
    public var tapBackCallback: (() -> Void)?
    
    public var hasColseBtn: Bool = false
    //点击空白是否消失
    var isTapBackHidden = false
    
    public var backgroundColor: UIColor?
    // 可在外部调整所有UI布局
    public var containerSetupUIBlock: ((_ aletView: PPCommAlertView)->Void)?
    
    public var dismissNotificationBlock: (()->Void)?
    public var layoutsubviewBlock: ((_ alertView: PPCommAlertView)->Void)?
    //确定按钮在上，取消按钮在下的布局
    public var isUseSureBtnOnTopAndCancelBtnOnBottom = false
    
    public var maxWidth: CGFloat = 0
    public var topSpace: CGFloat = 27
    public var contentTopSpace: CGFloat = 27
    public var buttonTopSpace: CGFloat = 16
    
    
    public static let cancelBtnTag: Int = 1111
}

@objc public enum PPCommAlertStyle: NSInteger {
    case darkbg // 黑色背景
    case whitebg // 白色背景
}

@objc public enum PPCommAlertBtnType: NSInteger {
    case cancelBtn = 0 // 取消按钮
    case sureBtn = 1 // 确定按钮
    case closeBtn = 2 // 关闭按钮
    case tapSpaceCancel = 3 // 点击空白处取消
    case other = 100
}

public class PPCommAlertView: PPBaseAlertView {
    var config: PPCommAlertConfig = PPCommAlertConfig() // 需要配置的东西
    
    // 指定样式，白色背景，还是黑色背景
    public var style: PPCommAlertStyle = .whitebg {
        didSet {
            switch style {
            case .darkbg:
                self.titleLab.textColor = PPUIColor.textNormalWhiteColor
                self.contentLab.textColor = PPUIColor.white
                self.containerView.backgroundColor = PPUIColor.themeDark2NormalColor
            case .whitebg:
                self.titleLab.textColor = PPUIColor.textNormalBlackColor
                self.contentLab.textColor = PPUIColor.textNormalBlackAlpha08Color
                self.containerView.backgroundColor = PPUIColor.bgNormalWhiteColor
            }
        }
    }
    
    // 容器
    public lazy var containerView = {
        let contentView = UIView.init(frame: .zero)
        contentView.layer.cornerRadius = 16
        contentView.layer.backgroundColor = UIColor.white.cgColor
        return contentView
    }()
    
    //放在标题之上的图片
    var topImageView: UIImageView?
    
    // title
    public lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = PPUIColor.textNormalBlackColor
        lab.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    
    // content
    public lazy var contentLab: UILabel = {
        let lab = UILabel()
        lab.textColor = PPUIColor.textNormalBlackAlpha08Color
        lab.font = UIFont.systemFont(ofSize: 17)
        lab.numberOfLines = 0
        
        return lab
    }()
    
    
    // 额外内容，外部配置
    lazy var extraContentContainerView = UIView.init(frame: .zero)
    

    public lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(PPUIColor.textStressBlackColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        return btn
    }()
    
    public lazy var confirmButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(PPUIColor.textStressBlackColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
//        let imgView = UIImageView.init(image: .peiPei.icon_bt_normal_blue)
//        lab.addSubview(imgView)
//        lab.sendSubviewToBack(imgView)
//        imgView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        return btn
    }()
    
    //灰色背景按钮图片
    var btnLightGrayBackImage = UIImage()//.peiPei.icon_bt_normal_lightgray
    var btnGreenBackImage = UIImage()// .peiPei.icon_bt_normal_blue
    
    public lazy var closeBtn: UIButton = {
        let button =  UIButton()
       // button.setImage(UIImage.config_imageNamed("CM_close_gray_56"), for: .normal)
        return  button
    }()
    
    /// 点击空白处
    override func cancelClick() {
        if self.config.isTapBackHidden {
            self.config.actionCallBack?(self, .tapSpaceCancel, PPCommAlertBtnType.tapSpaceCancel.rawValue)
        }
        super.cancelClick()
    }
}

/// 初始化方法
public extension PPCommAlertView {
    @objc convenience init(title: String?, content: String?, cancelTitle: String, confirmTitle: String?, actionCallBack: ((_ alertView: PPCommAlertView, _ btnType: PPCommAlertBtnType, _ index: Int) -> Void)?) {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.config.title = title
        self.config.content = content
        self.config.cancelTitle = cancelTitle
        self.config.confirmTitle = confirmTitle
        self.config.cancelAttributeTitle = NSAttributedString(string: cancelTitle)
        
        self.config.actionCallBack = actionCallBack
        self.setupUI()
    }
    
    @objc convenience init(config: PPCommAlertConfig) {
        self.init(frame: .zero)
        self.config = config
        self.setupUI()
    }
}

extension PPCommAlertView {
    private func setupUI() {
        self.style = .whitebg
        self.isTapBackHidden = self.config.isTapBackHidden
        
        self.backgroundColor = PPUIColor.bgNormalBlackAlpha03Color
        if let backColor = self.config.backgroundColor {
            self.backgroundColor = backColor
        }
        var hasImage = false
        var hasTitle = false
        var hasContent = false
        if let img = self.config.image {
            hasImage = true
            topImageView = UIImageView.init(image: img)
        } else {
            topImageView = UIImageView.init(frame: .zero)
        }
        if let t = self.config.title {
            hasTitle = true
            titleLab.text = t

        }
        if let c = self.config.content {
            hasContent = true
            contentLab.text = c
        }

        addSubview(containerView)
        if let topImageView = self.topImageView {
            containerView.addSubview(topImageView)
        }
        
        containerView.addSubview(titleLab)
        containerView.addSubview(contentLab)

        if let cancelAttributeTitle = self.config.cancelAttributeTitle {
            cancelButton.setAttributedTitle(cancelAttributeTitle, for: .normal)
        }
        
        containerView.addSubview(cancelButton)

        if self.config.cancelAttributeTitle?.length ?? 0 > 0 {
            cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        } else {
            cancelButton.isHidden = true
        }
        if self.config.maxWidth == 0 {
            containerView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(27)
                make.trailing.equalToSuperview().offset(-27)
            }
        } else {
            containerView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.width.equalTo(self.config.maxWidth)
                make.centerX.equalToSuperview()
            }
        }

        self.topImageView?.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.config.topSpace)
            make.centerX.equalToSuperview()
        }
        
        self.titleLab.snp.makeConstraints { make in
            if let topImageView = self.topImageView {
                make.top.equalTo(topImageView.snp.bottom).offset(hasImage ? 27 : 0)
            }else {
                make.top.equalToSuperview().offset(self.config.topSpace)
            }
            
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().offset(-27)
        }
        

        contentLab.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(hasTitle ? self.config.contentTopSpace : 0)
            make.leading.trailing.equalTo(titleLab)
        }

        var hasConfirm = false
        if let c = self.config.confirmAttributeTitle, c.length > 0 {
            hasConfirm = true
            confirmButton.setAttributedTitle(c, for: .normal)
            containerView.addSubview(confirmButton)
            confirmButton.addTarget(self, action: #selector(confirmButtonClick), for: .touchUpInside)
        }

        if let configureExtraViewCallBack = self.config.configureExtraView {
            // 有外部配置
            containerView.addSubview(extraContentContainerView)
            let subView = configureExtraViewCallBack(extraContentContainerView)
            extraContentContainerView.addSubview(subView)

            extraContentContainerView.snp.makeConstraints { make in
                if hasContent {
                    make.top.equalTo(contentLab.snp.bottom).offset(16)
                }else {
                    let topOffset: CGFloat = hasTitle ? 16 : 0
                    make.top.equalTo(titleLab.snp.bottom).offset(topOffset)
                }
                
                make.leading.equalToSuperview().offset(27)
                make.trailing.equalToSuperview().offset(-27)
            }

            if hasConfirm {
                let imgView = UIImageView(image: self.btnLightGrayBackImage)
                imgView.tag = PPCommAlertConfig.cancelBtnTag
                cancelButton.addSubview(imgView)
                cancelButton.sendSubview(toBack: imgView)
                imgView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
                cancelButton.snp.makeConstraints { make in
                    make.top.equalTo(extraContentContainerView.snp.bottom).offset(self.config.buttonTopSpace)
                    make.leading.equalToSuperview().offset(27)
                    make.height.equalTo(50)
                    make.bottom.equalToSuperview().offset(-27)
                }

                confirmButton.snp.makeConstraints { make in
                    make.centerY.equalTo(cancelButton)
                    if cancelButton.isHidden {
                        make.leading.equalTo(cancelButton.snp.leading)
                    } else {
                        make.leading.equalTo(cancelButton.snp.trailing).offset(16)
                        make.width.equalTo(cancelButton)
                    }
                    make.height.equalTo(cancelButton)
                    make.trailing.equalToSuperview().offset(-27)
                }
            } else {
                let imgView = UIImageView(image: self.btnGreenBackImage)
                cancelButton.addSubview(imgView)
                cancelButton.sendSubview(toBack: imgView)
                imgView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
                cancelButton.snp.makeConstraints { make in
                    make.top.equalTo(extraContentContainerView.snp.bottom).offset(self.config.buttonTopSpace)
                    make.leading.equalToSuperview().offset(27)
                    make.height.equalTo(50)
                    make.bottom.trailing.equalToSuperview().offset(-27)
                }
            }

        } else {
            if hasConfirm {
                let imgView = UIImageView.init(image: self.btnLightGrayBackImage)
                imgView.tag = PPCommAlertConfig.cancelBtnTag
                cancelButton.addSubview(imgView)
                cancelButton.sendSubview(toBack: imgView)
                imgView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
                cancelButton.snp.makeConstraints { make in
                    make.top.equalTo(contentLab.snp.bottom).offset(hasContent ? self.config.buttonTopSpace : 0)
                    make.leading.equalToSuperview().offset(27)
                    make.height.equalTo(50)
                    make.bottom.equalToSuperview().offset(-27)
                }
                confirmButton.snp.makeConstraints { make in
                    make.centerY.equalTo(cancelButton)
                    if  cancelButton.isHidden {
                        make.leading.equalTo(cancelButton.snp.leading)
                    } else {
                        make.leading.equalTo(cancelButton.snp.trailing).offset(16)
                        make.width.equalTo(cancelButton)
                    }

                    make.height.equalTo(cancelButton)
                    make.trailing.equalToSuperview().offset(-27)
                }
            } else {
                let imgView = UIImageView.init(image: self.btnGreenBackImage)
                cancelButton.addSubview(imgView)
                cancelButton.sendSubview(toBack: imgView)
                imgView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
                cancelButton.snp.makeConstraints { make in
                    make.top.equalTo(contentLab.snp.bottom).offset(hasContent ? self.config.buttonTopSpace : 0)
                    make.leading.trailing.equalTo(titleLab)
                    make.height.equalTo(50)
                    make.bottom.trailing.equalToSuperview().offset(-27)
                }
            }
        }
        if self.config.hasColseBtn {
            self.closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
            self.containerView.addSubview(closeBtn)
            closeBtn.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-10)
                make.top.equalToSuperview().offset(10)
                make.size.equalTo(CGSize(width: 28, height: 28))
            }
        }

        if self.config.isUseSureBtnOnTopAndCancelBtnOnBottom == true {
            self.setCancelBtnStyle2(hasContent: hasContent)
        }

        if let containerSetupUIBlock = self.config.containerSetupUIBlock {
            containerSetupUIBlock(self)
        }
    }
    
    //重新调整布局：确定按钮在上，取消按钮在下的布局
    func setCancelBtnStyle2(hasContent: Bool) {
        self.confirmButton.snp.remakeConstraints { make in
            if self.config.configureExtraView != nil {
                make.top.equalTo(self.extraContentContainerView.snp.bottom).offset(self.config.buttonTopSpace)
            }else {
                make.top.equalTo(contentLab.snp.bottom).offset(hasContent ? self.config.buttonTopSpace : 0)
            }
            make.leading.trailing.equalTo(self.titleLab)
            make.height.equalTo(50)
        }
        for view in self.cancelButton.subviews {// 移除背景图
            if view.tag == PPCommAlertConfig.cancelBtnTag {
                view.removeFromSuperview()
            }
        }
        self.cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)//UIFont.peiPei.aliFontMedium(ofSize: 15)
        self.cancelButton.setTitleColor(PPUIColor.textNormalAlpha055Color, for: .normal)
        self.cancelButton.snp.remakeConstraints { make in
            make.top.equalTo(self.confirmButton.snp.bottom).offset(0)
            make.width.equalTo(self.confirmButton)
            make.height.equalTo(50)
            make.bottom.trailing.equalToSuperview().offset(-27)
        }
    }
}

/// 点击事件
extension PPCommAlertView {
    @objc func cancelButtonClick() {
        self.config.actionCallBack?(self, .cancelBtn, PPCommAlertBtnType.cancelBtn.rawValue)
        self.hiddenAlert()
    }
    
    @objc func confirmButtonClick() {
        self.config.actionCallBack?(self, .sureBtn, PPCommAlertBtnType.sureBtn.rawValue)
        self.hiddenAlert()
    }
    
    @objc func closeBtnClick() {
        self.config.actionCallBack?(self, .closeBtn, PPCommAlertBtnType.closeBtn.rawValue)
        self.hiddenAlert()
    }
    
}
