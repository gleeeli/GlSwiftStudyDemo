//
//  File.swift
//  Pods
//
//  Created by WJK on 2021/8/13.
//

import UIKit
import XHBSwiftKit

// public func SWIFT_RGBCOLOR(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
//    return SWIFT_RGBACOLOR(r, g, b, 1.0)
// }
//
// public func SWIFT_RGBACOLOR(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
//    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
// }

// ui颜色 地址 : https://www.figma.com/file/xAJ9Hw428WYajpoZNVVrNT/%E9%85%8D%E9%85%8D?node-id=2789%3A13214
/// 颜色
open class CMColorStyle: NSObject {

    // P  -> Primary(品牌色)
    // S -> SubColor(辅助色)
    // BG -> Background(背景)
    // T  ->  Text Visability(可见文字)
    // G -> Grey
    // W -> White ,
    // D ->Divider (分割),
    // O->Overlay(遮罩)
    // B -> Black

    // 主题色
//    @objc public static let theme_0 = PPUIColor.themeP0Color
//    @objc public static let theme_1 = UIColor(hexString: "30E8D4")
//    @objc public static let theme_2 = UIColor(hexString: "4FF2E0")
//    @objc public static let theme_3 = UIColor(hexString: "90F3E8")
//    @objc public static let theme_4 = UIColor(hexString: "BAF7F0")
//    @objc public static let theme_5 = UIColor(hexString: "E9FFFC")

    // 文字色
    //@objc public static let text_black_1 = UIColor(hexString: "232821")
//    @objc public static let text_black_2 = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.55)
//    @objc public static let text_black_3 = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.36)
//    @objc public static let text_black_4 = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.17)

//    @objc public static let text_white_1 = UIColor(hexString: "ffffff")
//    @objc public static let text_white_2 = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.9)
//    @objc public static let text_white_3 = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.7)
//    @objc public static let text_white_4 = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.4)

//    @objc public static let text_red = UIColor(hexString: "FF4456")
//    @objc public static let text_red_1 = UIColor(hexString: "FF899D")
//    @objc public  static let text_orange = UIColor(hexString: "FF8F1C")

    // 辅助色
//    @objc public  static let color_1 = UIColor(hexString: "FFBC57")
//    @objc public  static let color_2 = UIColor(hexString: "67A7F1")
//    @objc public  static let color_3 = UIColor(hexString: "FF6881")
//    @objc public  static let color_4 = UIColor(hexString: "FEDA17")

    // 背景色
//    @objc public  static let bg_color_1 = UIColor(hexString: "F4F8F9")
//    @objc public  static let bg_color_2 = UIColor(hexString: "FFFFFF")
//    @objc public  static let bg_color_3 = UIColor(hexString: "000000")
//    @objc public  static let bg_color_4 = UIColor(hexString: "F5F5F5")
//    @objc public  static let bg_color_5 = UIColor(hexString: "1E1F24")
//    @objc public  static let bg_color_6 = UIColor(hexString: "24252B")
//    @objc public  static let bg_color_7 = UIColor(hexString: "F8F8F8")
//    @objc public  static let bg_color_8 = UIColor(hexString: "E5E5E5")
    
    //MARK:---- 不同
//    @objc public  static let bg_color_9 = UIColor(hexString: "C2FFF8")
//    @objc public  static let bg_color_10 = UIColor(hexString: "F0F0F0")
//    @objc public  static let bg_color_11 = UIColor(hexString: "FFEFF2")
    //MARK:---- 不同end
    
//    @objc public  static let bg_color_24 = UIColor(hexString: "0E0E0E")
//    @objc public  static let bg_color_25 = SWIFT_RGBACOLOR(14, 14, 14, 0.8)

    // 边框
//    @objc public  static let border_color_black = UIColor(hexString: "000000")

