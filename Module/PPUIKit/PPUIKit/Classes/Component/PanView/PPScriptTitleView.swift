//
//  PPScriptTitleView.swift
//  PlayScriptModule
//
//  Created by wangbiao on 2022/11/10.
//

import UIKit

public class PPScriptTitleView: UIView {

    private lazy var avater: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.pp_imageNamed("script_sence_goto_tip")
        return imageView
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.peiPei.aliFontBold(ofSize: UIFont.FONT_T5_2)
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var loverIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.pp_imageNamed("script_sence_title_love")
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        addSubview(avater)
        addSubview(nickNameLabel)
        addSubview(loverIcon)
        nickNameLabel.snp.makeConstraints { make in
            make.left.greaterThanOrEqualToSuperview().offset(36)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(11)
            make.right.lessThanOrEqualToSuperview().offset(-15)
        }
        avater.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(36)
            make.right.equalTo(nickNameLabel.snp.left)
        }
        loverIcon.snp.makeConstraints { make in
            make.left.equalTo(nickNameLabel.snp.right)
            make.centerY.equalToSuperview()
            make.width.equalTo(15)
            make.height.equalTo(24)
        }
    }
    
   public func updateTitleView(name: String, avaterIcon:String) {
        nickNameLabel.text = name
        let avaterUrl = avaterIcon
       if !avaterIcon.isEmpty {
           avater.hb_setImageURL(avaterUrl)
           avater.isHidden = false
       } else {
           avater.isHidden = true
       }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

