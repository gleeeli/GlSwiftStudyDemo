//
//  PPExpandContentTextView.swift
//  AdModule
//
//  Created by liguanglei on 2023/2/19.
//

import UIKit
import YYText
import YYImage

//有收起展开按钮的文本
public class PPExpandContentTextView: UIView {
    public var text = "" {
        didSet {
            contentChange()
        }
    }
    
    // 设置这个，上面的设置text就会无效
    public var attributedText: NSAttributedString? = nil {
        didSet {
            contentChange()
        }
    }
    
    public var font: UIFont = UIFont.peiPei.aliFont(ofSize: 15) {
        didSet {
            self.textLabel.font = font
        }
    }
    
    public var textColor: UIColor? = PPUIColor.themeWhiteColor.withAlphaComponent(0.9) {
        didSet {
            self.textLabel.textColor = textColor
            self.updateMoreAttribute()
        }
    }
    
    // 是否展开
    public var isExpand = false {
        didSet {
            if oldValue != isExpand {
                contentChange()
            }
        }
    }
    
    public var minNumberOfLines: UInt = 1 {// 最小行数,isExpand = true自动设置0
        didSet {
            if oldValue != minNumberOfLines {
                self.textLabel.numberOfLines = self.minNumberOfLines
//                if isExpand == false {
//                    contentChange()
//                }
            }
        }
    }
    // 展开图片
    public var moreImage: UIImage? = nil {
        didSet {
            updateMoreAttribute()
        }
    }
    // 收起图片
    public var packupImage: UIImage? = nil
    
    public var showMoreOrPackupBlock: ((_ isShowAll: Bool)->())?
    
    private let textLabel = YYLabel()
    
    private var moreAttribute: NSMutableAttributedString = NSMutableAttributedString()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    func setUI() {
        self.textLabel.frame = self.bounds
        self.textLabel.font = UIFont.peiPei.aliFontRegular(ofSize: 15)
        self.textLabel.textColor = PPUIColor.themeWhiteColor.withAlphaComponent(0.9)
        self.addSubview(self.textLabel)
        self.textLabel.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        self.setDefaultMore()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// isExpand: 是否展开
    /// font： 设置更多按钮时文字大小也会用到
    public class func getContentHeight(attributedText: NSAttributedString, width: CGFloat, font: UIFont, minNumberOfLines: UInt, isExpand: Bool) -> CGFloat {
        let frame = CGRect(x: 0, y: 0, width: width, height: 100000)
        let label = PPExpandContentTextView(frame: frame)
        label.textLabel.font = font
        label.isExpand = isExpand
        label.minNumberOfLines = minNumberOfLines
        
        label.attributedText = attributedText
        
        let height = label.textLabel.textLayout?.textBoundingSize.height ?? 0
        print("计算高度：\(height),lines:\(minNumberOfLines)")
        
        return height
    }
    
    /// isExpand: 是否展开
    public class func getContentHeight(content: String, width: CGFloat, font: UIFont, minNumberOfLines: UInt, isExpand: Bool) -> CGFloat {
        let frame = CGRect(x: 0, y: 0, width: width, height: 100000)
        let label = PPExpandContentTextView(frame: frame)
        label.textLabel.font = font
        label.isExpand = isExpand
        label.minNumberOfLines = minNumberOfLines

        label.text = content

        let height = label.textLabel.textLayout?.textBoundingSize.height ?? 0
        print("计算高度：\(height),lines:\(minNumberOfLines)")
        
        //上面计算高度有时候不准，用下面的
        let nowLines: UInt = isExpand ? 0:minNumberOfLines
        let textContainer = YYTextContainer(size: frame.size)
        textContainer.maximumNumberOfRows = nowLines// nowLines
        textContainer.truncationType = .end
        textContainer.truncationToken = label.getNowTruncationToken()
        if isExpand {
           // getContentHeight
        }
        if let contAttr = label.getNowContentAttribute() {
            let textLayout = YYTextLayout(container: textContainer, text: contAttr)
            let height = textLayout?.textBoundingSize.height ?? 0
            
            print("第三计算高度：\(height),lines:\(nowLines), isExpand:\(isExpand),thred:\(Thread.current)")
            return height
        }
        
        
        return 0
    }
    
    public func getHeight() -> CGFloat {
        let height = self.textLabel.textLayout?.textBoundingSize.height ?? 0
        return height
    }
}

extension PPExpandContentTextView {
    public func updateMoreAttribute() {
        if let moreImge = self.moreImage {
            let attribute = NSAttributedString.getNormalAttribute(content: "...    ", font: font, textColor: self.textColor)
            let moreYYimg = YYAnimatedImageView(image: moreImge)
            let attachText = NSMutableAttributedString.yy_attachmentString(withContent: moreYYimg, contentMode: .scaleAspectFit, attachmentSize: moreYYimg.bounds.size, alignTo: font, alignment: .center)
            attribute.append(attachText)
            
            self.moreAttribute = attribute
            
            self.updateMoreLabelTruncationToken()
        }else {
            setDefaultMore()
        }
        
    }
    