    // -------------品牌色  P  -> Primary(品牌色)
    /// 品牌色P0
   @objc public  static let P0: UIColor = UIColor(hexString: "1AD0BC")
    /// 品牌色1
//    @objc public  static let P1: UIColor = UIColor(hexString: "30E8D4")
    /// 品牌色2
//    @objc public static let P2: UIColor = SWIFT_RGBACOLOR(79, 242, 224, 1)
    /// 品牌色3   --swift 无
//    @objc public static let P3: UIColor = SWIFT_RGBACOLOR(252, 155, 144, 1)
    /// 品牌色5
//    @objc public static let P5: UIColor = SWIFT_RGBACOLOR(233, 255, 252, 1)
    /// 品牌色6
//    @objc public static let P6: UIColor = SWIFT_RGBACOLOR(254, 215, 211, 1)
    /// 品牌色7
//    @objc public static let P7: UIColor = SWIFT_RGBACOLOR(254, 235, 233, 1)
    // -------------辅助色色 S -> SubColor(辅助色)
    /// 辅助色S1
//    @objc public static let S1: UIColor = SWIFT_RGBACOLOR(255, 188, 87, 1)
    /// 辅助色S2
//    @objc public static let S2: UIColor = SWIFT_RGBACOLOR(103, 167, 241, 1)
    /// 辅助色S3
//    @objc public static let S3: UIColor = SWIFT_RGBACOLOR(255, 104, 129, 1)
    // -------------背景色 BG -> Background(背景)
    /// 背景色BG _白色
//    @objc public static let BG_White: UIColor = SWIFT_RGBACOLOR(255, 255, 255, 1)
    /// 背景色BG _灰色F5  bg_color_4
//    @objc public static let BG_G_F5: UIColor = SWIFT_RGBACOLOR(245, 245, 245, 1)
    /// 背景色BG _黑色 Black bg_color_3
//    @objc public static let BG_Black: UIColor = SWIFT_RGBACOLOR(0, 0, 0, 1)
    // -------------文本颜色 T -> TextVisability(可见文字)
    /// 文本品牌凸显 text_red
//    @objc public static let T_Red: UIColor = UIColor(hexString: "FF4456")

    // --文本黑色系  G -> Grey
    /// 文本强调色_灰色 text_black_1
//    @objc public static let TG_Keynote: UIColor = SWIFT_RGBACOLOR(35, 40, 33, 1)

    /// 文本正常调色_灰色 text_black_2
//    @objc public static let TG_Visble_Grey: UIColor = SWIFT_RGBACOLOR(0, 0, 0, 0.55)

    /// 文本弱化调色_灰色 text_black_3
//    @objc public static let TG_Tips: UIColor = SWIFT_RGBACOLOR(0, 0, 0, 0.36)

    /// 文本可视极值_灰色 text_black_4
//    @objc public static let TG_Disabl: UIColor = SWIFT_RGBACOLOR(0, 0, 0, 0.17)

    // --文本白色系  W -> White
    /// 文本强调色_白色 text_white_1
//    @objc public static let TW_Keynote: UIColor = SWIFT_RGBACOLOR(255, 255, 255, 1)
    /// 文本正常调色_白色 text_white_2
//    @objc public static let TW_Visble: UIColor = SWIFT_RGBACOLOR(255, 255, 255, 0.9)
    /// 文本弱化调色_白色 text_white_3
//    @objc public static let TW_Tips: UIColor = SWIFT_RGBACOLOR(255, 255, 255, 0.7)
    /// 文本可视极值_白色 text_white_4
//    @objc public static let TW_Disabl: UIColor = SWIFT_RGBACOLOR(255, 255, 255, 0.4)

    // --文本链接色
    /// 文本用于链接高亮
//    @objc public static let T_Link: UIColor = UIColor(hexString: "1AD0BC")

    // -------------分割颜色 D ->Divider (分割),
    /// 可视强分G -Grey
//    @objc public static let DG_E5: UIColor = SWIFT_RGBACOLOR(229, 229, 229, 1)
    /// 可视弱分隔 G -Grey
//    @objc public static let DG_F0: UIColor = SWIFT_RGBACOLOR(240, 240, 240, 1)
    /// 不可视分隔G -Grey PPUIColor.bg4LightGrayColor
//    @objc public static let DG_F5: UIColor = SWIFT_RGBACOLOR(245, 245, 245, 1)

    /// 可视强分 W ->White 50->0.5
//    @objc public static let DW_50: UIColor = SWIFT_RGBACOLOR(255, 255, 255, 0.5)
    /// 可视强分  W ->White 20->0.2
//    @objc public static let DW_20: UIColor = SWIFT_RGBACOLOR(255, 255, 255, 0.2)
    /// 可视强分  W ->White 5 -> 0.05
//    @objc public static let DW_5: UIColor = SWIFT_RGBACOLOR(255, 255, 255, 0.05)

