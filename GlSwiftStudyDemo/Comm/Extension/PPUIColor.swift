//
//  File.swift
//  PPUIKit
//
//  Created by WJK on 2022/6/21.
//

import Foundation
import UIKit

//PPUIColor.themeP0Color
//PPColor.theme_0

//颜色取名字可参考：https://www.sioe.cn/yingyong/yanse-rgb-16/

//@objc public enum PPThemeStyle: NSInteger {
//    case whiteTheme // 白色主题
//    case blackTheme // 黑色主题
//}

//public extension PeiPeiExtension where Base: UIColor {
//    // 主题色
////    class var theme_0: UIColor {
////        return PPUIColor.themeP0Color
////    }
//}

@objc public class PPUIColor: UIColor {
    //当前主题
//    public static var curTheme: PPThemeStyle = .whiteTheme
    
    public class func color(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return SWIFT_RGBACOLOR(r, g, b, a)
    }
    
    public static func SWIFT_RGBACOLOR(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}


// 主题色 - 范围：从青色到青白色
@objc public extension PPUIColor {
    
    class var themeP0Color: UIColor { // 青色 theme_0
        return UIColor(hexString: "1AD0BC")
    }
    
    class var themeP1Color: UIColor {//青色大概0.9透明度效果 // theme_1
        return UIColor(hexString: "30E8D4")
    }
    
    /**
     01.主色P/2
     */
    class var themeP2Color: UIColor {//青色大概0.8透明度效果 theme_2
        return UIColor(hexString: "4FF2E0")
    }
    class var themeP3Color: UIColor {//青色大概0.5透明度效果 theme_3
        return UIColor(hexString: "90F3E8")
    }
    class var themeP4Color: UIColor {//青色大概0.2透明度效果 theme_4
        return UIColor(hexString: "BAF7F0")
    }
    class var themeP5Color: UIColor {//青色大概0.1透明度效果 theme_5
        return UIColor(hexString: "E9FFFC")
    }
}


// 亮主题
@objc public extension PPUIColor {
    
    class var themeWhiteColor: UIColor {
//        if PPThemeManager.sharedInstance().isDefaultTheme {
//            return PPUIColor.textStressBlackColor
//        }else {
            return .white
//        }
    }
    
    //浅白色
    class var themeLightGreenColor: UIColor {
        return UIColor(hexString: "F4F8F9")
    }
    
    //浅白色
    class var themeLightGreyColor: UIColor {
        return UIColor(hexString: "F5F5F5")
    }
    
    //----------亮主题时的文字颜色(偏黑色)
    
    class var themeKeynoteGreyColor: UIColor {
        return PPUIColor.textStressBlackColor //#232821
    }
    
    class var themeVisbleGreyColor: UIColor {
        return PPUIColor.textNormalBlackAlpha055Color //rgba(0, 0, 0, 0.55)
    }
    
    class var themeTipsGreyColor: UIColor {
        return PPUIColor.textWeakenBlackAlpha036Color //rgba(0, 0, 0, 0.36)
    }
    
    static var themeDisablGreyColor: UIColor {
        return PPUIColor.textPlaceholderAlpha017Color
    }
    
    static var themeBtnTitleBlackColor: UIColor {
        return UIColor(hexString: "090909")
    }
    
    static var themeBtnBgBlackColor: UIColor {
        return UIColor(hexString: "0D0D0D")
    }
    
//    0D0D0D
}

//MARK: 暗主题
@objc public extension PPUIColor {
    class var themeBlackColor: UIColor {
//        if PPThemeManager.sharedInstance().isDefaultTheme {
//            return .white
//        }else {
            return UIColor(hexString: "000000")
//        }
    }
    
    class var themeDark1Color: UIColor {
        return UIColor(hexString: "1E1F24")
    }
    
    class var themeDark2Color: UIColor {
//        if PPThemeManager.sharedInstance().isDefaultTheme {
//            return .white
//        }else {
            return UIColor(hexString: "1B1C25")
//        }
    }
    
    class var themeDark2NormalColor: UIColor {
        return UIColor(hexString: "1B1C25")
    }
    
    // 暗主题文字颜色
    class var themeKeynoteWhiteColor: UIColor {
        return UIColor(hexString: "FFFFFF")
    }
    
    class var themeVisableWhiteColor: UIColor {
        return PPUIColor.textNormalWhiteAlpha09Color //rgba(255, 255, 255, 0.9)
    }
    
