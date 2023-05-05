//
//  HBEmojiLabel.m
//  SodierEmojiKeyBoardPlus
//
//  Created by Soldier on 15/3/29.
//  Copyright (c) 2015年 Soldier. All rights reserved.
//

#import "HBEmojiLabel.h"
#import <XHBUIKit/NSString+Emoji.h>
#import <HBPublic/UIView+XHB.h>
#import <HBPublic/UILabel+XHB.h>

@implementation HBEmojiLabel

/*
 * Readme
 *
 * by Soldier
 * on 15/4/3.
 *
 * self.text = NSString / NSAttributedString ok
 * self.attributedText = NSAttributedString emoji无效
 *
 * 使用NSAttributedString后Label.font、Label.textColor，label默认行间距将失效,需要在NSAttributedString重设font，textColor，label默认行间距
 *
 * to do，使用NSAttributedString，如有较多emoji UI会出错，慎用！
 *
 *使用以下方法解决 注* 使用kCTForegroundColorAttributeName，NSForegroundColorAttributeName有问题;
 *NSMutableParagraphStyle有问题，请勿使用
 *- (void)setText:(id)text
 afterInheritingLabelAttributesAndConfiguringWithBlock:(NSMutableAttributedString * (^)(NSMutableAttributedString *mutableAttributedString))block
 *
 */

static NSString * const kXHBCustomEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
static NSString * const kXHBCustomEmojiNewRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+/\\]";
static NSString * const kXHBCustomEmojiPlistName = @"EmojiImageMap.plist";
static NSString * const kXHBCustomEmojiNewPlistName = @"EmojiImageMapNew.plist";


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame linkColor:(UIColor *)color {
    self = [super initWithFrame:frame linkColor:color];
    if (self) {
        [self customConfig];
    }
    return self;
}

- (void)customConfig {
    self.customEmojiRegex = kXHBCustomEmojiRegex;
    self.customEmojiNewRegex = kXHBCustomEmojiNewRegex;
    self.customEmojiPlistName = kXHBCustomEmojiPlistName;
    self.customEmojiNewPlistName = kXHBCustomEmojiNewPlistName;
    self.lineSpacing = kDefaultLineSpacing;
    self.emojiOriginYOffsetRatioWithLineHeight = - 0.15; //表情绘制的y坐标矫正值，和字体高度的比例，越大越往下
    
    self.emojiWidthRatioWithLineHeight = 1.10; //和字体高度的比例
    
    self.disableThreeCommon = YES;//禁用电话，邮箱，连接三者
}

- (void)setText:(id)text {
    if ([text isKindOfClass:[NSString class]]) {
        text = [text stringByReplacingEmojiCheatCodesWithUnicode];//emoji代码转emoji
    }
    [super setText:text];
}

- (CGSize)sizeWithConstrainedToWidth:(CGFloat)width {
    CGSize size = [self preferredSizeWithMaxWidth:width];
    return CGSizeMake(size.width, size.height + self.lineSpacing); //有偏差，需再加行高调整
}

+ (CGFloat)heightWithText:(id)text
                     font:(UIFont *)font
       constrainedToWidth:(CGFloat)width {
    
    return [HBEmojiLabel heightWithText:text font:font constrainedToWidth:width lineSpacing:kDefaultLineSpacing];
}

+ (CGFloat)heightWithText:(id)text
                     font:(UIFont *)font
       constrainedToWidth:(CGFloat)width
              lineSpacing:(CGFloat)lineSpacing {
    HBEmojiLabel *label = [[HBEmojiLabel alloc] init];
    label.font = font;
    label.lineSpacing = lineSpacing;
    label.text = text;
    
    return [label sizeWithConstrainedToWidth:width].height;
}

+ (CGFloat)heightWithText:(id)text
                     font:(UIFont *)font
       constrainedToWidth:(CGFloat)width
            numberOfLines:(NSInteger)numberOfLines {
    HBEmojiLabel *label = [[HBEmojiLabel alloc] init];
    label.font = font;
    label.numberOfLines = numberOfLines;
    label.text = text;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    return [label sizeWithConstrainedToWidth:width].height;
}

+ (CGSize)sizeWithText:(id)text
                  font:(UIFont *)font
    constrainedToWidth:(CGFloat)width
         emojiMultiple:(CGFloat)multiple
      offsetLineHeight:(CGFloat)offsetLineHeight {
    HBEmojiLabel *label = [[HBEmojiLabel alloc] init];
    label.font = font;
    label.text = text;
    label.emojiWidthRatioWithLineHeight = multiple;
    label.lineSpace = 3;
    label.emojiOriginYOffsetRatioWithLineHeight = offsetLineHeight;
    return [label sizeWithConstrainedToWidth:width];
}