    // -------------遮罩颜色 O->Overlay(遮罩)
    /// 后层不可见 O->Overlay(遮罩)  Black 95 -> 0.95
//    @objc public static let OB_95: UIColor = SWIFT_RGBACOLOR(0, 0, 0, 0.95)
    /// 后侧可见.弱 O->Overlay(遮罩)  Black 80 -> 0.8
//    @objc public static let OB_80: UIColor = SWIFT_RGBACOLOR(0, 0, 0, 0.8)
    /// 后层可见.中 O->Overlay(遮罩)  Black 30 -> 0.3 bg_color_8
//    @objc public static let OB_30: UIColor = SWIFT_RGBACOLOR(0, 0, 0, 0.3)
    /// 后层可见.强 O->Overlay(遮罩)  Black 5 -> 0.05
//    @objc public static let OB_5: UIColor = SWIFT_RGBACOLOR(0, 0, 0, 0.05)
    /// 后层不可见  O->Overlay(遮罩) W ->White 95 -> 0.95
//    @objc public static let OW_95: UIColor = SWIFT_RGBACOLOR(255, 255, 255, 0.95)
    /// 后层可见.弱O->Overlay(遮罩)  W ->White 80 -> 0.8
//    @objc public static let OW_80: UIColor = SWIFT_RGBACOLOR(255, 255, 255, 0.80)
    /// 后层可见.中 O->Overlay(遮罩) W ->White 30 -> 0.3
//    @objc public static let OW_30: UIColor = SWIFT_RGBACOLOR(255, 255, 255, 0.30)
    ///  后层可见.强 O->Overlay(遮罩) W ->White 5 -> 0.05
//    @objc public static let OW_5: UIColor = SWIFT_RGBACOLOR(255, 255, 255, 0.05)

    // 颜色
    //bg_color_C1
//   @objc public static let XHBCOLOR_C1  = SWIFT_RGBCOLOR(160, 97, 239)// 主题
//   @objc public static let XHBCOLOR_C2  = SWIFT_RGBCOLOR(129, 27, 255)// 主题
//   @objc public static let XHBCOLOR_C3  = SWIFT_RGBCOLOR(40, 33, 33)
//   @objc public static let XHBCOLOR_C4  = SWIFT_RGBCOLOR(255, 68, 86)  // red
//   @objc public static let XHBCOLOR_C5  = SWIFT_RGBCOLOR(255, 211, 34)  // yellow
//    @objc public static let XHBCOLOR_C6  = SWIFT_RGBCOLOR(0, 106, 254)  // blue

    // 灰
//   @objc public static let XHBCOLOR_G1  = SWIFT_RGBACOLOR(0, 0, 0, 0.80)
//   @objc public static let XHBCOLOR_G2  = SWIFT_RGBACOLOR(0, 0, 0, 0.55)
//   @objc public static let XHBCOLOR_G3  = SWIFT_RGBACOLOR(0, 0, 0, 0.36)
//   @objc public static let XHBCOLOR_G4  = SWIFT_RGBACOLOR(0, 0, 0, 0.17)
//   @objc public static let XHBCOLOR_G5  = SWIFT_RGBCOLOR(234, 234, 234) //EAEAEA
//   @objc public static let XHBCOLOR_G6  = SWIFT_RGBCOLOR(241, 241, 241)
//   @objc public static let XHBCOLOR_G7  = SWIFT_RGBCOLOR(246, 246, 246) //F6F6F6
//   @objc public static let XHBCOLOR_G8  = SWIFT_RGBACOLOR(0, 0, 0, 0.08)
//   @objc public static let XHBCOLOR_G9  = SWIFT_RGBACOLOR(0, 0, 0, 0.05)
//   @objc public static let XHBCOLOR_G10  = SWIFT_RGBACOLOR(0, 0, 0, 0.04)

