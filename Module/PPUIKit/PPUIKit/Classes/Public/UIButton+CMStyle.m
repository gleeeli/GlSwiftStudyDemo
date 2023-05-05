//
//  UIButton+CMStyle.m
//  ConfigModule
//
//  Created by WJK on 2021/8/13.
//

#import "UIButton+CMStyle.h"
#import "objc/runtime.h"
#import <PPUIKit/PPUIKit-Swift.h>

#import <HBPublic/NSDictionary+XHB.h>
// button 地址: https://www.figma.com/file/xAJ9Hw428WYajpoZNVVrNT/%E9%85%8D%E9%85%8D?node-id=2789%3A13214

@implementation UIButton (CMStyle)
static char userInfoKey;

- (void)setBtnSize:(UIButtonSizeStyle)sizeStyle{
    
    switch (sizeStyle) {
        case UIButtonSizeStyleS :
            self.size = CGSizeMake(62, 28);
            break;
        case UIButtonSizeStyleM :
            self.size = CGSizeMake(70, 36);
            break;
        case  UIButtonSizeStyleL :
            self.size = CGSizeMake(82, 44);
            break;
        case UIButtonSizeStyleXL :
            self.size = CGSizeMake(86, 50);
            break;
    }
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height/2.0;
}

- (void)setSize:(CGSize)size{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

+ (UIButton*)btn1{

    return  [[[UIButton alloc] init] creatButtonWithStyle:1];
}
+ (UIButton*)btn2{
    return  [[[UIButton alloc] init] creatButtonWithStyle:2];
}
+ (UIButton*)btn3{
    return  [[[UIButton alloc] init] creatButtonWithStyle:3];
}
+ (UIButton*)btn4{
    return  [[[UIButton alloc] init] creatButtonWithStyle:4];
}


- (UIButton *)creatButtonWithStyle:(int)type{
    
    
    UIColor *textColor_nl = PPUIColor.textNormalWhiteAlpha09Color;
    UIColor *textColor_hl = PPUIColor.textNormalWhiteAlpha07Color;
    UIColor *textColor_dis = PPUIColor.textNormalWhiteAlpha07Color;
    UIColor *textColor_sl = PPUIColor.textNormalWhiteAlpha07Color;;

    UIColor *bgColor_nl, *bgColor_hl, *bgColor_dis, *bgColor_sl = nil;
    CGFloat borderWidth = 0;
    UIColor *borderColor_nl, *borderColor_hl, *borderColor_dis, *borderColor_sl = nil;
    switch (type) {
        case 1:
        {

            textColor_nl = PPUIColor.textNormalWhiteAlpha09Color;
            textColor_hl = PPUIColor.textNormalWhiteAlpha07Color;
            textColor_dis = PPUIColor.textNormalWhiteAlpha07Color;
            
            bgColor_nl = PPUIColor.P1Color;
            bgColor_hl = PPUIColor.P1Color;
            bgColor_dis = PPUIColor.bgF1GrayColor;;

        }
            break;
        case 2:
        {

            textColor_nl = PPUIColor.P1Color;
            textColor_hl = PPUIColor.P3Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;

            borderColor_nl = PPUIColor.P1Color;
            borderColor_hl = PPUIColor.P3Color;
            borderColor_dis= PPUIColor.textVisualBlackAlpha017Color;;
            
            borderWidth = 0.5;

        }
            break;
        case 3:
        {

            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textWeakenBlackAlpha036Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;

            borderColor_nl = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_hl = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_dis= PPUIColor.textVisualBlackAlpha017Color;;
            
            borderWidth = 0.5;

        }
            break;
        case 4:
        {

            textColor_nl = PPUIColor.P1Color;
            textColor_hl = PPUIColor.P3Color;
            textColor_dis = PPUIColor.P6Color;
            
            bgColor_nl = PPUIColor.bgF6GrayColor;
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = PPUIColor.bgF6GrayColor;;

        }
            break;

        default:
            break;
    }

    if (borderWidth > 0) {
        self.layer.borderWidth = borderWidth;
    }else {
        self.layer.borderWidth = 0;
    }
    
    [self.bgColors removeAllObjects];
       [self setBtnBackgroundColor:bgColor_nl forState:UIControlStateNormal];
       [self setBtnBackgroundColor:bgColor_hl forState:UIControlStateHighlighted];
       [self setBtnBackgroundColor:bgColor_dis forState:UIControlStateDisabled];
       [self setBtnBackgroundColor:bgColor_sl forState:UIControlStateSelected];

       [self.borderColors removeAllObjects];
       [self setBtnBorderColor:borderColor_nl forState:UIControlStateNormal];
       [self setBtnBorderColor:borderColor_hl forState:UIControlStateHighlighted];
       [self setBtnBorderColor:borderColor_dis forState:UIControlStateDisabled];
    [self setBtnBorderColor:borderColor_sl forState:UIControlStateSelected];

    [self setTitleColor:textColor_nl forState:UIControlStateNormal];
    [self setTitleColor:textColor_hl forState:UIControlStateHighlighted];
    [self setTitleColor:textColor_dis forState:UIControlStateDisabled];
    if (textColor_sl) {
        [self setTitleColor:textColor_sl forState:UIControlStateSelected];
    }
    return  self;
}

- (void)setBtnBorderColor:(UIColor *)color forState:(UIControlState)state {
    if (nil == color) {
        return;
    }
    [self.borderColors setObjectSafely:color forCopyingKeySafely:@(state)];
    if(self.state == state) {
        self.layer.borderColor = color.CGColor;
    }
    
}

- (void)setBtnBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    if (nil == backgroundColor) {
        return;
    }
    [self.bgColors setObjectSafely:backgroundColor forCopyingKeySafely:@(state)];
    if(self.state == state) {
        self.backgroundColor = backgroundColor;
    }
}



