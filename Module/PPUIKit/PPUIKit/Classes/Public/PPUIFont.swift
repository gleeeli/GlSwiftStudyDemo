//
//  PPUIFont.swift
//  PPUIKit
//
//  Created by WJK on 2022/6/21.
//

import Foundation
import PPBaseModule

public extension PeiPeiExtension where Base: UIFont {

    static func font(ofSize fontSize: CGFloat) -> UIFont {
        return .peiPei.aliFont(ofSize: fontSize)
    }

    static func fontRegular(ofSize fontSize: CGFloat) -> UIFont {
        return .peiPei.aliFontRegular(ofSize: fontSize)
    }

    static func fontBold(ofSize fontSize: CGFloat) -> UIFont {
        return .peiPei.aliFontBold(ofSize: fontSize)
    }

    static func fontMedium(ofSize fontSize: CGFloat) -> UIFont {
        return .peiPei.aliFontMedium(ofSize: fontSize)
    }

    static func font(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: weight)
    }

    static func changeFont() {
        PPFontDownloadManager.share().useDownLoadFont = true
    }
}

@objcMembers public class UIFont_oc: NSObject {
    public static func oc_aliFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.peiPei.aliFont(ofSize: fontSize)
    }

    public  static func oc_aliFontBold(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.peiPei.aliFontBold(ofSize: fontSize)
    }

    public static func oc_aliFontMedium(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.peiPei.aliFontMedium(ofSize: fontSize)
    }

    public  static func oc_aliFontRegular(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.peiPei.aliFontRegular(ofSize: fontSize)
    }

    public  static func oc_changeFont() {
        UIFont.peiPei.changeFont()
    }
}

public extension PeiPeiExtension where Base: UIFont {
    static func aliFont(ofSize fontSize: CGFloat) -> UIFont {
        if   PPFontDownloadManager.canUseDownLoadFont() {
            return UIFont(name: PPFontDownloadManager.share().getRegularFontName(), size: fontSize) ??   .systemFont(ofSize: fontSize, weight: .regular)
        } else {

            return UIFont.systemFont(ofSize: fontSize, weight: .regular)
        }
    }

    static func aliFontBold(ofSize fontSize: CGFloat) -> UIFont {
        if   PPFontDownloadManager.canUseDownLoadFont() {
            return UIFont(name: PPFontDownloadManager.share().getBoldFontName(), size: fontSize) ??   .systemFont(ofSize: fontSize, weight: .bold)
        }
        return UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }

    static func aliFontMedium(ofSize fontSize: CGFloat) -> UIFont {
        if   PPFontDownloadManager.canUseDownLoadFont() {
            return UIFont(name: PPFontDownloadManager.share().getMediumFontName(), size: fontSize) ??   .systemFont(ofSize: fontSize, weight: .medium)
        }
        return UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }

    static func aliFontRegular(ofSize fontSize: CGFloat) -> UIFont {
        if   PPFontDownloadManager.canUseDownLoadFont() {
            return UIFont(name: PPFontDownloadManager.share().getRegularFontName(), size: fontSize) ??   .systemFont(ofSize: fontSize, weight: .regular)
        }
        return UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }

    static func youSheBiaoTiHeiFont(ofSize fontSize: CGFloat) -> UIFont {
        if   PPFontDownloadManager.canUseDownLoadFont() {
            return UIFont(name: PPFontDownloadManager.share().getYouSheBiaoTiHeiFontName(), size: fontSize) ??   .systemFont(ofSize: fontSize, weight: .regular)
        }
        return UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }

}