    // 白
//   @objc public static let XHBCOLOR_W0  = SWIFT_RGBACOLOR(255, 255, 255, 1.0)
//   @objc public static let XHBCOLOR_W1  = SWIFT_RGBACOLOR(255, 255, 255, 0.90)
//   @objc public static let XHBCOLOR_W2  = SWIFT_RGBACOLOR(255, 255, 255, 0.80)
//   @objc public static let XHBCOLOR_W3  = SWIFT_RGBACOLOR(255, 255, 255, 0.70)
//   @objc public static let XHBCOLOR_W4  = SWIFT_RGBACOLOR(255, 255, 255, 0.60)
//   @objc public static let XHBCOLOR_W5  = SWIFT_RGBACOLOR(255, 255, 255, 0.50)
//   @objc public static let XHBCOLOR_W6  = SWIFT_RGBACOLOR(255, 255, 255, 0.40)
//   @objc public static let XHBCOLOR_W7  = SWIFT_RGBACOLOR(255, 255, 255, 0.30)
//   @objc public static let XHBCOLOR_W8  = SWIFT_RGBACOLOR(255, 255, 255, 0.20)
//   @objc public static let XHBCOLOR_W9  = SWIFT_RGBACOLOR(255, 255, 255, 0.10)
//   @objc public static let XHBCOLOR_W10  = SWIFT_RGBACOLOR(255, 255, 255, 0.05)

//   @objc public static let XHBCOLOR_BG  = SWIFT_RGBCOLOR(246, 246, 246)
//   @objc public static let XHBCOLOR_PRESS  = SWIFT_RGBCOLOR(241, 241, 241)

//   @objc public static let XHBCOLOR_L1  = SWIFT_RGBCOLOR(211, 210, 210) // 线条颜色
//   @objc public static let XHBCOLOR_L2  = SWIFT_RGBCOLOR(241, 241, 241) // 线条颜色

    // colorUtil
//   @objc public static let XHBCOLOR_BLACK_1  = SWIFT_RGBCOLOR(88, 89, 87 )
//   @objc public static let XHBCOLOR_BLACK_2  = SWIFT_RGBCOLOR(229, 229, 229)
//   @objc public static let XHBCOLOR_BLACK_3  = SWIFT_RGBCOLOR(56, 60, 60 )
//   @objc public static let XHBCOLOR_BLACK_4  = SWIFT_RGBCOLOR(100, 100, 100)
//   @objc public static let XHBCOLOR_BLACK_5  = SWIFT_RGBCOLOR(115, 115, 115)
//   @objc public static let XHBCOLOR_BLACK_6  = SWIFT_RGBCOLOR(52, 52, 52)
//   @objc public static let XHBCOLOR_BLACK_7  = SWIFT_RGBCOLOR(92, 90, 89)
//   @objc public static let XHBCOLOR_GRAY_1   = SWIFT_RGBCOLOR(163, 163, 162)
//   @objc public static let XHBCOLOR_GRAY_2   = SWIFT_RGBCOLOR(243, 243, 242)
//   @objc public static let XHBCOLOR_GRAY_3   = SWIFT_RGBCOLOR(192, 198, 201)
//   @objc public static let XHBCOLOR_GRAY_4   = SWIFT_RGBCOLOR(229, 228, 230)
//   @objc public static let XHBCOLOR_GRAY_5   = SWIFT_RGBCOLOR(238, 238, 246)
//   @objc public static let XHBCOLOR_GRAY_6   = SWIFT_RGBCOLOR(180, 180, 180)
//   @objc public static let XHBCOLOR_GRAY_7   = SWIFT_RGBCOLOR(141, 141, 141)
//   @objc public static let XHBCOLOR_GRAY_8   = SWIFT_RGBCOLOR(240, 240, 240)
//   @objc public static let XHBCOLOR_GRAY_9   = SWIFT_RGBCOLOR(116, 117, 117)
//   @objc public static let XHBCOLOR_GRAY_10  = SWIFT_RGBCOLOR(211, 212, 213)
//   @objc public static let XHBCOLOR_WHITE_1  = SWIFT_RGBCOLOR(255, 255, 255)
//   @objc public static let XHBCOLOR_BLUE_1   = SWIFT_RGBCOLOR(0, 189, 211)
//   @objc public static let XHBCOLOR_BLUE_2   = SWIFT_RGBCOLOR(0, 121, 254)
//   @objc public static let XHBCOLOR_BLUE_3   = SWIFT_RGBCOLOR(0, 122, 255)
//   @objc public static let XHBCOLOR_PINK_1   = SWIFT_RGBCOLOR(231, 81, 141)
//   @objc public static let XHBCOLOR_RED_1    = SWIFT_RGBCOLOR(250, 70, 70 )
//   @objc public static let XHBCOLOR_RED_2    = SWIFT_RGBCOLOR(255, 87, 81 )
//   @objc public static let XHBCOLOR_YELLOW_3  = SWIFT_RGBCOLOR(252, 192, 0 )
//   @objc public static let XHBCOLOR_ORANGE_1  = SWIFT_RGBCOLOR(255, 156, 70 )
//   @objc public static let XHBCOLOR_ORANGE_2  = SWIFT_RGBCOLOR(255, 192, 0 )
//   @objc public static let XHBCOLOR_GREEN_1  = SWIFT_RGBCOLOR(114, 202, 62 )
//   @objc public static let XHBCOLOR_PURPLE_1  = SWIFT_RGBCOLOR(115, 115, 115)// 主文
//   @objc public static let XHBCOLOR_PURPLE_2  = SWIFT_RGBCOLOR(205, 113, 241)// 紫色2
//   @objc public static let XHBCOLOR_SILVER_1  = SWIFT_RGBCOLOR(234, 237, 247)// 银色1
//   @objc public static let XHBCOLOR_THIN_GRAY_1   = SWIFT_RGBACOLOR(243, 243, 242, 0.5)
//   @objc public static let XHBCOLOR_HIGHTLIGHT1  = SWIFT_RGBACOLOR(0, 0, 0, 0.07)
//   @objc public static let XHBCOLOR_HIGHTLIGHT2  = SWIFT_RGBACOLOR(0, 0, 0, 0.07)

//   @objc public static let XHBCOLOR_GRAY_BG     = SWIFT_RGBCOLOR(234, 234, 234) // view灰色背景
//   @objc public static let XHBCOLOR_NAVBAR_BG   = SWIFT_RGBCOLOR(246, 246, 246) // 顶部导航栏背景底色 二级页面
//   @objc public static let XHBCOLOR_IMAGE_GAY_BG  = SWIFT_RGBCOLOR(241, 241, 241)  // 没图片的默认灰色背景

//   @objc public static let XHBCOLOR_YELLOW_1  = SWIFT_RGBCOLOR(255, 224, 78) // 黄色 主色
//   @objc public static let XHBCOLOR_YELLOW_2  = SWIFT_RGBCOLOR(255, 220, 40) // 黄色 辅助色

//   @objc public static let XHBCOLOR_BROWN_1   = SWIFT_RGBCOLOR(243, 152, 0) // 褐色 主色