    func setDefaultMore() {
        let keyStr = "展开"
        let allText = "...  \(keyStr)"
        let muattribute = NSAttributedString.getNormalAttribute(content: allText, font: self.font, textColor: self.textColor)
        let keyWordRange = allText.range(of: keyStr)
        guard let keyWordRange = keyWordRange else {
            print("关键字未找到。。。")
            return
        }
        let keyWordStart = keyWordRange.lowerBound
        let keyWordStartIndex = keyWordStart.utf16Offset(in: allText)
        let keyWordRangeOC = NSMakeRange(keyWordStartIndex, keyStr.count)
        muattribute.addAttributes([NSAttributedString.Key.foregroundColor: PPUIColor.themeP0Color], range: keyWordRangeOC)
        
        self.moreAttribute = muattribute
        
        
        self.updateMoreLabelTruncationToken()
    }
    
    func appendPackUpAttribute(contentAttr: NSMutableAttributedString) {
        if let packupImage = self.packupImage {
            let attribute = NSAttributedString.getNormalAttribute(content: "    ", font: font, textColor: self.textColor)
            let packupYYimg = YYAnimatedImageView(image: packupImage)
            let attachText = NSMutableAttributedString.yy_attachmentString(withContent: packupYYimg, contentMode: .scaleAspectFit, attachmentSize: packupYYimg.bounds.size, alignTo: font, alignment: .center)
            attribute.append(attachText)
            addPackupAction(muattribute: attribute, range: NSRange(location: 0, length: attribute.length))
            contentAttr.append(attribute)
           
        }else {
            let attribute = NSAttributedString.getNormalAttribute(content: "    收起", font: font, textColor: PPUIColor.themeP0Color)
            addPackupAction(muattribute: attribute, range: NSRange(location: 0, length: attribute.length))
            contentAttr.append(attribute)
        }
    }
    
    func addPackupAction(muattribute: NSMutableAttributedString, range: NSRange) {
        let moreHighlight = YYTextHighlight()
        moreHighlight.tapAction = {[weak self] containerView, text, range, rect in
            print("点击收起")
            self?.showMoreOrPackupBlock?(false)
        }
        
        muattribute.yy_setTextHighlight(moreHighlight, range: range)
    }
}


extension PPExpandContentTextView {
    func contentChange() {
        var muAttribute: NSMutableAttributedString
        if let attributedText = self.attributedText {
            muAttribute = NSMutableAttributedString(attributedString: attributedText)
        }else {
            muAttribute = NSAttributedString.getNormalAttribute(content: self.text, font: self.font, textColor: self.textColor)
        }
        
        self.textLabel.attributedText = muAttribute
        if self.isExpand {//当前全展开
            self.textLabel.numberOfLines = 0
            self.appendPackUpAttribute(contentAttr: muAttribute)
            self.textLabel.attributedText = muAttribute
        }else {
            self.textLabel.numberOfLines = self.minNumberOfLines
        }
    }
    
    func updateMoreLabelTruncationToken() {
        let truncationToken = self.attributeAddAction(muattribute: self.moreAttribute)
        self.textLabel.truncationToken = truncationToken
    }
    
    public func getNowTruncationToken() -> NSAttributedString {
        let truncationToken = self.attributeAddAction(muattribute: self.moreAttribute)
        return truncationToken
    }
    
    public func getNowContentAttribute() -> NSAttributedString? {
        return self.textLabel.attributedText
    }
    
    /// 添加点击事件
    func attributeAddAction(muattribute: NSMutableAttributedString) -> NSMutableAttributedString {
        let moreHighlight = YYTextHighlight()
        moreHighlight.tapAction = {[weak self] containerView, text, range, rect in
            print("点击展开")
            self?.showMoreOrPackupBlock?(true)
        }
        
        muattribute.yy_setTextHighlight(moreHighlight, range: NSRange(location: 0, length: muattribute.length))
        
        muattribute.yy_font = self.font
        
        let moreLabel = YYLabel()
        moreLabel.attributedText = muattribute
        moreLabel.sizeToFit()
        
        if let yyFont = muattribute.yy_font {
            let attachmentSize = moreLabel.bounds.size
            let truncationToken = NSAttributedString.yy_attachmentString(withContent: moreLabel, contentMode: UIView.ContentMode.center, attachmentSize: attachmentSize, alignTo: yyFont, alignment: .top)

            return truncationToken
        }
        
        return muattribute
    }
    
}
