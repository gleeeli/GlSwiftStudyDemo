//
//  NSAttribute+PPUIKit.swift
//  PPUIKit
//
//  Created by liguanglei on 2022/10/24.
//

import UIKit
import YYText

public extension NSAttributedString {
    /// 普通常用关键字富文本
    @objc class func getCommKeyWordAttribute(allContent: String, keyWord: String?, allFont: UIFont, keyFont: UIFont?, allColor: UIColor?, keyColor: UIColor?) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: allContent)
        
        let allR = NSRange(location: 0, length: attributedString.length)
        
        
        attributedString.addAttributes([NSAttributedString.Key.font: allFont], range: allR)
        if let allColor = allColor {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: allColor], range: allR)
        }
        
        if let keyWord = keyWord {
            let keyWordRange = allContent.range(of: keyWord)
            
            if  let keyWordRange = keyWordRange {
                let keyWordStart = keyWordRange.lowerBound
                let keyWordStartIndex = keyWordStart.utf16Offset(in: allContent)
                let keyWordRangeOC = NSMakeRange(keyWordStartIndex, keyWord.count)
                
                if let keyFont = keyFont {
                    attributedString.addAttributes([NSAttributedString.Key.foregroundColor: keyFont], range: keyWordRangeOC)
                }
                
                if let keyColor = keyColor {
                    attributedString.addAttributes([NSAttributedString.Key.foregroundColor: keyColor], range: keyWordRangeOC)
                }
                
            }
        }
        
        
        return attributedString
    }
    
    /// 第一张是图片的富文本
    @objc class func getCommFirstImageAttribute(image: UIImage?, title: String, font: UIFont, color: UIColor?, imageHeight: CGFloat) -> NSMutableAttributedString {
        
        return NSAttributedString.getCommFirstImageAttribute(image: image, title: title, font: font, color: color, imageMaxWidth: nil, imageHeight: imageHeight)
    }
    
    /// 第一张是图片的富文本
    class func getCommFirstImageAttribute(image: UIImage?, title: String, font: UIFont, color: UIColor?, imageMaxWidth: CGFloat?, imageHeight: CGFloat) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: " \(title)")

        //let paragrp = NSMutableParagraphStyle()
        
        if let image = image {
            self.insertImage(attribute: attributedString, image: image, imageMaxWidth: imageMaxWidth, imageHeight: imageHeight, font: font, location: 0)
        }
        
        let allR = NSRange(location: 0, length: attributedString.length)
        
        attributedString.addAttributes([NSAttributedString.Key.font: font], range: allR)
        if let color = color {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: color], range: allR)
        }
        
        
        return attributedString
    }
    
    @objc class func insertImage(attribute: NSMutableAttributedString, image: UIImage, imageHeight: CGFloat, font: UIFont, location: Int) {
        NSAttributedString.insertImage(attribute: attribute, image: image, imageMaxWidth: nil, imageHeight: imageHeight, font: font, location: location)
    }
    
    class func insertImage(attribute: NSMutableAttributedString, image: UIImage, imageMaxWidth: CGFloat?, imageHeight: CGFloat, font: UIFont, location: Int) {
        let imageWidht: CGFloat = getInsertImageWidth(image: image, imageMaxWidth: imageMaxWidth, imageHeight: imageHeight)
        let paddingTop: CGFloat = (font.capHeight - imageHeight)/2.0
        
        let attachimage = NSTextAttachment()
        attachimage.image = image
        attachimage.bounds  = CGRect(x: 0, y: paddingTop, width: imageWidht, height: imageHeight)
        let stringImage = NSAttributedString.init(attachment: attachimage)
        attribute.insert(stringImage, at: location)
    }
    
    class func getInsertImageWidth( image: UIImage, imageMaxWidth: CGFloat?, imageHeight: CGFloat) -> CGFloat {
        let imageHeight: CGFloat = imageHeight
        // 有图片必须设置行高 否则不换行
        //paragrp.maximumLineHeight = imageHeight
        //paragrp.minimumLineHeight = imageHeight

        let scale: CGFloat = imageHeight / image.size.height
        
        var imageWidht: CGFloat = scale * image.size.width
        if let imageMaxWidth = imageMaxWidth, imageWidht > imageMaxWidth {
            imageWidht = imageMaxWidth
        }
        return imageWidht
    }
    
    static func getNormalAttribute(content: String, font: UIFont, textColor: UIColor?) -> NSMutableAttributedString {
        let allText = content

        let attributedString = NSMutableAttributedString.init(string: allText)

        let allR = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: textColor ?? PPUIColor.textStressBlackColor], range: allR)
        attributedString.addAttributes([NSAttributedString.Key.font: font], range: allR)

        return attributedString
    }
    
    /// 插入段落行高
    static func insertParagraphStyle(muAttribut: NSMutableAttributedString, lineHeight: CGFloat) {
        let paragrp = NSMutableParagraphStyle()
        paragrp.maximumLineHeight = lineHeight
        paragrp.minimumLineHeight = lineHeight
        muAttribut.addAttributes([NSAttributedString.Key.paragraphStyle: paragrp], range: NSRange(location: 0, length: muAttribut.length))
    }
    
    /// 获取自适应字体大小
    static func getAdjustFont(maxWidth: CGFloat, muattribute: NSMutableAttributedString, maxLines: Int, fontSize: CGFloat ) -> CGFloat {
        var muattribute = muattribute
        muattribute.addAttributes([NSAttributedString.Key.font: UIFont.peiPei.aliFont(ofSize: fontSize)], range: NSRange(location: 0, length: muattribute.length))
        
        let layout = YYTextLayout.init(containerSize: CGSize(width: maxWidth, height: 10000), text: muattribute)
        if (layout?.lines.count ?? 0) > maxLines {
            return getAdjustFont(maxWidth: maxWidth, muattribute: muattribute, maxLines: maxLines, fontSize: fontSize - 1)
        }
        return fontSize
    }
}
