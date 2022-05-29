//
//  StringAndAttributeText.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2022/5/29.
//  Copyright © 2022 gleeeli. All rights reserved.
//

import UIKit

class StringAndAttributeTextVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("------StringAndAttributeTextVC")
        let allText = "这是测试文本gleeeli的测试day...Hello"
        
        
//        let keyWordRange = allText.range(of: "测试")
//        let keyWordRange = allText.range(of:"测试", options: .backwards)//反向检索
//        let keyWordRange = allText.range(of:"day", options: .caseInsensitive, range:nil , locale:nil)//忽略大小写
        let set = CharacterSet(charactersIn: "测试")
        let keyWordRange: Range<String.Index>? = allText.rangeOfCharacter(from: set)
        
        guard let keyWordRange = keyWordRange else {
            print("关键字未找到。。。")
            return
        }
        
        let keyWordStart = keyWordRange.lowerBound
        let keyWordEnd = keyWordRange.upperBound
        
        let keyWordStartIndex = keyWordStart.utf16Offset(in: allText)
        let keyWordEndIndex = keyWordEnd.utf16Offset(in: allText)
        
        print("起始序号：\(keyWordStartIndex)---结束序号：\(keyWordEndIndex)")
        
        let tokeyText = allText[..<keyWordStart]
        
        print("截取关键字之前的字符串:\(tokeyText)")
        
        let fromkeyText = allText[keyWordEnd...]
        print("截取关键字之后的字符串:\(fromkeyText)")
        
        
        let endIndex = allText.endIndex.utf16Offset(in: allText) - 1
        let relEnd = String.Index(utf16Offset: endIndex, in: allText)
        let fromKeyToEndReduceOne = allText[keyWordEnd..<relEnd]
        
        print("关键字到最后少一位的:\(fromKeyToEndReduceOne)")
        
        regexFindString()
    }
    
    
    func regexFindString() {
        let allText = "http://lifusc148387@qq.com.jpg"
        let rangeindex = allText.range(of: "[0-9]{4}", options: .regularExpression, range: allText.startIndex..<allText.endIndex, locale:Locale.current)
        
        
        let findText = allText.substring(with: rangeindex!)
        print("正则查找字符串：\(findText)") //输出；1483
        
        let rangeindex2 = allText.range(of: ".\\w*$", options: .regularExpression, range: allText.startIndex..<allText.endIndex, locale:Locale.current)
        
        let findText2 = allText.substring(with: rangeindex2!)
        print("正则查找文件格式：\(findText2)")
        
        let findText3 = regexGetSub(pattern: ".\\w*$", str: allText)
        print("正则查找文件格式3：\(findText3)")
    }
    
    /**
        正则表达式获取目的值
        - parameter pattern: 一个字符串类型的正则表达式
        - parameter str: 需要比较判断的对象
        - imports: 这里子串的获取先转话为NSString的[以后处理结果含NS的还是可以转换为NS前缀的方便]
        - returns: 返回目的字符串结果值数组(目前将String转换为NSString获得子串方法较为容易)
        - warning: 注意匹配到结果的话就会返回true，没有匹配到结果就会返回false
        */
       func regexGetSub(pattern:String, str:String) -> [String] {
           var subStr = [String]()
           let regex = try! NSRegularExpression(pattern: pattern, options:[NSRegularExpression.Options.caseInsensitive])
           let results = regex.matches(in: str, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, str.count))
           //解析出子串
           for  rst in results {
               let nsStr = str as  NSString  //可以方便通过range获取子串
               subStr.append(nsStr.substring(with: rst.range))
               //str.substring(with: Range<String.Index>) //本应该用这个的，可以无法直接获得参数，必须自己手动获取starIndex 和 endIndex作为区间
           }
           return subStr
       }
}






//extension String {
//
//    //MARK:-返回string的长度
//    var length:Int{
//        get {
//            return self.characters.count;
//        }
//    }
//    //MARK:-截取字符串从开始到 index
//    func substring(to index: Int) -> String {
//        guard let end_Index = validEndIndex(original: index) else {
//            return self;
//        }
//
//        return String(self[startIndex..<end_Index]);
//    }
//    //MARK:-截取字符串从index到结束
//    func substring(from index: Int) -> String {
//        guard let start_index = validStartIndex(original: index)  else {
//            return self
//        }
//        return String(self[start_index..<endIndex])
//    }
//    //MARK:-切割字符串(区间范围 前闭后开)
//    func sliceString(_ range:CountableRange<Int>)->String{
//
//        guard
//            let startIndex = validStartIndex(original: range.lowerBound),
//            let endIndex   = validEndIndex(original: range.upperBound),
//            startIndex <= endIndex
//            else {
//                return ""
//        }
//
//        return String(self[startIndex..<endIndex])
//    }
//     //MARK:-切割字符串(区间范围 前闭后闭)
//    func sliceString(_ range:CountableClosedRange<Int>)->String{
//
//        guard
//            let start_Index = validStartIndex(original: range.lowerBound),
//            let end_Index   = validEndIndex(original: range.upperBound),
//            startIndex <= endIndex
//            else {
//                return ""
//        }
//        if(endIndex.encodedOffset <= end_Index.encodedOffset){
//            return String(self[start_Index..<endIndex])
//        }
//        return String(self[start_Index...end_Index])
//
//    }
//     //MARK:-校验字符串位置 是否合理，并返回String.Index
//    private func validIndex(original: Int) -> String.Index {
//
//        switch original {
//        case ...startIndex.encodedOffset : return startIndex
//        case endIndex.encodedOffset...   : return endIndex
//        default                          : return index(startIndex, offsetBy: original)
//        }
//    }
//  //MARK:-校验是否是合法的起始位置
//    private func validStartIndex(original: Int) -> String.Index? {
//        guard original <= endIndex.encodedOffset else { return nil }
//        return validIndex(original:original)
//    }
//
//    //MARK:-校验是否是合法的结束位置
//    private func validEndIndex(original: Int) -> String.Index? {
//        guard original >= startIndex.encodedOffset else { return nil }
//        return validIndex(original:original)
//    }
//
//}
