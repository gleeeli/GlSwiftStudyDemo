//
//  PPPhotoListUIImageView.swift
//  PPUIKit
//
//  Created by liguanglei on 2023/2/24.
//

import UIKit
import HBPublic

public protocol PPPhotoListUIImageModelProtocol: NSObjectProtocol {
    var bucket: String? {get}
    var img: String? {get}
    var width: Float {get}
    var height: Float {get}
    var ext: String? {get}
    var blurImag: UIImage? {get set}
    func getImageUrl() -> String // 返回拼接好的完成图片链接
}

public class PPPhotoListUIImageView: UIView {

    var imageViews: [UIImageView] = [UIImageView]()
    //底部首位的图片是否切圆角
    public var isLeadingAndTringBottomRadius = false
    public var tapImageBlock: ((_ imageView: UIImageView) -> ())?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        var maxWidth = CM_UIScreenWidth - 32 * 2
        if self.bounds.size.width > 0 {
            maxWidth = self.bounds.size.width
        }
        let space = 8
        let preWidth = Int((maxWidth - 8*3)/4)
        for i in 0...3 {
            let imgView = UIImageView()
            imgView.frame = CGRect(x:preWidth*i + space*i, y: 0, width: preWidth, height: preWidth)
            imgView.tag = 100 + i
            
            imgView.contentMode = .scaleAspectFill
            imgView.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapImageClick))
            imgView.addGestureRecognizer(tapGes)
            
            addSubview(imgView)
            imageViews.append(imgView)
        }
    }
    
    @objc func tapImageClick(tap: UITapGestureRecognizer) {
        if let iamgeView = tap.view as? UIImageView {
            self.tapImageBlock?(iamgeView)
        }
    }
    
    //isUnLocked true:已解锁 false:未解锁
    public func updateImages(_ imgs: [PPPhotoListUIImageModelProtocol], _ isUnLocked: Bool = true) {
        for (index, imageView) in self.imageViews.enumerated() {
            if index < imgs.count {
                let model = imgs[index]
                let url = model.getImageUrl()
//                let url = XHBConfigure.getUrlWithBucket(model.bucket ?? "", withPath: model.img ?? "")
                if !isUnLocked {
                    if let burIamg = model.blurImag {
                        imageView.image = burIamg
                    } else {
                        imageView.hb_setImageURL(url) { imag, error, cacheOptio, url in
                            if let tempImag = imag {
                                tempImag.boxBlurImage(blur: 8) { img in
                                    model.blurImag = img
                                    imageView.image = img
                                }
                            } else {
                                imageView.backgroundColor = .clear
                            }
                        }
                    }
                } else {
                    imageView.hb_setImageURL(url, placeholderColor: .clear)
                }
                imageView.isHidden = false
                
                
                if self.isLeadingAndTringBottomRadius {
                    if index == 0 {
                        var radius = UIView.PPCornerRadii(topLeft: 8, topRight: 0, bottomLeft: 8, bottomRight: 0)
                        
                        if index == imgs.count - 1 {
                            radius = UIView.PPCornerRadii(topLeft: 8, topRight: 8, bottomLeft: 8, bottomRight: 8)
                        }
                        
                        imageView.addCorner(cornerRadii: radius)
                    }else if index == imgs.count - 1 {
                       
                        let radius = UIView.PPCornerRadii(topLeft: 0, topRight: 8, bottomLeft: 0, bottomRight: 8)
                        
                        imageView.addCorner(cornerRadii: radius)
                    }else {
                        imageView.setCornerRadius(0)
                    }
                    
                }
            } else {
                imageView.isHidden = true
            }
        }
        
    }

}
