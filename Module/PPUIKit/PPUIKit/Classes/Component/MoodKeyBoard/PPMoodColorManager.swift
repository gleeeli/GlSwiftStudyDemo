//
//  MoodColorManager.swift
//  MessageCenterModule
//
//  Created by WJK on 2022/4/2.
//

import UIKit
// import ConfigModule
import XHBSwiftKit

public class PPMoodColorManager: NSObject {
     /// 表情
    public static func getRealEmojiName(_ emojiName: String, formName: String, directionIsMy: Bool) -> String {
        var suffix = "_l"
        if directionIsMy {
             suffix = "_r"
        }

            return emojiName + suffix

    }
    // 形状
    public static func getRealFormName(_ emojiName: String, formName: String, directionIsMy: Bool) -> String {
        var suffix = "_l"
        if directionIsMy {
             suffix = "_r"
        }
        switch emojiName {
        case "mood_bg_black":
            return formName + suffix + "_b"
        default:
            return formName + suffix
        }
    }

     // 形状
    public  static func getRealBackGroundImageName(_ emojiName: String, directionIsMy: Bool) -> String {
         var suffix = "_l"
         if directionIsMy {
              suffix = "_r"
         }
             return emojiName + suffix

     }

    // 文字颜色
    public  static func getTextColor(_ emojiName: String) -> UIColor {
        if emojiName == "mood_bg_black" {
            return  SWIFT_RGBACOLOR(0, 255, 198, 1)
        }
        return  PPUIColor.textStressBlackColor
    }

     /// 默认颜色
    public  static var colorKeyArray: [[String: String]] = {
         let array = [
             ["key": "mood_bg_yellow", "color": "FEDA17"],
             ["key": "mood_bg_black", "color": "333333"],
             ["key": "mood_bg_green", "color": "8DF47F"],
             ["key": "mood_bg_blue", "color": "8BC9F6"],
             ["key": "mood_bg_orange", "color": "FF9E68"]
         ]
         return array
     }()

    /// 获取cell 的 图片
    public static func getMoodeBackImage(name: String) -> UIImage {
        UIImage.pp_imageNamed(name)
    }
}
