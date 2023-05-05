//
//  PPAutoLayoutButtonsView.swift
//  PPUIKit
//
//  Created by liguanglei on 2023/2/20.
//

import UIKit
import HBPublic
import SwiftyJSON
import YYText

public protocol PPGravitationModelProtocol {
    var name: String {get}
    var iconUrl: String? {get}
    var isAdd: Bool {get}
}

public class PPAutoLayoutButtonsView: UIView {

    public var list: [PPGravitationModelProtocol]? {
        didSet {
            dataUpdate()
        }
    }
    
    var lastBtn: PPAutoLayoutButton? = nil
    
    public var addBlock: (() -> Void)?
    
    private init() {// 禁用
        super.init(frame: CGRect.zero)
    }
    
    required public init(width: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        setUI()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func dataUpdate() {
        guard let list = self.list else {
            return
        }
        self.removeAllSubviews()
        
        let maxWidth = self.bounds.width
        let lineSpace: CGFloat = 8 // 上下间距
        let itemSpace: CGFloat = 8 // 左右间距
        
        self.lastBtn = nil
        for item in list {
            
            let btnHeight: CGFloat = 24
            let font = UIFont.peiPei.aliFont(ofSize: 13)
            let btn = PPAutoLayoutButton()
            if var url = item.iconUrl {
                url = url.urlEncode()
                //print("当前iconUrl:\(item.iconUrl ?? "")")
                btn.imageView.hb_setImageURL(url)
            }
            
            btn.titleLabel.text = item.name
            btn.titleLabel.font = font
            btn.titleLabel.textColor = PPUIColor.themeWhiteColor
            btn.layer.cornerRadius = btnHeight * 0.5
            btn.layer.borderWidth = 0.48
            btn.layer.borderColor = PPUIColor.themeWhiteColor.withAlphaComponent(0.25).cgColor
            self.addSubview(btn)
            
            if item.isAdd {
                btn.titleLabel.textColor = PPUIColor.text4GreenColor
                btn.imageView.image = .pp_imageNamed("pp_grirate_add_icon")
                btn.titleLabel.font = UIFont.peiPei.aliFontBold(ofSize: 13)
                btn.addTarget(self, action: #selector(onAaddAction), for: .touchUpInside)
            }
            
            var frame = CGRect(x: 0, y: 0, width: 71, height: btnHeight)
            
            let attrtribute = NSAttributedString.getNormalAttribute(content: item.name, font: font, textColor: btn.titleLabel.textColor)
            
            let layout = YYTextLayout(containerSize: CGSize(width: maxWidth, height: btnHeight), text: attrtribute)
            frame.size.width = (layout?.textBoundingSize.width ?? 0) + 13 + 16 + 4
            if let lastBtn = lastBtn {
                let startX = lastBtn.frame.maxX + itemSpace
                if startX + frame.size.width > maxWidth {//当前行已经放不下
                    frame.origin.y = lastBtn.frame.maxY + lineSpace
                    
                }else {//当前行放的下
                    frame.origin.x = startX
                    frame.origin.y = lastBtn.origin.y
                }
            }
            btn.frame = frame
            lastBtn = btn
            
        }
        
        if let lastBtn = lastBtn {// 这里做自适应的适配
            let lastFrame = lastBtn.frame
            let tring = maxWidth - lastFrame.maxX
            lastBtn.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(lastFrame.origin.x)
                make.trailing.equalToSuperview().offset(-tring)
                make.top.equalToSuperview().offset(lastFrame.origin.y)
                make.width.equalTo(lastFrame.width)
                make.height.equalTo(lastFrame.height)
                make.bottom.equalToSuperview()
            }
        }
    }
    
    @objc func onAaddAction() {
        self.addBlock?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        
    }
    
    public class func getHeight(list:[PPGravitationModelProtocol], width: CGFloat) -> CGFloat {
        let view = PPAutoLayoutButtonsView(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT)))
        view.list = list
        if let lastBtn = view.lastBtn {
            return lastBtn.frame.maxY
        }
        return 0
    }
}


public class PPAutoLayoutButton: UIControl {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(13)
            make.height.equalTo(13)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        if var imageFrame = self.imageView?.frame {
//            imageFrame.origin.x = 8
//            imageFrame.size.width = 13
//
//            self.imageView?.frame = imageFrame
//        }
//
//
//        if var titleFrame = self.titleLabel?.frame {
//            titleFrame.origin.x = self.imageView?.frame.maxX ?? 0 + 4
//            self.titleLabel?.frame = titleFrame
//        }
//
//    }
}
