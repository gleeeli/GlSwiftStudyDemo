//
//  SJRichLabel.h
//  SodierEmojiKeyBoardPlus
//
//  Created by Soldier on 15/8/28.
//  Copyright (c) 2015年 Shaojie Hong. All rights reserved.
//

#import "HBEmojiLabel.h"

@interface SJRichLabel : HBEmojiLabel

/**
 * 是否支持icon font
 */
@property (nonatomic, assign) BOOL iconFontEnable;

/**
 * 富文本，*使用此字段有效
 */
@property (nonatomic, strong) NSString *richText;

/**
 * 是否支持自定义复制菜单
 */
@property (nonatomic, assign) BOOL customCopy;

/**
 * 关键词颜色, default COLOR_C4
 */
@property (strong, nonatomic) UIColor *keywordColor;

/**
 * 超链接富文本，*在字体等属性赋值后使用
 * linkUrlArray 链接字符串数组
 */
- (void)addLinkText:(NSString *)text linkUrlArray:(NSMutableArray *)linkUrlArray;

+ (CGFloat)richHeightWithText:(NSString *)text
                         font:(UIFont *)font
           constrainedToWidth:(CGFloat)width
                  lineSpacing:(CGFloat)lineSpacing;

/*
 * 行高计算
 * 不含超链接
 */
+ (CGFloat)richHeightWithText:(NSString *)text
                         font:(UIFont *)font
           constrainedToWidth:(CGFloat)width
                  lineSpacing:(CGFloat)lineSpacing
                numberOfLines:(NSInteger)numberOfLines;

@end