    // 文本颜色
//   @objc public static let XHBCOLOR_TEXT_1  = SWIFT_RGBCOLOR(53, 53, 53)  // 主文
//   @objc public static let XHBCOLOR_TEXT_1_UP  = SWIFT_RGBACOLOR(53, 53, 53, 0.5)  // 主文
//   @objc public static let XHBCOLOR_TEXT_2  = SWIFT_RGBCOLOR(115, 115, 115) // 副文
//   @objc public static let XHBCOLOR_TEXT_3  = SWIFT_RGBCOLOR(163, 163, 163) // 提示文案
//   @objc public static let XHBCOLOR_TEXT_4  = SWIFT_RGBCOLOR(210, 211, 212) // 弱化文案
//   @objc public static let XHBCOLOR_TEXT_5  = SWIFT_RGBCOLOR(184, 184, 184) // 弱化文案（空页面提醒）B8B8B8
//   @objc public static let XHBCOLOR_TEXT_RED  = SWIFT_RGBCOLOR(250, 70, 70)  // 价格，备注
//   @objc public static let XHBCOLOR_TEXT_WHITE  = SWIFT_RGBCOLOR(255, 255, 255)  // 纯白色

//   @objc public static let XHBCOLOR_TEXT_88  = SWIFT_RGBCOLOR(88, 88, 88) // 88 文本

//   @objc public static let XHBCOLOR_LINE_1  = SWIFT_RGBCOLOR(241, 241, 241) // 一般分隔
//   @objc public static let XHBCOLOR_LINE_2  = SWIFT_RGBCOLOR(213, 213, 213) // 顶部、底部导航
//   @objc public static let XHBCOLOR_LINE_3  = SWIFT_RGBCOLOR(215, 215, 215) // 特殊情况

//   @objc public static let XHBCOLOR_B     = SWIFT_RGBACOLOR(0, 0, 0, 1) bg_color_3
//   @objc public static let XHBCOLOR_B_80  = SWIFT_RGBACOLOR(0, 0, 0, 0.8)
//   @objc public static let XHBCOLOR_B_60  = SWIFT_RGBACOLOR(0, 0, 0, 0.6)
//   @objc public static let XHBCOLOR_B_55  = SWIFT_RGBACOLOR(0, 0, 0, 0.55)
//   @objc public static let XHBCOLOR_B_50  = SWIFT_RGBACOLOR(0, 0, 0, 0.5)
//   @objc public static let XHBCOLOR_B_40  = SWIFT_RGBACOLOR(0, 0, 0, 0.4)
//   @objc public static let XHBCOLOR_B_20  = SWIFT_RGBACOLOR(0, 0, 0, 0.2)
//   @objc public static let XHBCOLOR_B_10  = SWIFT_RGBACOLOR(0, 0, 0, 0.1)
//   @objc public static let XHBCOLOR_B_4   = SWIFT_RGBACOLOR(0, 0, 0, 0.04)

//   @objc public static let XHBCOLOR_W     = SWIFT_RGBACOLOR(255, 255, 255, 1)
//   @objc public static let XHBCOLOR_W_80  = SWIFT_RGBACOLOR(255, 255, 255, 0.8)
//   @objc public static let XHBCOLOR_W_60  = SWIFT_RGBACOLOR(255, 255, 255, 0.6)
//   @objc public static let XHBCOLOR_W_40  = SWIFT_RGBACOLOR(255, 255, 255, 0.4)
//   @objc public static let XHBCOLOR_W_20  = SWIFT_RGBACOLOR(255, 255, 255, 0.2)

