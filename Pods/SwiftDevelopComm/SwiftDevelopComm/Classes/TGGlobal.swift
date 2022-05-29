//
//  TGGlobal.swift
//  SwiftDevelopFramework
//
//  Created by luo luo on 2020/3/29.
//  Copyright © 2020 GL. All rights reserved.
//

import Foundation
import UIKit

//*start  frame相关
//以模板宽高为标准
let TGTemplateWidth:CGFloat = 320.0;
let TGTemplateHeight:CGFloat = 568.0;

let TGScreenHeight = UIScreen.main.bounds.size.height
let TGScreenWidth = UIScreen.main.bounds.size.width
//状态条的高
let TGStatusBarHeight = UIApplication.shared.statusBarFrame.height

//是否刘海屏
func TGIsFullScreenDevice() -> Bool {
    if #available(iOS 11, *) {
          guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
              return false
          }
          
          if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
              print(unwrapedWindow.safeAreaInsets)
              return true
          }
    }
    return false
}

func TGNavigationBarHeight() -> CGFloat {
    return TGIsFullScreenDevice() ? 88 : 64
}

func TGBottomSafeHeight() -> CGFloat {
    return TGIsFullScreenDevice() ? 34 : 0
}

//宽高比例系数
func TGWIDTHScale() -> CGFloat {
    var scaleWidth:CGFloat = 1.0;
    if UIScreen.main.bounds.size.width > UIScreen.main.bounds.height {
        //横屏状态
        scaleWidth = CGFloat(UIScreen.main.bounds.height/TGTemplateWidth);
    }else{
        //竖屏状态
        scaleWidth = UIScreen.main.bounds.size.width/TGTemplateWidth;
    }
    
    return scaleWidth;
}

func TGHeightScale() -> CGFloat {
    var scaleWidth:CGFloat = 1.0;
    if UIScreen.main.bounds.size.height > UIScreen.main.bounds.width {
        //竖屏屏状态
        scaleWidth = CGFloat(UIScreen.main.bounds.height/TGTemplateHeight);
    }else{
        //横屏状态
        scaleWidth = UIScreen.main.bounds.size.width/TGTemplateHeight;
    }
    
    return scaleWidth;
}

//获取控件的X、Y 宽、高
func TGWidth(widget:UIView?) -> CGFloat {
    return (widget?.frame.size.width)!
}
func TGHeight(widget:UIView?) -> CGFloat {
    return (widget?.frame.size.height)!
}
func TGMinX(widget:UIView?) -> CGFloat {
    return (widget?.frame.origin.x)!
}
func TGMinY(widget:UIView?) -> CGFloat {
    return (widget?.frame.origin.y)!
}
func TGMaxX(widget:UIView?) -> CGFloat {
    return TGMinX(widget: widget) + TGWidth(widget: widget)
}
func TGMaxY(widget:UIView?) -> CGFloat {
    return TGMinY(widget: widget) + TGHeight(widget: widget)
}

//将某个值按宽度值进行缩放
func TGX(value:CGFloat?) -> CGFloat {
    return value!*TGWIDTHScale()
}
//将某个值按高度进行缩放
func TGY(value:CGFloat?) -> CGFloat {
    return value!*TGHeightScale()
}


//*end

//**start  网络相关

//**end