    class var themeTipsWhiteColor: UIColor {
        return PPUIColor.textNormalWhiteAlpha07Color //rgba(255, 255, 255, 0.7)
    }
    
    class var themeDisableWhiteColor: UIColor {
        return PPUIColor.textNormalWhiteAlpha04Color //rgba(255, 255, 255, 0.4)
    }
}

//MARK: 文本颜色
@objc public extension PPUIColor {
    
    /**
     04.文字T/Keynote_Grey.强调
     */
    class var textStressBlackColor: UIColor {//text_black_1 TKeynote_Grey TG_Keynote SWIFT_RGBACOLOR(35, 40, 33, 1)
        return UIColor(hexString: "232821")
    }
    
    
    // ------白色系列开始
    class var textNormalWhiteAlpha01Color: UIColor {//text_black_7
        return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.1)
    }
    
    class var textNormalWhiteAlpha02Color: UIColor {//text_white_6
        return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.2)
    }
    
    class var textNormalWhiteAlpha04Color: UIColor {//text_white_4 TDisable_White
        return UIColor.init(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.4)
    }
    
    class var textNormalWhiteAlpha06Color: UIColor {//text_white_5
        return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.6)
    }
    
    class var textNormalWhiteAlpha07Color: UIColor {//TTips_White
        return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.7)
    }
    
    class var textNormalWhiteAlpha08Color: UIColor { //text_white_W2
        return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8) //XHBCOLOR_W2
    }
    
    class var textNormalWhiteAlpha09Color: UIColor {//text_white_2
        return UIColor.init(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.9)
    }
    
    //----------黑色色系列开始
    /**
     04.文字T/Disabl_Grey.可视极值
     */
    class var textVisualBlackAlpha017Color: UIColor {//text_black_4
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.17) //XHBCOLOR_G4  = SWIFT_RGBACOLOR(0, 0, 0, 0.17)
    }
    
    /**
     文字T/Tips_Grey.弱化
     */
    class var textWeakenBlackAlpha036Color: UIColor {
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.36) //XHBCOLOR_G3  = SWIFT_RGBACOLOR(0, 0, 0, 0.36)
    }
    
    static var textPlaceholderAlpha017Color: UIColor {
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.17)
    }
    
    class var textNormalBlackAlpha04Color: UIColor {
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4) //XHBCOLOR_G2  = SWIFT_RGBACOLOR(0, 0, 0, 0.55)
    }
    
    /**
     04.文字T/Visble_Grey.正常
     */
    class var textNormalBlackAlpha055Color: UIColor {
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.55) //XHBCOLOR_G2  = SWIFT_RGBACOLOR(0, 0, 0, 0.55)
    }
    /**
     文字/g1.HighEmphasis强调
     */
    class var textNormalBlackAlpha07Color: UIColor {
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
    }
    
    /**
     文字/g1.HighEmphasis强调
     */
    class var textNormalBlackAlpha08Color: UIColor {// text_black_5
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
    }
    
    // 弱化文案
    class var textB8GrayColor: UIColor {//text_gray_B8
        return UIColor(hexString: "B8B8B8")
    }
    
    class var text0GreyAlpha06Color: UIColor {//text_grey
        return UIColor(hexString: "92999B", alpha: 0.6)
    }

    class var textNormalBlackColor: UIColor {
        return UIColor(hexString: "000000")
    }
    
    class var text0GrayAlpha036Color: UIColor {
        return UIColor.init(white: 0, alpha: 0.36)
    }
    
    class var textNormalAlpha055Color: UIColor {
        return UIColor.init(white: 0, alpha: 0.55)
    }
    
    class var textNormal8BlackColor: UIColor {//text_black_8
        return UIColor(hexString: "12121E")
    }
    
    class var textNormal9BlackColor: UIColor {
        return UIColor(hexString: "0D1622")
    }
    
    /**
     .04.文字T/Keynote_White.强调FFFFFF
     */
    class var textNormalWhiteColor: UIColor {//text_white_1
        return UIColor(hexString: "ffffff")
    }
    
    //    class var TKeynote_White: UIColor {//TKeynote_White
    //        return SWIFT_RGBACOLOR(255, 255, 255, 1)
    //    }
//        class var TTips_White: UIColor {//TTips_White
//            SWIFT_RGBACOLOR(255, 255, 255, 0.7)
//        }
    
    
    
