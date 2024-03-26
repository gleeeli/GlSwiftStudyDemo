//
//  UIFont+XHB.h
//  HBPublic
//
//  Created by wenan on 2019/11/27.
//


#import <UIKit/UIKit.h>

@interface UIFont (XHB)

/// 苹方-简 常规体
+ (UIFont *)hb_fontWithPingFangSCRegularSize:(CGFloat)size;

/// 苹方-简 极细体
+ (UIFont *)hb_fontWithPingFangSCUltralightSize:(CGFloat)size;

/// 苹方-简 细体
+ (UIFont *)hb_fontWithPingFangSCLightSize:(CGFloat)size;

/// 苹方-简 纤细体
+ (UIFont *)hb_fontWithPingFangSCThinSize:(CGFloat)size;

/// 苹方-简 中黑体
+ (UIFont *)hb_fontWithPingFangSCMediumSize:(CGFloat)size;

/// 苹方-简 中粗体
+ (UIFont *)hb_fontWithPingFangSCSemiboldSize:(CGFloat)size;

/// DIN 字体
+ (UIFont *)hb_fontWithDinAlternateSize:(CGFloat)size;


@end