    // 配配社交按钮不可点击-特殊颜色
//   @objc public static let XHBCOLOR_YELLOW_DISABLE  = SWIFT_RGBACOLOR(255, 255, 255, 0.6)

//   @objc public static let XHBCOLOR_S1    = SWIFT_RGBACOLOR(160, 97, 239, 1)
//   @objc public static let XHBCOLOR_S2    = SWIFT_RGBACOLOR(129, 27, 255, 1)
//   @objc public static let XHBCOLOR_S3    = SWIFT_RGBACOLOR(255, 19, 60, 1)

}

// @objc public class CMUIStyle: NSObject {
//
//    /// 白色返回按钮
//    @objc public static func getBackWhiteIcon() -> UIImage {
//        return UIImage.config_imageNamed("back_white_icon")
//    }
//
//    /// 黑色返回按钮
//    @objc public static func getBackBlackIcon() -> UIImage {
//        return UIImage.config_imageNamed("back_black_icon")
//    }
// }

open class CMFontStyle: NSObject {

    // 字体大小扩展
    /// 44
    @objc public static let FONT_T1_OC  = UIFont.FONT_T1
    /// 36
    @objc public static let FONT_T2_OC  =  UIFont.FONT_T2
    /// 24
    @objc public static let FONT_T3_OC  =  UIFont.FONT_T3
    /// 18
    @objc public static let FONT_T4_OC  =  UIFont.FONT_T4
    /// 16
    @objc public static let FONT_T5_OC =  UIFont.FONT_T5
    /// 14
    @objc public static let FONT_T6_OC  =  UIFont.FONT_T6
    /// 12
    @objc public static let FONT_T7_OC  =  UIFont.FONT_T7

    @objc public static let FONT_T7_2_OC  =  UIFont.FONT_T6_2
    /// 10
    @objc public static let FONT_T8_OC  =  UIFont.FONT_T8
    /// 9
    @objc public static let FONT_T9_OC  =  FONT_T9
}

//// 字体大小扩展
///// 44
// let FONT_T1   : CGFloat = 44.0
///// 36
// let FONT_T2   : CGFloat = 36.0
///// 24
// let FONT_T3   : CGFloat = 24.0
///// 18
// let FONT_T4   : CGFloat = 18.0
///// 16
// let FONT_T5   : CGFloat = 16.0
///// 14
// let FONT_T6   : CGFloat = 14.0
///// 12
// let FONT_T7   : CGFloat = 12.0
///// 10
// let FONT_T8   : CGFloat = 10.0
/// 9
let FONT_T9: CGFloat = 9.0
