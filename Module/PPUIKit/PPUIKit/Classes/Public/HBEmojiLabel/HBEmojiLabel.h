//
//  HBEmojiLabel.h
//  SodierEmojiKeyBoardPlus
//
//  Created by Soldier on 15/3/29.
//  Copyright (c) 2015年 Soldier. All rights reserved.
//

#import "MLEmojiLabel.h"

#define kDefaultLineSpacing 6.0

@interface HBEmojiLabel : MLEmojiLabel

- (CGSize)sizeWithConstrainedToWidth:(CGFloat)width ;

+ (CGFloat)heightWithText:(id)text
                     font:(UIFont *)font
       constrainedToWidth:(CGFloat)width;

+ (CGFloat)heightWithText:(id)text
                     font:(UIFont *)font
       constrainedToWidth:(CGFloat)width
              lineSpacing:(CGFloat)lineSpacing;

+ (CGFloat)heightWithText:(id)text
                     font:(UIFont *)font
       constrainedToWidth:(CGFloat)width
            numberOfLines:(NSInteger)numberOfLines;

+ (CGSize)sizeWithText:(id)text
                  font:(UIFont *)font
    constrainedToWidth:(CGFloat)width;

//NSMutableAttributedString类型文本高度
+ (CGSize)attributedStringSizeWithText:(id)text
                                  font:(UIFont *)font
                    constrainedToWidth:(CGFloat)width
                           lineSpacing:(CGFloat)lineSpacing;

+ (CGFloat)heightWithText:(id)text
                     font:(UIFont *)font
       constrainedToWidth:(CGFloat)width
            numberOfLines:(NSInteger)numberOfLines
              lineSpacing:(CGFloat)lineSpacing;

+ (CGSize)sizeWithText:(id)text
                     font:(UIFont *)font
       constrainedToWidth:(CGFloat)width
            numberOfLines:(NSInteger)numberOfLines
             lineSpacing:(CGFloat)lineSpacing;

//纯文本加表情 文本宽高计算
+ (CGSize)sizeWithText:(id)text
                  font:(UIFont *)font
    constrainedToWidth:(CGFloat)width
         emojiMultiple:(CGFloat)multiple
      offsetLineHeight:(CGFloat)offsetLineHeight;

//检测文本中是否有自定义表情，return带有的自定义表情字符数组
+ (NSArray *)checkCustomEmojis:(NSString *)string;

- (void)addLinkToURL:(NSURL *)url
           withRange:(NSRange)range
               color:(UIColor *)color;

@end