//    class var TDisable_White: UIColor {//TDisable_White
//        SWIFT_RGBACOLOR(255, 255, 255, 0.4)
//    }
//    class var text_white_7: UIColor {//text_white_7
//        return UIColor.init(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.4)
//    }

    class var text0RedColor: UIColor {//text_red
        return UIColor(hexString: "FF4456")
    }
    
    class var textLightRedColor: UIColor {//text_red_1
        return UIColor(hexString: "FF899D")
    }
    
    class var text1RedColor: UIColor {//text_red1
        return UIColor(hexString: "FF6574")
    }
    
    class var text2RedColor: UIColor {//text_red2
        return UIColor(hexString: "FF6C85")
    }
    
    /**
     02.辅色S/2
     */
    class var text2BlueColor: UIColor {//color_2
        return UIColor(hexString: "67A7F1")
    }
    
    class var text0OrangeColor: UIColor {//text_orange
        return UIColor(hexString: "FF8F1C")
    }
    
    /**
     rgba(255, 188, 87, 1)
     */
    class var text1OrangeColor: UIColor {//color_1
        return UIColor(hexString: "FFBC57")
    }

    class var text0GreenColor: UIColor {//text_green
        return UIColor(hexString: "67CE67")
    }
    
    class var text1GreenColor: UIColor {//color_6
        return UIColor(hexString: "30E130")
    }
    
    class var text2GreenColor: UIColor {//color_7
        return .init(hexString: "6DEF6D")
    }
    
    class var text3GreenColor: UIColor {//text_red3
        return UIColor(hexString: "08CD9E")
    }
    
    class var text4GreenColor: UIColor {
        return .init(hexString: "1CC2B0")
    }
    
    class var text5GreenColor: UIColor {
        return .init(hexString: "A7F0E8")
    }
}


//MARK: 线颜色
@objc public extension PPUIColor {
    class var borderLightGreenColor: UIColor {
        return UIColor(hexString: "04A997")
    }
    
    class var borderThemeLightWhiteColor: UIColor {
        return UIColor(hexString: "9E9E9E")
    }
    
    // 边框
    class var borderNormalBlackColor: UIColor {
        return UIColor(hexString: "000000")
    }
    class var borderBlackEEColor: UIColor {
        return UIColor(hexString: "EEEEEE")
    }
    
    class var borderBlack3AColor: UIColor {
        return UIColor(hexString: "3A3B40")
    }
    
    class var border0OrangeColor: UIColor {
        return UIColor(hexString: "FFBC57")
    }
    
    /**
     67A8F1
     */
    class var border5BlueColor: UIColor {//color_5
        return UIColor(hexString: "67A8F1")
    }
    
    class var boder0LightGrayColor: UIColor {//bg_color_10
        return UIColor(hexString: "C4C4C4")
    }
    
    /**
        线颜色
     */
    class var borderF0GrayColor: UIColor {//line_color_F0
        return UIColor(hexString: "F0F0F0")
    }
    
    class var border1CBlackColor: UIColor {//line_color_2
        return UIColor(hexString: "1C2122")
    }

    class var borderP0Alpha05Color: UIColor {
        return UIColor(hexString: "1AD0BC", alpha: 0.5)
    }
    
    class var lineNormalBlackAlpha005Color: UIColor {//OB_5
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.05)
    }
    
    // 青色
    class var lineWeakenCyanAlpha017Color: UIColor {//line_color_F1
        UIColor(hexString: "00FFE3", alpha: 0.17)
        //return UIColor.init(red: 0, green: 255/255, blue: 227/255.0, alpha: 0.17)
    }

    class var lineNormalBlackAlpha012Color: UIColor {//line_color_F2
        return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.12)
    }
    
    class var borderNormalWhiteColor: UIColor {
        return UIColor(hexString: "FFFFFF")
    }
    
    class var borderPurpleBlueColor: UIColor {
        return UIColor(hexString: "202033")
    }
    
    class var borderBlack31Color: UIColor {
        return UIColor(hexString: "31373D")
    }
    
    class var borderGreen1Color: UIColor {
        return UIColor(hexString: "06D2BC")
    }
    
}


@objc public extension PPUIColor {
    class var themeMainBlackColor: UIColor {//黑色背景主题色
        return UIColor(hexString: "17161F")
    }
    
