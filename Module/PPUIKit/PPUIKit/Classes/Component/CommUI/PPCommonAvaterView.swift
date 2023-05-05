//
//  PPCommonAvaterView.swift
//  PPUIKit
//
//  Created by wangbiao on 2022/12/1.
//

import UIKit

@objc public enum CommonAvaterViewType: Int {
    /// 未知类型
    case unknown
    /// 广场
    case square
    /// 消息
    case message
    /// 个人中心
    case personCenter
    /// 通讯录
    case mailList
    /// 详情
    case detail
    /// 评论
    case comment
    /// 回复
    case reply
    /// 剧本
    case screenplay
    /// 剧本small
    case screenplaySmall
    /// 故事广场
    case storySquare
    
    var avaterWidth: CGFloat {
        var w = 0.0
        switch self {
        case .unknown: w = 0.0
        case .square: w = 44.0
        case .message: w = 44.0
        case .personCenter: w = 88.0
        case .mailList: w = 44
        case .detail: w = 44
        case .comment: w =  40
        case .reply: w = 32
        case .screenplay: w = 56
        case .screenplaySmall: w = 40
        default: w = 44
        }
        return w
    }
}

@objc public class PPCommonAvaterView: UIView {
    
    private var viewType: CommonAvaterViewType = .unknown
    
    /// 图像
    private lazy var avaterImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.isHidden = true
        return imageView
    }()
    
    /// 图像边框
    private lazy var decorateImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.isHidden = true
        return imageView
    }()
    
   @objc public required init(viewType: CommonAvaterViewType, frame: CGRect) {
        super.init(frame: frame)
        self.viewType = viewType
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(avaterImageView)
        self.addSubview(decorateImageView)
        let avaterWidth = self.viewType.avaterWidth
        if self.viewType == .personCenter {
            avaterImageView.layer.borderColor = UIColor.white.cgColor
            avaterImageView.layer.borderWidth = 3
        }
        self.avaterImageView.layer.cornerRadius = avaterWidth * 0.5
        self.avaterImageView.layer.masksToBounds = true
        
        avaterImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(avaterWidth)
        }
        
        decorateImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        if self.viewType == .message {
            avaterImageView.clipsToBounds = true
            avaterImageView.contentMode = .scaleAspectFill
            avaterImageView.isUserInteractionEnabled = true
            avaterImageView.layer.borderColor = UIColor.white.cgColor
            avaterImageView.layer.borderWidth = 2
        } else if self.viewType == .screenplay {
            avaterImageView.layer.borderColor = UIColor(hexString: "FFD482").cgColor
            avaterImageView.layer.borderWidth = 2
            avaterImageView.contentMode = .scaleAspectFill
            avaterImageView.isUserInteractionEnabled = true
            avaterImageView.clipsToBounds = true
        }else if self.viewType == .storySquare {
            avaterImageView.layer.borderColor = PPUIColor.themeP1Color.cgColor
            avaterImageView.layer.borderWidth = 2
            avaterImageView.contentMode = .scaleAspectFill
            avaterImageView.isUserInteractionEnabled = true
            avaterImageView.clipsToBounds = true
        }
    }

    @objc public func updateAvater(avaterUrl:String, decorateUrl: String?, defaultImage: UIImage?) {
        let defimg: UIImage = defaultImage ?? UIImage.pp_imageNamed("pp_default_user_avatar")
        self.avaterImageView.hb_setImageURL(avaterUrl, placeholderImage: defimg)
        self.avaterImageView.isHidden = false
        if let url = decorateUrl, !url.isEmpty {
            self.decorateImageView.hb_setImageURL(decorateUrl, placeholderColor: .clear)
            self.decorateImageView.isHidden = false
        } else {
            self.decorateImageView.isHidden = true
        }
    }
    
    @objc public func updateAvaterShowBlur(avaterUrl:String, decorateUrl: String?, defaultImage: UIImage?, showBlur: Bool) {
        
        let defimg: UIImage = defaultImage ?? UIImage.pp_imageNamed("pp_default_user_avatar")
        self.avaterImageView.image = defimg
        self.avaterImageView.isHidden = false
        
        self.avaterImageView.hb_setImageURL(avaterUrl) { [weak self] image, error, type, url in
            guard let self = self else { return }
            
            if let image = image {
                if showBlur {
                    image.boxBlurImage(blur: 6) { tempeImage in
                        self.avaterImageView.image = tempeImage
                    }
                } else {
                    self.avaterImageView.image = image
                }
            }
        }
        
        if let url = decorateUrl, !url.isEmpty {
            self.decorateImageView.hb_setImageURL(decorateUrl, placeholderColor: .clear)
            self.decorateImageView.isHidden = false
        } else {
            self.decorateImageView.isHidden = true
        }
    }
    
    
    
    @objc public func forceAvater(image: UIImage) {
        self.avaterImageView.image = image
        self.avaterImageView.isHidden = false
    }
    
    @objc public func updateAvaterBoardColor(color: UIColor) {
        self.avaterImageView.layer.borderColor = color.cgColor
    }

}


