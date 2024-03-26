//
//  UIFont+XHB.m
//  HBPublic
//
//  Created by wenan on 2019/11/27.
//

#import "UIFont+XHB.h"

@implementation UIFont (XHB)

/// 苹方-简 常规体
+ (UIFont *)hb_fontWithPingFangSCRegularSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

/// 苹方-简 极细体
+ (UIFont *)hb_fontWithPingFangSCUltralightSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Ultralight" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

/// 苹方-简 细体
+ (UIFont *)hb_fontWithPingFangSCLightSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

/// 苹方-简 纤细体
+ (UIFont *)hb_fontWithPingFangSCThinSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Thin" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

/// 苹方-简 中黑体
+ (UIFont *)hb_fontWithPingFangSCMediumSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:size];
    if (!font) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}

/// 苹方-简 中粗体
+ (UIFont *)hb_fontWithPingFangSCSemiboldSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
    if (!font) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}

/// DIN字体
+ (UIFont *)hb_fontWithDinAlternateSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"DIN Alternate" size:size];
    if (!font) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}

@end