+ (CGSize)sizeWithText:(id)text
                  font:(UIFont *)font
    constrainedToWidth:(CGFloat)width {
    HBEmojiLabel *label = [[HBEmojiLabel alloc] init];
    label.font = font;
    label.text = text;
    
    return [label sizeWithConstrainedToWidth:width];
}

+ (CGSize)attributedStringSizeWithText:(id)text
                  font:(UIFont *)font
    constrainedToWidth:(CGFloat)width
           lineSpacing:(CGFloat)lineSpacing {
    HBEmojiLabel *label = [[HBEmojiLabel alloc] init];
    label.font = font;
    label.lineSpacing = lineSpacing;
    
    [label setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        return mutableAttributedString;
    }];
    
    return [label sizeWithConstrainedToWidth:width];
}

+ (CGFloat)heightWithText:(id)text
                     font:(UIFont *)font
       constrainedToWidth:(CGFloat)width
            numberOfLines:(NSInteger)numberOfLines
              lineSpacing:(CGFloat)lineSpacing {
    HBEmojiLabel *label = [[HBEmojiLabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    label.lineSpacing = lineSpacing;
    label.font = font;
    label.numberOfLines = numberOfLines;
    label.text = text;
    [label sizeToFit];
    label.frame = CGRectMake(0, 0, width, label.height);
    
    return label.height;
}

+ (CGSize)sizeWithText:(id)text
                     font:(UIFont *)font
       constrainedToWidth:(CGFloat)width
            numberOfLines:(NSInteger)numberOfLines
              lineSpacing:(CGFloat)lineSpacing {
    HBEmojiLabel *label = [[HBEmojiLabel alloc] init];
    label.font = font;
    label.lineSpacing = lineSpacing;
    label.numberOfLines = numberOfLines;
    label.text = text;
    
    return [label sizeWithConstrainedToWidth:width];
}

/*
 * 解决上千个emoji滑动卡顿问题，可能会影响超链接等， to do
 * by Soldier
 * 2015.04.10
 */
//- (UIView *)hitTest:(CGPoint)point
//          withEvent:(UIEvent *)event{
//    return nil;
//}

//检测文本中是否有自定义表情，return带有的自定义表情字符数组
+ (NSArray *)checkCustomEmojis:(NSString *)string {
    NSRegularExpression *customEmojiRegularExpression = [[NSRegularExpression alloc] initWithPattern:kXHBCustomEmojiRegex options:NSRegularExpressionCaseInsensitive error:nil];
    NSRegularExpression *customEmojiNewRegularExpression = [[NSRegularExpression alloc] initWithPattern:kXHBCustomEmojiNewRegex options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSDictionary *customEmojiDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kXHBCustomEmojiPlistName]];
    NSDictionary *customNewEmojiDict = [[NSDictionary alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kXHBCustomEmojiNewPlistName]];
    
    NSArray *arr1 = [customEmojiRegularExpression matchesInString:string
                                                              options:NSMatchingWithTransparentBounds
                                                                range:NSMakeRange(0, [string length])];
    NSArray *arr2 = [customEmojiNewRegularExpression matchesInString:string
                                                              options:NSMatchingWithTransparentBounds
                                                                range:NSMakeRange(0, [string length])];
    NSMutableArray *emojis = [NSMutableArray array];
    [emojis addObjectsFromArray:arr1];
    [emojis addObjectsFromArray:arr2];
    
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
    for (NSTextCheckingResult *result in emojis) {
        NSRange range = result.range;
        
        NSString *emojiKey = [string substringWithRange:range];
        
        NSString *imageName = customNewEmojiDict[emojiKey];
        if (!imageName) {
            imageName = customEmojiDict[emojiKey];
        }
        if (imageName) {
            [temp addObject:emojiKey];
        }
    }
    return temp;
}

- (void)addLinkToURL:(NSURL *)url
           withRange:(NSRange)range
               color:(UIColor *)color {
    NSMutableDictionary *mutableLinkAttributes = [NSMutableDictionary dictionaryWithDictionary:self.linkAttributes];
    [mutableLinkAttributes setObject:color forKey:(NSString *)kCTForegroundColorAttributeName];
    self.linkAttributes = mutableLinkAttributes;
    NSTextCheckingResult *result = [NSTextCheckingResult linkCheckingResultWithRange:range URL:url];
    [self addLinkWithTextCheckingResult:result attributes:self.linkAttributes];
}

@end
