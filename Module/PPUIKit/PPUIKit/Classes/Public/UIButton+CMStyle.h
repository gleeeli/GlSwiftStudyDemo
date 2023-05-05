//
//  UIButton+CMStyle.h
//  ConfigModule
//
//  Created by WJK on 2021/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    UIBtnEdgeInsetsTypeLeft = 0,//图片在左
    UIBtnEdgeInsetsTypeRight,//图片在右
    UIBtnEdgeInsetsTypeTop,//图片在上
    UIBtnEdgeInsetsTypeBottom,//图片在上
} UIBtnEdgeInsetsType;

typedef enum : NSUInteger {
    UIButtonSizeStyleS,
    UIButtonSizeStyleM,
    UIButtonSizeStyleL,
    UIButtonSizeStyleXL,
} UIButtonSizeStyle;

typedef NS_ENUM(NSInteger, BtnType) {
    BtnType1 = 1,
    BtnType2 = 2,
    BtnType3 = 3,
    BtnType4 = 4,
    BtnType5 = 5,
    BtnType6 = 6,
    BtnType7 = 7,
    BtnType8 = 8,
    BtnType9 = 9,
    BtnType10 = 10,
    BtnType11 = 11,
    BtnType12 = 12,
    BtnType13 = 13,
    BtnType14 = 14,
    BtnType15 = 15,
    BtnType16 = 16,
    
    BtnType17 = 17,
    BtnType18 = 18,
    
    BtnType21 = 21,
    BtnType22 = 22,
    BtnType23 = 23
};


typedef NS_ENUM(NSInteger, BtnSize) {
    BtnSize1 = 1,
    BtnSize2 = 2,
    BtnSize3 = 3,
};

@interface UIButton (CMStyle)

@property(nonatomic, strong) id userInfo;

/**
 根据UIButtonState保存layer的border颜色，当且仅当有设置layer.borderWidth才有效， by:wenan
 */
@property (nonatomic, strong) NSMutableDictionary <NSNumber *,UIColor *> *borderColors;

/**
 根据UIButtonState保存不同状态下的背景颜色 by:wenan
 */
@property (nonatomic, strong) NSMutableDictionary <NSNumber *,UIColor *> *bgColors;


- (void)setBtnBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

- (void)setBtnSize:(UIButtonSizeStyle)sizeStyle;
/// btn 样式 https://www.figma.com/file/xAJ9Hw428WYajpoZNVVrNT/%E9%85%8D%E9%85%8D?node-id=2793%3A13300
+ (UIButton*)btn1;
+ (UIButton*)btn2;
+ (UIButton*)btn3;
+ (UIButton*)btn4;

+ (void)setBtnEdgeInsetsWithType:(UIBtnEdgeInsetsType)type button:(UIButton *)btn top:(CGFloat)top space:(CGFloat)space;

- (void)setBtnStyle:(BtnType)btnType;

@end

NS_ASSUME_NONNULL_END