    class var themeBgBlack2Color: UIColor {//黑色背景主题色
        return UIColor(hexString: "48474D")
    }
    
    class var themeBgBlack3Color: UIColor {//黑色背景主题色
        return UIColor(hexString: "181818")
    }
    
    class var themeBgBlack4Color: UIColor {//黑色背景主题色
        return UIColor(hexString: "343239")
    }
    
    class var bg4YellowColor: UIColor {//color_4
        return UIColor(hexString: "FEDA17")
    }
    
    class var bg0YellowColor: UIColor {//bg_color_11
        return UIColor(hexString: "FFE559")
    }
    
    class var bg6GreenColor: UIColor {//color_6
        return UIColor(hexString: "30E130")
    }

    class var bg7GreenColor: UIColor {//color_7
        return .init(hexString: "6DEF6D")
    }
    
    /// 深灰色
    class var bgDarkGrayColor: UIColor {//color_8
        return .init(hexString: "656A71")
    }

    // 背景色
    
    class var bg0RedColor: UIColor {//back_red
        return UIColor(hexString: "FF4153")
    }
    
    class var bg3RedColor: UIColor {//color_3
        return UIColor(hexString: "FF6881")
    }
    
    class var bg1LightGrayColor: UIColor {//bg_color_1
        return UIColor(hexString: "F4F8F9")
    }

    class var bgNormalWhiteColor: UIColor {//bg_color_2
        return UIColor(hexString: "FFFFFF")
    }
    
    class var bgNormalBlackColor: UIColor {//bg_color_3
        return UIColor(hexString: "000000")
    }
    
    /**
     03.背景BG/grey
     */
    class var bg4LightGrayColor: UIColor {//bg_color_4
        return UIColor(hexString: "F5F5F5")
    }
    
    class var bg5BlackColor: UIColor {//bg_color_5
        return UIColor(hexString: "1E1F24")
    }
    class var bg6BlackColor: UIColor {//bg_color_6
        return UIColor(hexString: "24252B")
    }

    class var bg7BlackColor: UIColor {//bg_color_7
        return UIColor(hexString: "F8F8F8")
    }
    /**
     guard let strongSelf = self else{return}
     */
    class var bg9LightGrayColor: UIColor {//bg_color_9
        return UIColor(hexString: "F6F7F8")
    }
    

    class var bg19LightGrayColor: UIColor {//bg_color_19
        return UIColor(hexString: "E8EDEE")
    }
    
    class var bg0LightRedColor: UIColor {//back_white_red
        return SWIFT_RGBACOLOR( 255, 175, 183, 1)
    }
    
    class var bg0EBlackAlpha08Color: UIColor {//bg_color_25
        UIColor(hexString: "0E0E0E", alpha: 0.8)

    }
    
    class var bg0EBlackColor: UIColor {//bg_color_24
        return UIColor(hexString: "0E0E0E")
    }
    
    class var bg_color_FFDB18: UIColor {
        return UIColor(hexString: "FFDB18")
    }
    
    class var bg_color_FFDB18_alpha_06: UIColor {
        return UIColor(hexString: "FFDB18", alpha: 0.6)
    }
    
    class var bgNormalBlackAlpha01Color: UIColor {//bg_color_22
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
    }
    
    class var bgNormalBlackAlpha013Color: UIColor {
        SWIFT_RGBACOLOR(0, 0, 0, 0.13)
    }
    
    class var bgNormalBlackAlpha015Color: UIColor {
        SWIFT_RGBACOLOR(0, 0, 0, 0.15)
    }
    
