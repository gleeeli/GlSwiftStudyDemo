//
//  String+BoundingRect.swift
//  SwiftDevelopFramework
//
//  Created by gleeeli on 2020/3/29.
//  Copyright © 2020 GL. All rights reserved.
//

import Foundation
import UIKit

extension String {

    /// 给定最大宽计算高度，传入字体、行距、对齐方式（便捷调用）
    func heightForLabel(width: CGFloat, font: UIFont, lineSpacing: CGFloat = 5, alignment: NSTextAlignment = .left) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        let attributes: [NSAttributedString.Key : Any] = [
            kCTFontAttributeName as NSAttributedString.Key: font,
            kCTParagraphStyleAttributeName as NSAttributedString.Key: paragraphStyle
        ]
        let textSize = textSizeForLabel(width: width, height: CGFloat(Float.greatestFiniteMagnitude), attributes: attributes)
        return textSize.height
    }
    
    /// 给定最大宽计算高度，传入属性字典（便捷调用）
    func heightForLabel(width: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGFloat {
        let textSize = textSizeForLabel(width: width, height: CGFloat(Float.greatestFiniteMagnitude), attributes: attributes)
        return textSize.height
    }
    
    /// 给定最大高计算宽度，传入字体（便捷调用）
    func widthForLabel(height: CGFloat, font: UIFont) -> CGFloat {
        let labelTextAttributes = [kCTFontAttributeName as NSAttributedString.Key: font]
        let textSize = textSizeForLabel(width: CGFloat(Float.greatestFiniteMagnitude), height: height, attributes: labelTextAttributes)
        return textSize.width
    }
    
    /// 给定最大高计算宽度，传入属性字典（便捷调用）
    func widthForLabel(height: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGFloat {
        let textSize = textSizeForLabel(width: CGFloat(Float.greatestFiniteMagnitude), height: height, attributes: attributes)
        return textSize.width
    }
    
    /// 给定最大宽高计算宽度和高度，传入字体、行距、对齐方式（便捷调用）
    func textSizeForLabel(width: CGFloat, height: CGFloat, font: UIFont, lineSpacing: CGFloat = 5, alignment: NSTextAlignment = .left) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        let attributes: [NSAttributedString.Key : Any] = [
            kCTFontAttributeName as NSAttributedString.Key : font,
            kCTParagraphStyleAttributeName as NSAttributedString.Key : paragraphStyle
        ]
        let textSize = textSizeForLabel(width: width, height: height, attributes: attributes)
        return textSize
    }
    
    /// 给定最大宽高计算宽度和高度，传入属性字典（便捷调用）
    func textSizeForLabel(size: CGSize, attributes: [NSAttributedString.Key: Any]) -> CGSize {
        let textSize = textSizeForLabel(width: size.width, height: size.height, attributes: attributes)
        return textSize
    }
    
    /// 给定最大宽高计算宽度和高度，传入属性字典（核心)
    func textSizeForLabel(width: CGFloat, height: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGSize {
        let defaultOptions: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let maxSize = CGSize(width: width, height: height)
        let rect = self.boundingRect(with: maxSize, options: defaultOptions, attributes: attributes, context: nil)
        let textWidth: CGFloat = CGFloat(Int(rect.width) + 1)
        let textHeight: CGFloat = CGFloat(Int(rect.height) + 1)
        return CGSize(width: textWidth, height: textHeight)
    }
}

extension NSAttributedString {
    
    /// 根据最大宽计算高度（便捷调用)
    func heightForLabel(width: CGFloat) -> CGFloat {
        let textSize = textSizeForLabel(width: width, height: CGFloat(Float.greatestFiniteMagnitude))
        return textSize.height
    }
    
    /// 根据最大高计算宽度（便捷调用)
    func widthForLabel(height: CGFloat) -> CGFloat {
        let textSize = textSizeForLabel(width: CGFloat(Float.greatestFiniteMagnitude), height: height)
        return textSize.width
    }
    
    /// 计算宽度和高度（核心)
    func textSizeForLabel(width: CGFloat, height: CGFloat) -> CGSize {
        let defaultOptions: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let maxSize = CGSize(width: width, height: height)
        let rect = self.boundingRect(with: maxSize, options: defaultOptions, context: nil)
        let textWidth: CGFloat = CGFloat(Int(rect.width) + 1)
        let textHeight: CGFloat = CGFloat(Int(rect.height) + 1)
        return CGSize(width: textWidth, height: textHeight)
    }
}
