//
//  GLCommHeader.h
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/12/14.
//  Copyright © 2023 gleeeli. All rights reserved.
//

#ifndef GLCommHeader_h
#define GLCommHeader_h

#import "NSString+XHB.h"
#import "HBUIStyle.h"
#import "UIImage+XHB.h"

#define HB_RGBCOLOR(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1]
#define HB_RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a)]

//表示  iPad UI 布局 === 若是 ipad 采用适配模式安装iPhone app 此时返回 NO
#define HB_IsiPadUI() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#define HB_UIScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define HB_UIScreenHeight ([[UIScreen mainScreen] bounds].size.height)

#define HB_IsiPhoneX() ((HB_UIScreenWidth >= 375.f && HB_UIScreenHeight >= 812.f && !HB_IsiPadUI()) ? YES : NO)
/// 屏幕宽度  -正常屏幕为414 大于414 需要适配
#define HB_IsiPhoneMax() ((HB_UIScreenWidth > 415.f && HB_UIScreenHeight >= 900.f && !HB_IsiPadUI()) ? YES : NO)
/// iphoneMax 手机 字体大小缩放
#define IPhoneMaxMultiple 1.1f

#define TH_FONT_D1 32
#define TH_FONT_D2 24
#define TH_FONT_H1 20
#define TH_FONT_H2 18
#define TH_FONT_H3 16
#define TH_FONT_B1 15
#define TH_FONT_B2 14
#define TH_FONT_B3 13
#define TH_FONT_B4 12
#define TH_FONT_N1 11
#define TH_FONT_N2 10
#define TH_FONT_N3 9

#define TH_FONT_D1_FIT HB_ScreenAdapt(TH_FONT_D1) /*32*/
#define TH_FONT_D2_FIT HB_ScreenAdapt(TH_FONT_D2) /*24*/
#define TH_FONT_H1_FIT HB_ScreenAdapt(TH_FONT_H1) /*20*/
#define TH_FONT_H2_FIT HB_ScreenAdapt(TH_FONT_H2) /*18*/
#define TH_FONT_H3_FIT HB_ScreenAdapt(TH_FONT_H3) /*16*/
#define TH_FONT_B1_FIT HB_ScreenAdapt(TH_FONT_B1) /*15*/
#define TH_FONT_B2_FIT HB_ScreenAdapt(TH_FONT_B2) /*14*/
#define TH_FONT_B3_FIT HB_ScreenAdapt(TH_FONT_B3) /*13*/
#define TH_FONT_B4_FIT HB_ScreenAdapt(TH_FONT_B4) /*12*/
#define TH_FONT_N1_FIT HB_ScreenAdapt(TH_FONT_N1) /*11*/
#define TH_FONT_N2_FIT HB_ScreenAdapt(TH_FONT_N2) /*10*/
#define TH_FONT_N3_FIT HB_ScreenAdapt(TH_FONT_N3) /*9*/

/* 屏幕适配*/
#define HB_ScreenAdapt(x) (HB_IsiPhoneMax() ? IPhoneMaxMultiple * (x) :  (x))

#endif /* GLCommHeader_h */