    class var bgNormalBlackAlpha025Color: UIColor {//bg_color_8 OBlack30
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.25)
    }

    /**
     06.遮罩O/Black0.3
     */
    class var bgNormalBlackAlpha03Color: UIColor {//bg_color_8 OBlack30
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    class var bgNormalBlackAlpha04Color: UIColor {//bg_color_21
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
    }

    class var bgNormalBlackAlpha05Color: UIColor {//bg_color_18
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    class var bgNormalBlackAlpha06Color: UIColor {//black_alpha_6
        SWIFT_RGBACOLOR(0, 0, 0, 0.6)
    }
    
    class var bgNormalBlackAlpha065Color: UIColor {//black_65
        SWIFT_RGBACOLOR(0, 0, 0, 0.65)
    }
    
    class var bgNormalBlackAlpha055Color: UIColor {
        SWIFT_RGBACOLOR(0, 0, 0, 0.55)
    }
    
    /**
     06.遮罩O
     */
    class var bgNormalBlackAlpha075Color: UIColor {//bg_color_15
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
    }
    
    /**
     06.遮罩O/Black0.3
     */
    class var bgNormalBlackAlpha08Color: UIColor {//bg_color_12
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
    }
    
    class var bgNormalBlackAlpha085Color: UIColor {//bg_color_20
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.85)
    }
    
    /**
     06.遮罩O/Black0.3
     */
    class var bgNormalBlackAlpha09Color: UIColor {//bg_color_13
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
    }

    //-----------------白色背景
    class var bgNormalWhiteAlpha005Color: UIColor {//OB_5
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.05)
    }
    /**
     06.遮罩O/bg_color_14
     */
    class var bgNormalWhiteAlpha015Color: UIColor {//bg_color_14
        return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.15)
    }
    
    class var bgNormalWhiteAlpha04Color: UIColor {
        return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.4)
    }
    
    class var bgNormalWhiteAlpha06Color: UIColor {//bg_color_17
        return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.6)
    }
    
    class var bgNormalWhiteAlpha075Color: UIColor {//bg_color_16
        return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.75)
    }
    
    class var bgNormalWhiteAlpha070Color: UIColor {
        return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.70)
    }
    
    class var bgNormalWhiteAlpha025Color: UIColor {
        return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.25)
    }

    class var bgNormalWhiteAlpha09Color: UIColor {//TVisable_White
        return SWIFT_RGBACOLOR(255, 255, 255, 0.9)

    }
    
    class var bg23LightGrayColor: UIColor {//bg_color_23
        return UIColor(hexString: "F7F7F7")
    }
    
    class var bg26BlackColor: UIColor {//bg_color_26
        return UIColor(hexString: "191C27")
    }
    
    class var bg27LightBlueColor: UIColor {//bg_color_27
        return UIColor(hexString: "C2FFF8")
    }
    
    class var bgF0LightGrayColor: UIColor {//bg_color_28
        return UIColor(hexString: "F0F0F0")
    }
    
    class var bgA0BlueColor: UIColor {//bg_color_C1
        return UIColor(hexString: "A061EF") //XHBCOLOR_C1  = SWIFT_RGBCOLOR(160, 97, 239)// 主题
    }
    
    class var bg81BlueColor: UIColor {//bg_color_C2
        return UIColor(hexString: "811BFF") //XHBCOLOR_C2  = SWIFT_RGBCOLOR(129, 27, 255)// 主题
    }
    
    class var bg28BlackColor: UIColor {//bg_color_C3
        return UIColor(hexString: "282121") //XHBCOLOR_C3  = SWIFT_RGBCOLOR(40, 33, 33)
    }
    
    class var bgFFRedColor: UIColor {//bg_color_C4
        return UIColor(hexString: "FF4456") //XHBCOLOR_C4  = SWIFT_RGBCOLOR(255, 68, 86)  // red
    }
    
    class var bg00BlueColor: UIColor {//bg_color_C6
        return UIColor(hexString: "006AFE") //XHBCOLOR_C6  = SWIFT_RGBCOLOR(0, 106, 254)  // blue
    }
    
    class var bgEAGrayColor: UIColor {//bg_color_G5
        return UIColor(hexString: "EAEAEA") //XHBCOLOR_G5  = SWIFT_RGBCOLOR(234, 234, 234)
    }
    
    class var bgF1GrayColor: UIColor {//bg_color_G6
        return UIColor(hexString: "F1F1F1") //XHBCOLOR_G6  = SWIFT_RGBCOLOR(241, 241, 241)
    }
    
    class var bgF6GrayColor: UIColor {//bg_color_G7
        return UIColor(hexString: "F6F6F6") //XHBCOLOR_G7  = SWIFT_RGBCOLOR(246, 246, 246) //F6F6F6
    }

    class var bg2LightRedColor: UIColor {//TVisable_White_2
        return UIColor(hexString: "FFEAEC")
    }

    class var bg7LightGrayColor: UIColor {//black_alpha_7
        return UIColor(hexString: "EEF3F5")
    }

    class var bg1OrangeColor: UIColor {//orange1
        UIColor(hexString: "FFE559")
    }
    
    class var bg1GreenColor: UIColor {//green_new
        return UIColor(hexString: "15FFBA")
    }
    
    class var bg2GreenColor: UIColor {//green_1
        return UIColor(hexString: "15FFBA")
    }
    
    class var bg2OrangeColor: UIColor {//origin_1
        return UIColor(hexString: "FEE960")
    }
    
    class var bgDarkGradient1Color: UIColor {
        return UIColor(hexString: "492D41")
    }
    
    class var bgDarkGradient2Color: UIColor {
        return UIColor(hexString: "242138")
    }
    
    class var bgDarkGradient3Color: UIColor {
        return UIColor(hexString: "2D2D54")
    }
    
    class var bgDarkGradient4Color: UIColor {
        return UIColor(hexString: "2C1E2D")
    }
    
    class var bgDarkGradient5Color: UIColor {
        return UIColor(hexString: "24252B")
    }
    
    class var bgGreenGradient1Color: UIColor {
        return UIColor(hexString: "44E0ED")
    }
    
    class var bgGreenGradient2Color: UIColor {
        return UIColor(hexString: "00E4D7")
    }
    
    class var bgGreenGradient3Color: UIColor {
        return UIColor(hexString: "30E392")
    }
    
    class var bgRedGradient1Color: UIColor {
        return UIColor(hexString: "FE94A6")
    }
    
    class var bgRedGradient2Color: UIColor {
        return UIColor(hexString: "FF6881")
    }
    
    class var bgDark3Gradient1Color: UIColor {
        return UIColor(hexString: "303D45")
    }
    
    class var bgDark4Gradient1Color: UIColor {
        return UIColor(hexString: "2F3040")
    }
    
    class var bgDark1FBackColor: UIColor {
        return UIColor(hexString: "1F2025")
    }
    
    class var bgDark5GradientColor: UIColor {
        return UIColor(hexString: "111118")
    }
    
    class var bglightDark1Color: UIColor {
        return UIColor(hexString: "050505")
    }
    
    class var bgOrange1Color: UIColor {
        return UIColor(hexString: "FDA522")
    }
    
    class var bgRed1Color: UIColor {
        return UIColor(hexString: "FF6A79")
    }
}