#pragma mark - setter & getter

- (void)setUserInfo:(id)userInfo {
    objc_setAssociatedObject(self, &userInfoKey, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)userInfo {
    return objc_getAssociatedObject(self, &userInfoKey);
}

- (void)setBorderColors:(NSMutableDictionary<NSNumber *,UIColor *> *)borderColors {
    objc_setAssociatedObject(self, @selector(borderColors), borderColors, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSNumber *,UIColor *> *)borderColors {
    NSMutableDictionary *borderColors = objc_getAssociatedObject(self, @selector(borderColors));
    if(!borderColors) {
        borderColors = [[NSMutableDictionary alloc] init];
        self.borderColors = borderColors;
    }
    return borderColors;
}

- (void)setBgColors:(NSMutableDictionary<NSNumber *,UIColor *> *)bgColors {
    objc_setAssociatedObject(self, @selector(bgColors), bgColors, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSNumber *,UIColor *> *)bgColors {
    NSMutableDictionary *bgColors = objc_getAssociatedObject(self, @selector(bgColors));
    if(!bgColors) {
        bgColors = [[NSMutableDictionary alloc] init];
        self.bgColors = bgColors;
    }
    return bgColors;
}

+ (void)setBtnEdgeInsetsWithType:(UIBtnEdgeInsetsType)type button:(UIButton *)btn top:(CGFloat)top space:(CGFloat)space {
    
    CGFloat imageWidth = btn.imageView.frame.size.width;
    CGFloat imageHeight = btn.imageView.frame.size.height;
    CGFloat titleWidth = btn.titleLabel.frame.size.width;
    CGFloat titleHeight = btn.titleLabel.frame.size.height;
    CGFloat imageTop = (btn.frame.size.height-imageHeight)/2;
    CGFloat imageLeft = btn.frame.size.width/2-imageWidth;
//    CGFloat tiltleTop = (btn.frame.size.height-titleHeight)/2;
    CGFloat titleLeft = btn.frame.size.width/2;
    
    switch (type) {
        case UIBtnEdgeInsetsTypeLeft:
            
            break;
            
        case UIBtnEdgeInsetsTypeRight:
            
            break;
            
        case UIBtnEdgeInsetsTypeTop:
            btn.imageEdgeInsets = UIEdgeInsetsMake(-(imageTop-top), (btn.frame.size.width-imageWidth)/2-imageLeft, (imageTop-top), -((btn.frame.size.width-imageWidth)/2-imageLeft));
            btn.titleEdgeInsets = UIEdgeInsetsMake((imageTop-top)+imageHeight+space, (btn.frame.size.width-titleWidth)/2-titleLeft, btn.frame.size.height-((imageTop-top)+imageHeight+space), -((btn.frame.size.width-titleWidth)/2-titleLeft));
            break;
            
        case UIBtnEdgeInsetsTypeBottom:
            
            break;
            
        default:
            break;
    }
}

#pragma mark - Override

- (void)hb_setHighlighted:(BOOL)highlighted {
    [self hb_setHighlighted:highlighted]; // 此时的方法实现已经替换，相当于调用了[self setHighlighted]
    [self updateAppearanceWhenStateDidChange];
}

- (void)hb_setEnabled:(BOOL)enabled {
    [self hb_setEnabled:enabled];
    [self updateAppearanceWhenStateDidChange];
}

- (void)hb_setSelected:(BOOL)selected {
    [self hb_setSelected:selected];
    [self updateAppearanceWhenStateDidChange];
}


- (void)setBtnStyle:(BtnType)btnType {
#ifdef PEIPEI
    UIColor *textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
    UIColor *textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
    UIColor *textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
    UIColor *textColor_sl = nil;
    
    UIColor *bgColor_nl, *bgColor_hl, *bgColor_dis, *bgColor_sl = nil;
    BOOL isRound = NO;// 是否圆角
    CGFloat cornerRadius = 0; // 指定圆角弧度 默认是self.frame.size.height/2.0f
    CGFloat borderWidth = 0;
    UIColor *borderColor_nl, *borderColor_hl, *borderColor_dis, *borderColor_sl = nil;
    
    switch (btnType) {
        case BtnType1:
            bgColor_nl = PPUIColor.bgA0BlueColor;
            bgColor_hl = PPUIColor.bg81BlueColor;
            bgColor_dis = PPUIColor.bgA0BlueColor;
            
            textColor_nl = PPUIColor.bg28BlackColor;
            textColor_hl = PPUIColor.bg28BlackColor;
            textColor_dis = [UIColor colorWithRed:40.0/255.0 green:33.0/255.0 blue:33.0/255.0 alpha:0.3];
            break;
            
        case BtnType2:
            bgColor_nl = PPUIColor.bg28BlackColor;
            bgColor_hl = [UIColor colorWithRed:27.0/255.0 green:22.0/255.0 blue:22.0/255.0 alpha:1];
            bgColor_dis = PPUIColor.bg28BlackColor;
            
            textColor_nl = [UIColor whiteColor];
            textColor_hl = PPUIColor.textNormalBlackAlpha055Color;
            textColor_dis = PPUIColor.textNormalBlackAlpha08Color;
            
            break;
            
        case BtnType3:
            bgColor_nl = PPUIColor.bgF1GrayColor;
            bgColor_hl = PPUIColor.bgEAGrayColor;
            bgColor_dis = PPUIColor.bgF1GrayColor;
            bgColor_sl = PPUIColor.bgA0BlueColor;
            
            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = PPUIColor.bg28BlackColor;
            
            break;
            
        case BtnType4:
            
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = [UIColor clearColor];
            bgColor_sl = [UIColor clearColor];

            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_hl = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_dis = PPUIColor.bgF1GrayColor;
            borderColor_sl = PPUIColor.textNormalBlackAlpha08Color;

            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = PPUIColor.textNormalBlackAlpha08Color;
            
            break;
            
        case BtnType5:
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = [UIColor clearColor];
            bgColor_sl = PPUIColor.bg28BlackColor;

            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            borderColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            borderColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_sl = PPUIColor.bg28BlackColor;
            
            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = [UIColor whiteColor];
            
            break;
            
        case BtnType6:
            bgColor_nl = PPUIColor.bgFFRedColor;
            bgColor_hl = [UIColor colorWithRed:2160/255.0 green:53.0/255.0 blue:69.0/255.0 alpha:1];
            bgColor_dis = PPUIColor.bgFFRedColor;
            
            textColor_nl = [UIColor whiteColor];
            textColor_hl = [UIColor whiteColor];
            textColor_dis = [UIColor colorWithRed:255/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.2];
            
            break;
            
        case BtnType7:
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = [UIColor colorWithRed:255/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:0.2];
            bgColor_dis = [UIColor clearColor];

            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.bgA0BlueColor;
            borderColor_hl = PPUIColor.bgA0BlueColor;
            borderColor_dis = [UIColor colorWithRed:255/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:0.2];
            
            textColor_nl = PPUIColor.bgA0BlueColor;
            textColor_hl = PPUIColor.bgA0BlueColor;
            textColor_dis = [UIColor colorWithRed:255/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:0.2];
            
            break;
            
        case BtnType8:
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = [UIColor colorWithRed:255/255.0 green:68.0/255.0 blue:86.0/255.0 alpha:0.1];
            bgColor_dis = [UIColor clearColor];

            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.bgFFRedColor;
            borderColor_hl = PPUIColor.bgFFRedColor;
            borderColor_dis = [UIColor colorWithRed:255/255.0 green:68.0/255.0 blue:86.0/255.0 alpha:0.4];
            
            textColor_nl = PPUIColor.bgFFRedColor;
            textColor_hl = PPUIColor.bgFFRedColor;
            textColor_dis = [UIColor colorWithRed:255/255.0 green:68.0/255.0 blue:86.0/255.0 alpha:0.4];;
            
            break;
            
        case BtnType9:
            bgColor_nl = PPUIColor.bg28BlackColor;
            bgColor_hl = [UIColor colorWithRed:27.0/255.0 green:22.0/255.0 blue:22.0/255.0 alpha:1];
            bgColor_dis = PPUIColor.bg28BlackColor;
            
            textColor_nl = PPUIColor.bgA0BlueColor;
            textColor_hl = [UIColor colorWithRed:228.0/255.0 green:191.0/255.0 blue:88.0/255.0 alpha:0.6];
            textColor_dis = [UIColor colorWithRed:255.0/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:0.3];
            
            break;
        case BtnType10:
            isRound = YES;
            
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = [UIColor clearColor];
            bgColor_sl = PPUIColor.bg28BlackColor;

            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            borderColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            borderColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_sl = PPUIColor.bg28BlackColor;

            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = [UIColor whiteColor];
            break;
            
        case BtnType11:
            isRound = YES;
            
            bgColor_nl = PPUIColor.bgF1GrayColor;
            bgColor_hl = PPUIColor.bgEAGrayColor;
            bgColor_dis = PPUIColor.bgF1GrayColor;
            bgColor_sl = PPUIColor.bgA0BlueColor;
            
            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = PPUIColor.bg28BlackColor;

            break;
        case BtnType12:
            isRound = YES;

            bgColor_nl = PPUIColor.bgA0BlueColor;
            bgColor_hl = PPUIColor.bg81BlueColor;
            bgColor_dis = PPUIColor.bgA0BlueColor;
            bgColor_sl = [UIColor clearColor];
            
            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.bgA0BlueColor;
            borderColor_hl = PPUIColor.bg81BlueColor;
            borderColor_dis = PPUIColor.bgA0BlueColor;
            borderColor_sl = PPUIColor.textVisualBlackAlpha017Color;
            
            textColor_nl = PPUIColor.bg28BlackColor;
            textColor_hl = PPUIColor.bg28BlackColor;
            textColor_dis = [COLOR_C3 colorWithAlphaComponent:0.3];
            textColor_sl = PPUIColor.textNormalBlackAlpha08Color;
            break;
            
         case BtnType13:
            isRound = YES;
            
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = [UIColor clearColor];
            bgColor_sl = [UIColor clearColor];

            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_hl = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_dis = PPUIColor.bgF1GrayColor;
            borderColor_sl = PPUIColor.textNormalBlackAlpha08Color;
            
            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = PPUIColor.textNormalBlackAlpha08Color;
            
            break;
        
        case BtnType14:
            isRound = YES;
            cornerRadius = 4.0f;
            bgColor_nl = PPUIColor.bgA0BlueColor;
            bgColor_hl = PPUIColor.bg81BlueColor;
            bgColor_dis = PPUIColor.bgEAGrayColor;
            
            
            
            textColor_nl = PPUIColor.bg28BlackColor;
            textColor_hl = PPUIColor.bg28BlackColor;
            textColor_dis = PPUIColor.textWeakenBlackAlpha036Color;
            textColor_sl = PPUIColor.bg28BlackColor;

            break;
        case BtnType15:
            isRound = YES;

            bgColor_nl = PPUIColor.bg28BlackColor;
            bgColor_hl = [UIColor colorWithRed:27.0/255.0 green:22.0/255.0 blue:22.0/255.0 alpha:1];
            bgColor_dis = PPUIColor.bg28BlackColor;
            
            textColor_nl = PPUIColor.bgA0BlueColor;
            textColor_hl = [UIColor colorWithRed:228.0/255.0 green:191.0/255.0 blue:88.0/255.0 alpha:0.6];
            textColor_dis = [UIColor colorWithRed:255.0/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:0.3];
            
            break;
        case BtnType16:
            isRound = YES;
            
            bgColor_nl = PPUIColor.bgFFRedColor;
            bgColor_hl = [UIColor colorWithRed:2160/255.0 green:53.0/255.0 blue:69.0/255.0 alpha:1];
            bgColor_dis = PPUIColor.bgFFRedColor;
            
            textColor_nl = [UIColor whiteColor];
            textColor_hl = [UIColor whiteColor];
            textColor_dis = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
            
            break;
            
        case BtnType17:
            isRound = YES;
            
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = PPUIColor.bgEAGrayColor;
            bgColor_sl = PPUIColor.bgF6GrayColor;
            
            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.bgEAGrayColor;
            borderColor_hl = PPUIColor.bgF6GrayColor;
            borderColor_dis = PPUIColor.bgEAGrayColor;
            borderColor_sl = PPUIColor.bgEAGrayColor;
            
            textColor_nl = PPUIColor.textNormalBlackAlpha055Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha055Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = PPUIColor.textNormalBlackAlpha055Color;
            break;
            
        case BtnType18:
            isRound = YES;
            
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = [UIColor clearColor];
            
            textColor_nl = PPUIColor.textNormalBlackAlpha055Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha055Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            
            borderWidth = 0.5f;
            borderColor_nl = PPUIColor.bgEAGrayColor;
            borderColor_hl = PPUIColor.bgEAGrayColor;
            borderColor_dis = PPUIColor.bgEAGrayColor;
            
            break;
            
        case BtnType21:
            isRound = YES;
            
            bgColor_nl = PPUIColor.bgA0BlueColor;
            bgColor_hl = PPUIColor.bg81BlueColor;
            bgColor_dis = HB_RGBCOLOR(185,159,217);
            
            textColor_nl = PPUIColor.textNormalWhiteColor;
            textColor_hl = PPUIColor.text_white_1_80;
            textColor_dis = PPUIColor.text_white_1_60;

            break;
        case BtnType22:
            isRound = YES;
            
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = [UIColor colorWithRed:255/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:0.19];
            bgColor_dis = [UIColor clearColor];
            
            borderWidth = 0.5f;
            borderColor_nl = PPUIColor.bg81BlueColor;
            borderColor_hl = PPUIColor.bg81BlueColor;
            borderColor_dis = [UIColor colorWithRed:228/255.0 green:191.0/255.0 blue:88.0/255.0 alpha:0.5];
            
            textColor_nl = PPUIColor.bg81BlueColor;
            textColor_hl = PPUIColor.bg81BlueColor;
            textColor_dis = [UIColor colorWithRed:228/255.0 green:191.0/255.0 blue:88.0/255.0 alpha:0.5];
            
            break;

        case BtnType23:
            isRound = YES;
            
            textColor_nl = PPUIColor.textNormalBlackAlpha055Color;
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_sl = [UIColor clearColor];
            bgColor_dis = [UIColor clearColor];
            
            borderWidth = 0.5f;
            borderColor_nl = PPUIColor.bgEAGrayColor;
            borderColor_sl = PPUIColor.bgEAGrayColor;
            borderColor_hl = PPUIColor.bgEAGrayColor;
            borderColor_dis = PPUIColor.bgEAGrayColor;
        default:
            
            break;
    }
    
    if (isRound) {
        if (cornerRadius > 0) {
            self.layer.cornerRadius = cornerRadius;
        }else {
            self.layer.cornerRadius = self.frame.size.height /2.0f;
        }
        self.layer.masksToBounds = YES;
    }else {
        self.layer.cornerRadius = 0;
    }
    
    if (borderWidth > 0) {
        self.layer.borderWidth = borderWidth;
    }else {
        self.layer.borderWidth = 0;
    }
    
    [self.bgColors removeAllObjects];
    [self setBtnBackgroundColor:bgColor_nl forState:UIControlStateNormal];
    [self setBtnBackgroundColor:bgColor_hl forState:UIControlStateHighlighted];
    [self setBtnBackgroundColor:bgColor_dis forState:UIControlStateDisabled];
    [self setBtnBackgroundColor:bgColor_sl forState:UIControlStateSelected];
    
    [self.borderColors removeAllObjects];
    [self setBtnBorderColor:borderColor_nl forState:UIControlStateNormal];
    [self setBtnBorderColor:borderColor_hl forState:UIControlStateHighlighted];
    [self setBtnBorderColor:borderColor_dis forState:UIControlStateDisabled];
    [self setBtnBorderColor:borderColor_sl forState:UIControlStateSelected];
    
    [self setTitleColor:textColor_nl forState:UIControlStateNormal];
    [self setTitleColor:textColor_hl forState:UIControlStateHighlighted];
    [self setTitleColor:textColor_dis forState:UIControlStateDisabled];
    if (textColor_sl) {
        [self setTitleColor:textColor_sl forState:UIControlStateSelected];
    }

#else
    UIColor *textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
    UIColor *textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
    UIColor *textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
    UIColor *textColor_sl = nil;
    
    UIColor *bgColor_nl, *bgColor_hl, *bgColor_dis, *bgColor_sl = nil;
    BOOL isRound = NO;// 是否圆角
    CGFloat cornerRadius = 0; // 指定圆角弧度 默认是self.frame.size.height/2.0f
    CGFloat borderWidth = 0;
    UIColor *borderColor_nl, *borderColor_hl, *borderColor_dis, *borderColor_sl = nil;
    
    switch (btnType) {
        case BtnType1:
            bgColor_nl = PPUIColor.bgA0BlueColor;
            bgColor_hl = PPUIColor.bg81BlueColor;
            bgColor_dis = PPUIColor.bgA0BlueColor;
            
            textColor_nl = PPUIColor.bg28BlackColor;
            textColor_hl = PPUIColor.bg28BlackColor;
            textColor_dis = [UIColor colorWithRed:40.0/255.0 green:33.0/255.0 blue:33.0/255.0 alpha:0.3];
    
            break;
            
        case BtnType2:
            bgColor_nl = PPUIColor.bg28BlackColor;
            bgColor_hl = [UIColor colorWithRed:27.0/255.0 green:22.0/255.0 blue:22.0/255.0 alpha:1];
            bgColor_dis = PPUIColor.bg28BlackColor;
            
            textColor_nl = [UIColor whiteColor];
            textColor_hl = PPUIColor.textNormalBlackAlpha055Color;
            textColor_dis = PPUIColor.textNormalBlackAlpha08Color;
            
            break;
            
        case BtnType3:
            bgColor_nl = PPUIColor.bgF1GrayColor;
            bgColor_hl = PPUIColor.bgEAGrayColor;
            bgColor_dis = PPUIColor.bgF1GrayColor;
            bgColor_sl = PPUIColor.bgA0BlueColor;
            
            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = PPUIColor.bg28BlackColor;
            
            break;
            
        case BtnType4:
            
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = [UIColor clearColor];
            bgColor_sl = [UIColor clearColor];

            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_hl = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_dis = PPUIColor.bgF1GrayColor;
            borderColor_sl = PPUIColor.textNormalBlackAlpha08Color;

            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = PPUIColor.textNormalBlackAlpha08Color;
            
            break;
            
        case BtnType5:
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = [UIColor clearColor];
            bgColor_sl = PPUIColor.bg28BlackColor;

            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            borderColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            borderColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_sl = PPUIColor.bg28BlackColor;
            
            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = [UIColor whiteColor];
            
            break;
            
        case BtnType6:
            bgColor_nl = PPUIColor.bgFFRedColor;
            bgColor_hl = [UIColor colorWithRed:2160/255.0 green:53.0/255.0 blue:69.0/255.0 alpha:1];
            bgColor_dis = PPUIColor.bgFFRedColor;
            
            textColor_nl = [UIColor whiteColor];
            textColor_hl = [UIColor whiteColor];
            textColor_dis = [UIColor colorWithRed:255/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.2];
            
            break;
            
        case BtnType7:
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = [UIColor colorWithRed:255/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:0.2];
            bgColor_dis = [UIColor clearColor];

            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.bgA0BlueColor;
            borderColor_hl = PPUIColor.bgA0BlueColor;
            borderColor_dis = [UIColor colorWithRed:255/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:0.2];
            
            textColor_nl = PPUIColor.bgA0BlueColor;
            textColor_hl = PPUIColor.bgA0BlueColor;
            textColor_dis = [UIColor colorWithRed:255/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:0.2];
            
            break;
            
        case BtnType8:
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = [UIColor colorWithRed:255/255.0 green:68.0/255.0 blue:86.0/255.0 alpha:0.1];
            bgColor_dis = [UIColor clearColor];

            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.bgFFRedColor;
            borderColor_hl = PPUIColor.bgFFRedColor;
            borderColor_dis = [UIColor colorWithRed:255/255.0 green:68.0/255.0 blue:86.0/255.0 alpha:0.4];
            
            textColor_nl = PPUIColor.bgFFRedColor;
            textColor_hl = PPUIColor.bgFFRedColor;
            textColor_dis = [UIColor colorWithRed:255/255.0 green:68.0/255.0 blue:86.0/255.0 alpha:0.4];;
            
            break;
            
        case BtnType9:
            bgColor_nl = PPUIColor.bg28BlackColor;
            bgColor_hl = [UIColor colorWithRed:27.0/255.0 green:22.0/255.0 blue:22.0/255.0 alpha:1];
            bgColor_dis = PPUIColor.bg28BlackColor;
            
            textColor_nl = PPUIColor.bgA0BlueColor;
            textColor_hl = [UIColor colorWithRed:228.0/255.0 green:191.0/255.0 blue:88.0/255.0 alpha:0.6];
            textColor_dis = [UIColor colorWithRed:255.0/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:0.3];
            
            break;
        case BtnType10:
            isRound = YES;
            
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = [UIColor clearColor];
            bgColor_sl = PPUIColor.bg28BlackColor;

            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            borderColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            borderColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_sl = PPUIColor.bg28BlackColor;

            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = [UIColor whiteColor];
            break;
            
        case BtnType11:
            isRound = YES;
            
            bgColor_nl = PPUIColor.bgF1GrayColor;
            bgColor_hl = PPUIColor.bgEAGrayColor;
            bgColor_dis = PPUIColor.bgF1GrayColor;
            bgColor_sl = PPUIColor.bgA0BlueColor;
            
            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = PPUIColor.bg28BlackColor;

            break;
        case BtnType12:
            isRound = YES;

            bgColor_nl = PPUIColor.bgA0BlueColor;
            bgColor_hl = PPUIColor.bg81BlueColor;
            bgColor_dis = PPUIColor.bgA0BlueColor;
            bgColor_sl = [UIColor clearColor];
            
            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.bgA0BlueColor;
            borderColor_hl = PPUIColor.bg81BlueColor;
            borderColor_dis = PPUIColor.bgA0BlueColor;
            borderColor_sl = PPUIColor.textVisualBlackAlpha017Color;
            
            textColor_nl = PPUIColor.bg28BlackColor;
            textColor_hl = PPUIColor.bg28BlackColor;
            textColor_dis = [UIColor colorWithWhite:1 alpha:0.3];
            textColor_sl = PPUIColor.textNormalBlackAlpha08Color;

            break;
            
         case BtnType13:
            isRound = YES;
            
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = [UIColor clearColor];
            bgColor_sl = [UIColor clearColor];

            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_hl = PPUIColor.textVisualBlackAlpha017Color;
            borderColor_dis = PPUIColor.bgF1GrayColor;
            borderColor_sl = PPUIColor.textNormalBlackAlpha08Color;
            
            textColor_nl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha08Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = PPUIColor.textNormalBlackAlpha08Color;
            
            break;
        
        case BtnType14:
            isRound = YES;
            cornerRadius = 4.0f;
            bgColor_nl = PPUIColor.bgA0BlueColor;
            bgColor_hl = PPUIColor.bg81BlueColor;
            bgColor_dis = PPUIColor.bgEAGrayColor;
            
            
            
            textColor_nl = PPUIColor.bg28BlackColor;
            textColor_hl = PPUIColor.bg28BlackColor;
            textColor_dis = PPUIColor.textWeakenBlackAlpha036Color;
            textColor_sl = PPUIColor.bg28BlackColor;

            break;
        case BtnType15:
            isRound = YES;

            bgColor_nl = PPUIColor.bg28BlackColor;
            bgColor_hl = [UIColor colorWithRed:27.0/255.0 green:22.0/255.0 blue:22.0/255.0 alpha:1];
            bgColor_dis = PPUIColor.bg28BlackColor;
            
            textColor_nl = PPUIColor.bgA0BlueColor;
            textColor_hl = [UIColor colorWithRed:228.0/255.0 green:191.0/255.0 blue:88.0/255.0 alpha:0.6];
            textColor_dis = [UIColor colorWithRed:255.0/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:0.3];
            
            break;
        case BtnType16:
            isRound = YES;
            
            bgColor_nl = PPUIColor.bgFFRedColor;
            bgColor_hl = [UIColor colorWithRed:216/255.0 green:53.0/255.0 blue:69.0/255.0 alpha:1];
            bgColor_dis = PPUIColor.bgFFRedColor;
            
            textColor_nl = [UIColor whiteColor];
            textColor_hl = [UIColor whiteColor];
            textColor_dis = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
            
            break;
            
        case BtnType17:
            isRound = YES;
            
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = PPUIColor.bgEAGrayColor;
            bgColor_sl = PPUIColor.bgF6GrayColor;
            
            borderWidth = 1.0f;
            borderColor_nl = PPUIColor.bgEAGrayColor;
            borderColor_hl = PPUIColor.bgF6GrayColor;
            borderColor_dis = PPUIColor.bgEAGrayColor;
            borderColor_sl = PPUIColor.bgEAGrayColor;
            
            textColor_nl = PPUIColor.textNormalBlackAlpha055Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha055Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            textColor_sl = PPUIColor.textNormalBlackAlpha055Color;
            break;
            
        case BtnType18:
            isRound = YES;
            
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_dis = [UIColor clearColor];
            
            textColor_nl = PPUIColor.textNormalBlackAlpha055Color;
            textColor_hl = PPUIColor.textNormalBlackAlpha055Color;
            textColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            
            borderWidth = 0.5f;
            borderColor_nl = PPUIColor.bgEAGrayColor;
            borderColor_hl = PPUIColor.bgEAGrayColor;
            borderColor_dis = PPUIColor.bgEAGrayColor;
            
            break;
            
        case BtnType21:
            isRound = YES;
            
            bgColor_nl = PPUIColor.bgA0BlueColor;
            bgColor_hl = PPUIColor.bg81BlueColor;
            bgColor_dis = PPUIColor.textVisualBlackAlpha017Color;
            
            textColor_nl = PPUIColor.bg28BlackColor;
            textColor_hl = PPUIColor.bg28BlackColor;
            textColor_dis = [UIColor whiteColor];

            break;
        case BtnType22:
            isRound = YES;
            
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = [UIColor colorWithRed:255/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:0.19];
            bgColor_dis = [UIColor clearColor];
            
            borderWidth = 0.5f;
            borderColor_nl = PPUIColor.bg81BlueColor;
            borderColor_hl = PPUIColor.bg81BlueColor;
            borderColor_dis = [UIColor colorWithRed:228/255.0 green:191.0/255.0 blue:88.0/255.0 alpha:0.5];
            
            textColor_nl = PPUIColor.bg81BlueColor;
            textColor_hl = PPUIColor.bg81BlueColor;
            textColor_dis = [UIColor colorWithRed:228/255.0 green:191.0/255.0 blue:88.0/255.0 alpha:0.5];
            
            break;

        case BtnType23:
            isRound = YES;
            
            textColor_nl = PPUIColor.textNormalBlackAlpha055Color;
            bgColor_nl = [UIColor clearColor];
            bgColor_hl = PPUIColor.bgF6GrayColor;
            bgColor_sl = [UIColor clearColor];
            bgColor_dis = [UIColor clearColor];
            
            borderWidth = 0.5f;
            borderColor_nl = PPUIColor.bgEAGrayColor;
            borderColor_sl = PPUIColor.bgEAGrayColor;
            borderColor_hl = PPUIColor.bgEAGrayColor;
            borderColor_dis = PPUIColor.bgEAGrayColor;
        default:
            
            break;
    }
    
    if (isRound) {
        if (cornerRadius > 0) {
            self.layer.cornerRadius = cornerRadius;
        }else {
            self.layer.cornerRadius = self.frame.size.height /2.0f;
        }
        self.layer.masksToBounds = YES;
    }else {
        self.layer.cornerRadius = 0;
    }
    
    if (borderWidth > 0) {
        self.layer.borderWidth = borderWidth;
    }else {
        self.layer.borderWidth = 0;
    }
    
    [self.bgColors removeAllObjects];
    [self setBtnBackgroundColor:bgColor_nl forState:UIControlStateNormal];
    [self setBtnBackgroundColor:bgColor_hl forState:UIControlStateHighlighted];
    [self setBtnBackgroundColor:bgColor_dis forState:UIControlStateDisabled];
    [self setBtnBackgroundColor:bgColor_sl forState:UIControlStateSelected];
    
    [self.borderColors removeAllObjects];
    [self setBtnBorderColor:borderColor_nl forState:UIControlStateNormal];
    [self setBtnBorderColor:borderColor_hl forState:UIControlStateHighlighted];
    [self setBtnBorderColor:borderColor_dis forState:UIControlStateDisabled];
    [self setBtnBorderColor:borderColor_sl forState:UIControlStateSelected];
    
    [self setTitleColor:textColor_nl forState:UIControlStateNormal];
    [self setTitleColor:textColor_hl forState:UIControlStateHighlighted];
    [self setTitleColor:textColor_dis forState:UIControlStateDisabled];
    if (textColor_sl) {
        [self setTitleColor:textColor_sl forState:UIControlStateSelected];
    }
#endif
}
- (void)updateAppearanceWhenStateDidChange {
    if (self.bgColors.allKeys.count > 0) {
        UIColor *backgroundColor = [self.bgColors objectForKey:@(self.state)];
       
        if (backgroundColor == nil) {
            backgroundColor = [self.bgColors objectForKey:@(UIControlStateNormal)];
        }
        
        if (backgroundColor) {
            self.backgroundColor = backgroundColor;
        }
    }
    if (self.borderColors.allKeys.count > 0) {
        UIColor *borderColor = [self.borderColors objectForKey:@(self.state)];
        
        if (borderColor == nil) {
            borderColor = [UIColor clearColor];
        }
        
        if (borderColor) {
            self.layer.borderColor = borderColor.CGColor;
        }
    }
}




/**
 setBtnSize,只设置字体大小&高度

 @param btnSize
 */
//- (void)setBtnSize:(BtnSize)btnSize {
//    switch (btnSize) {
//        case BtnSize1:
//            self.titleLabel.font = [UIFont systemFontOfSize:17];
//            self.frame.size.height = 49;
//            break;
//
//        case BtnSize2:
//            self.titleLabel.font = [UIFont systemFontOfSize:14];
//            self.frame.size.height = 36;
//            break;
//
//        case BtnSize3:
//            self.titleLabel.font = [UIFont systemFontOfSize:11];
//            self.frame.size.height = 27;
//            break;
//
//        default:
//            break;
//    }
//}




@end
