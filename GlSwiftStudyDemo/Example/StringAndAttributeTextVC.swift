//
//  StringAndAttributeText.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2022/5/29.
//  Copyright © 2022 gleeeli. All rights reserved.
//

import UIKit

class StringAndAttributeTextVC: UIViewController {
    var uploadModuleUUids:[String] = []
    
    var titleLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        
        
        
       let color = getSeriviceColor(colorStr: "#FF7AD479")
        
        let view = UIView(frame: CGRect(x: 10, y: 100, width: 100, height: 50))
        self.view.addSubview(view)
        
        view.backgroundColor = color
        
//        test3()
//        self.uploadModuleUUids.append("test0_789")
//        self.uploadModuleUUids.append("test1_789")
//        self.uploadModuleUUids.append("test1_788")
//        print("\(self.uploadModuleUUids)")
//        print("------")
//        test4(moduleUuid: "test1")
//        print("\(self.uploadModuleUUids)")
        
        testH5()
        
        let str = "t123456789"
        print("test:\(str[NSRange(location: 5, length: 3)])")
        
    }
    
    func testH5() {
        titleLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
        titleLabel.font = UIFont.systemFont(ofSize: 11)
        titleLabel.textColor = .red
        titleLabel.numberOfLines = 0
        self.view.addSubview(titleLabel)
        
        titleLabel.attributedText = NSAttributedString.getH5Attribute(text: "", font: titleLabel.font, color: titleLabel.textColor)
        
    }
    
    func test4(moduleUuid: String) {
        let newarray = self.uploadModuleUUids.filter { elem in
            return elem.contains(moduleUuid)
        }
        self.uploadModuleUUids = newarray
    }
    
    func test3() {
        let nowTime = Date().timeIntervalSince1970
        let enStr = "1 660 318 930"
        let endTime: TimeInterval = TimeInterval(enStr) ?? 0
        let interval: TimeInterval = endTime - nowTime
        print("开始倒计时\(interval)秒")
    }
    
    func stringtest() {
        print("------StringAndAttributeTextVC")
        let allText = "这是测试文本gleeeli的测试day...Hello"
        
        //方案1
        let keyWordRange = allText.range(of: "测试")
        //方案2
        //let keyWordRange = allText.range(of:"测试", options: .backwards)//反向检索
        //方案3
        //let keyWordRange = allText.range(of:"day", options: .caseInsensitive, range:nil , locale:nil)//忽略大小写
        //方案4
        //let set = CharacterSet(charactersIn: "测试")
        //let keyWordRange: Range<String.Index>? = allText.rangeOfCharacter(from: set)
        
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
        
//        regexFindString()
    }
    
    func getSeriviceColor(colorStr: String) -> UIColor? {
        var nowStr = colorStr.replacingOccurrences(of: "#", with: "")
        if nowStr.count == 8 {
            nowStr = String(nowStr.suffix(6))
            return UIColor.init(hexString: "\(nowStr)")
        }else if nowStr.count == 6 {
            return UIColor.init(hexString: nowStr)
        }
        return nil
    }
    
    
    
    //正则方案1
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


public extension UIColor {
    
    /**
     * UIColor的扩展类 将16进制颜色转换为RGB
     * @param hexString 16进制颜色字符串
     */
    convenience init(hexString: String) {
        let scanner:Scanner = Scanner(string:hexString)
        var valueRGB:UInt32 = 0
        if scanner.scanHexInt32(&valueRGB) == false {
            self.init(red: 0,green: 0,blue: 0,alpha: 0)
        }else{
            self.init(
                red:CGFloat((valueRGB & 0xFF0000)>>16)/255.0,
                green:CGFloat((valueRGB & 0x00FF00)>>8)/255.0,
                blue:CGFloat(valueRGB & 0x0000FF)/255.0,
                alpha:CGFloat(1.0)
            )
        }
    }
    
    
}

public extension NSAttributedString {
    class func getH5Attribute(text: String, font: UIFont, color: UIColor?) -> NSMutableAttributedString {
        var text = text
        text = " <div>只需您<span style=\"color: #FB5D5D;\">上传真实</span>的头像并进行<span style=\"color: #FB5D5D;\">人脸扫描</span>，即可获得更多被异性关注和回复的机会，快来试试吧22～</div>"
        if let textData = text.data(using: .unicode) {
            var attributeString: NSMutableAttributedString
            do {
                var exportParams = [NSAttributedString.Key.foregroundColor: UIColor.yellow] as? NSDictionary
                
                attributeString = try NSMutableAttributedString.init(data: textData, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: NSNumber(value: String.Encoding.unicode.rawValue)], documentAttributes: &exportParams)
                return attributeString
            }catch let error {
                print("\(error)")
                return NSMutableAttributedString.init(string: text)
            }
        }
        return NSMutableAttributedString.init(string: text)
        
//        var isHtmlText: Bool = false
//        if text.contains("<em") || text.contains("<span") || text.contains("<div") || text.contains("<br>") || text.contains("<i") || text.contains("<p") || text.contains("<strong") {
//            isHtmlText = true
//        }
//        do {
//            var attributeString: NSMutableAttributedString
//            if isHtmlText {
//                var textAll = text
//                if let color = color {
//
//                    let rgbaSwift = color.rgbaValues
//                    let rv = rgbaSwift.red * 255
//                    let gv = rgbaSwift.green * 255
//                    let bv = rgbaSwift.blue * 255
//                    let av = rgbaSwift.alpha
//
//                    var insertText = ""
//                    if #available(iOS 14.0, *) {
//                        insertText = text
//                    } else {// 低版本加个空格 不然有时候最后一行显示不出来
//                        let space = "<span style=\"font-size:1px;\">&nbsp;</span>"
//                        insertText = "\(text)\(space)"
//                    }
//
//                    textAll = "<div style=\"color:rgba(\(Int(rv)),\(Int(gv)),\(Int(bv)),\(av));font-size:\(font.pointSize)px; line-height: 1;\">\(insertText)</div>"
//                }
//                print("textAll:\(textAll)")
//                if let textData = textAll.data(using: .utf8) {
//                    attributeString = try NSMutableAttributedString.init(data: textData, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
//                } else {
//                    attributeString = NSMutableAttributedString.init(string: text)
//                }
//
//            } else {
//                attributeString = NSMutableAttributedString.init(string: text)
//                let allCount = attributeString.length
//
//                attributeString.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: allCount))
//
//                if let color = color {
//                    attributeString.addAttributes([NSAttributedString.Key.foregroundColor: color], range: NSRange(location: 0, length: allCount))
//                }
//            }
//
//            return attributeString
//        } catch let error {
//            print("\(error)")
//            return NSMutableAttributedString.init(string: text)
//        }
    }
}