@objc public extension PPUIColor {
    // 一些场景颜色
    class var borderGravityColor: UIColor {//origin_1
        return UIColor(hexString: "E5E5E5")
    }
    
    class var maleAgeColor: UIColor {//origin_1
        return UIColor(hexString: "E5E5E5")
    }
}

@objc public extension PPUIColor {
    /// 品牌色
    class var P2Color: UIColor {//P2 青色
        UIColor(hexString: "4FF2E0")
    }

    class var P1Color: UIColor {//P1 深青色
        UIColor(hexString: "30E8D4")
    }
    
    class var P1_alpha_06: UIColor {
        UIColor(hexString: "30E8D4", alpha: 0.6)
    }
    
    class var P3Color: UIColor {//P3 深浅红色
        return UIColor(hexString: "FC9B90")
    }
    
    class var P5Color: UIColor {//P5 浅蓝色
        return UIColor(hexString: "E9FFFC")//SWIFT_RGBACOLOR(233, 255, 252, 1)
    }
    
    class var P6Color: UIColor {//P6 浅蓝色
        return UIColor(hexString: "E9FFFC")//SWIFT_RGBACOLOR(254, 215, 211, 1)
    }
    
    /// 辅助色S1
    class var S1Color: UIColor {//S1 黄色
        return UIColor(hexString: "FFBC57")//SWIFT_RGBACOLOR(255, 188, 87, 1)
    }
    
    class var S2Color: UIColor {//S2蓝色
        return UIColor(hexString: "67A7F1")//SWIFT_RGBACOLOR(103, 167, 241, 1)
    }
    
    class var S3Color: UIColor {//S3红色
        return UIColor(hexString: "FF6881")//SWIFT_RGBACOLOR(255, 104, 129, 1)
    }
}

/// ----------------给故事广场用的
public extension PPUIColor {
    class var themeStoryWhiteColor: UIColor {//themeWhiteColor
        return .white
    }
    
    class var themeStoryBlackColor: UIColor {//themeBlackColor
        return UIColor(hexString: "000000")
    }
    
    class var themeStoryBackColor: UIColor {//themeDark2Color
        return UIColor(hexString: "1B1C25")
    }
}
