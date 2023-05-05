//
//  NSAttributedString+PP.swift
//  PPBaseModule
//
//  Created by liguanglei on 2022/9/7.
//

import Foundation

public extension NSAttributedString {
    class func getH5Attribute(text: String, font: UIFont, color: UIColor?) -> NSMutableAttributedString {
        var isHtmlText: Bool = false
        if text.contains("<em") || text.contains("<span") || text.contains("<div") || text.contains("<br>") || text.contains("<i") || text.contains("<p") || text.contains("<strong") {
            isHtmlText = true
        }
        do {
            var attributeString: NSMutableAttributedString
            if isHtmlText {
                var textAll = text
                if let color = color {

                    let rgbaSwift = color.rgbaValues
                    let rv = rgbaSwift.red * 255
                    let gv = rgbaSwift.green * 255
                    let bv = rgbaSwift.blue * 255
                    let av = rgbaSwift.alpha

                    var insertText = ""
                    if #available(iOS 14.0, *) {
                        insertText = text
                    } else {// 低版本加个空格 不然有时候最后一行显示不出来
                        let space = "<span style=\"font-size:1px;\">&nbsp;</span>"
                        insertText = "\(text)\(space)"
                    }

                    textAll = "<div style=\"color:rgba(\(Int(rv)),\(Int(gv)),\(Int(bv)),\(av));font-size:\(font.pointSize)px; line-height: 1;\">\(insertText)</div>"
                }
                print("textAll:\(textAll)")
                if let textData = textAll.data(using: .utf8) {
                    attributeString = try NSMutableAttributedString.init(data: textData, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
                } else {
                    attributeString = NSMutableAttributedString.init(string: text)
                }

            } else {
                attributeString = NSMutableAttributedString.init(string: text)
                let allCount = attributeString.length

                attributeString.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: allCount))

                if let color = color {
                    attributeString.addAttributes([NSAttributedString.Key.foregroundColor: color], range: NSRange(location: 0, length: allCount))
                }
            }
            /*
            let nowVersion = String.getAppVersion()
            if nowVersion >= 13.0 && nowVersion < 15.0 {
                let allCount = attributeString.length
                let paragrp = NSMutableParagraphStyle()
                paragrp.minimumLineHeight = 20
    
                attributeString.addAttributes([NSAttributedString.Key.paragraphStyle: paragrp], range: NSMakeRange(0, allCount))
            }*/

            return attributeString
        } catch let error {
            print("\(error)")
            return NSMutableAttributedString.init(string: text)
        }
    }
}

extension UIColor {
    var rgbaValues: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    return (red, green, blue, alpha)
    }
}
