//
//  HBUIStyle.h
//  TaQu
//
//  Created by QDFish on 2016/10/10.
//  Copyright © 2016年 厦门海豹信息技术. All rights reserved.
//

#ifndef HBUIStyle_h
#define HBUIStyle_h

#ifdef PEIPEI
#define COLOR_C1 HB_RGBCOLOR(160, 97, 239)//主题
#define COLOR_C2 HB_RGBCOLOR(129, 27, 255)//主题
#else
//颜色
#define COLOR_C1 HB_RGBCOLOR(255, 211, 33)  //yellow
#define COLOR_C2 HB_RGBCOLOR(228, 191, 88)

#endif

#define COLOR_C3 HB_RGBCOLOR(40, 33, 33)
#define COLOR_C4 HB_RGBCOLOR(255, 68, 86)  //red
// add color by : 2020-09-26
#define COLOR_C5 HB_RGBCOLOR(255,211,34)  //yellow
#define COLOR_C6 HB_RGBCOLOR(0,106,254) //blue

#define COLOR_G1 HB_RGBACOLOR(0, 0, 0,0.80)
#define COLOR_G2 HB_RGBACOLOR(0, 0, 0,0.55)
#define COLOR_G3 HB_RGBACOLOR(0, 0, 0,0.36)
#define COLOR_G4 HB_RGBACOLOR(0, 0, 0,0.17)
#define COLOR_G5 HB_RGBCOLOR(234, 234, 234)
#define COLOR_G6 HB_RGBCOLOR(241, 241, 241)
#define COLOR_G7 HB_RGBCOLOR(246, 246, 246)
// add color by : 2020-09-26
#define COLOR_G8 HB_RGBACOLOR(0, 0, 0,0.08)
#define COLOR_G9 HB_RGBACOLOR(0, 0, 0,0.05)
#define COLOR_G10 HB_RGBACOLOR(0, 0, 0,0.04)

#define COLOR_W0 HB_RGBACOLOR(255, 255, 255,1)
#define COLOR_W1 HB_RGBACOLOR(255, 255, 255,0.90)
#define COLOR_W2 HB_RGBACOLOR(255, 255, 255,0.80)
#define COLOR_W3 HB_RGBACOLOR(255, 255, 255,0.70)
#define COLOR_W4 HB_RGBACOLOR(255, 255, 255,0.60)
#define COLOR_W5 HB_RGBACOLOR(255, 255, 255,0.50)
#define COLOR_W6 HB_RGBACOLOR(255, 255, 255,0.40)
#define COLOR_W7 HB_RGBACOLOR(255, 255, 255,0.30)
#define COLOR_W8 HB_RGBACOLOR(255, 255, 255,0.20)
#define COLOR_W9 HB_RGBACOLOR(255, 255, 255,0.10)

#define COLOR_BG HB_RGBCOLOR(246, 246, 246)
#define COLOR_PRESS HB_RGBCOLOR(241, 241, 241)

#define COLOR_L1 HB_RGBCOLOR(211, 210, 210) //线条颜色
#define COLOR_L2 HB_RGBCOLOR(241, 241, 241) //线条颜色

#define LINE_HEIGHT 1  //线条高度

//新
//浅色背景下使用
#define COLOR_C1L HB_RGBACOLOR(252, 238, 79, 1)
#define COLOR_C2L HB_RGBACOLOR(255, 53, 92, 1)
#define COLOR_C3L HB_RGBACOLOR(7, 194, 105, 1)
#define COLOR_C4L HB_RGBACOLOR(252, 154, 63, 1)
#define COLOR_C5L HB_RGBACOLOR(73, 155, 248, 1)

//深色背景下使用
#define COLOR_C1D HB_RGBACOLOR(252, 238, 77, 1)
#define COLOR_C2D HB_RGBACOLOR(255, 72, 116, 1)
#define COLOR_C3D HB_RGBACOLOR(16, 227, 126, 1)
#define COLOR_C4D HB_RGBACOLOR(255, 162, 77, 1)
#define COLOR_C5D HB_RGBACOLOR(41, 178, 255, 1)

//黑白
#define COLOR_B100 HB_RGBACOLOR(0, 0, 0, 1)
#define COLOR_B90 HB_RGBACOLOR(0, 0, 0, 0.9)
#define COLOR_B80 HB_RGBACOLOR(0, 0, 0, 0.8)
#define COLOR_B70 HB_RGBACOLOR(0, 0, 0, 0.7)
#define COLOR_B60 HB_RGBACOLOR(0, 0, 0, 0.6)
#define COLOR_B50 HB_RGBACOLOR(0, 0, 0, 0.5)
#define COLOR_B40 HB_RGBACOLOR(0, 0, 0, 0.4)
#define COLOR_B30 HB_RGBACOLOR(0, 0, 0, 0.3)
#define COLOR_B20 HB_RGBACOLOR(0, 0, 0, 0.2)
#define COLOR_B10 HB_RGBACOLOR(0, 0, 0, 0.1)
#define COLOR_B05 HB_RGBACOLOR(0, 0, 0, 0.05)

#define COLOR_W100 HB_RGBACOLOR(255, 255, 255, 1)
#define COLOR_W90 HB_RGBACOLOR(255, 255, 255, 0.9)
#define COLOR_W80 HB_RGBACOLOR(255, 255, 255, 0.8)
#define COLOR_W70 HB_RGBACOLOR(255, 255, 255, 0.7)
#define COLOR_W60 HB_RGBACOLOR(255, 255, 255, 0.6)
#define COLOR_W50 HB_RGBACOLOR(255, 255, 255, 0.5)
#define COLOR_W40 HB_RGBACOLOR(255, 255, 255, 0.4)
#define COLOR_W30 HB_RGBACOLOR(255, 255, 255, 0.3)
#define COLOR_W20 HB_RGBACOLOR(255, 255, 255, 0.2)
#define COLOR_W10 HB_RGBACOLOR(255, 255, 255, 0.1)
#define COLOR_W05 HB_RGBACOLOR(255, 255, 255, 0.05)

// add FONT T5_1 T5_2 T6_1 T6_2 by : 2020-09-26
//字体大小
#define FONT_T1 42
#define FONT_T2 32
#define FONT_T3 24
#define FONT_T4 19
#define FONT_T5 17
#define FONT_T5_1 16
#define FONT_T5_2 15
#define FONT_T6 14
#define FONT_T6_1 13
#define FONT_T6_2 12
#define FONT_T7 11
#define FONT_T8 9


//行距
#define LINE_SPACING1 6
#define LINE_SPACING2 10
#define LINE_SPACING3 8
#define LINE_SPACING4 3


#define CONTENT_XSTART 16 //view里内容两边留白宽度
#define CELL_PADDING_HEIGHT 10 //cell之间间隔高度


//colorUtil

#define COLOR_BLACK_1 HB_RGBCOLOR(88,  89,  87 )
#define COLOR_BLACK_2 HB_RGBCOLOR(229, 229, 229)
#define COLOR_BLACK_3 HB_RGBCOLOR(56,  60,  60 )
#define COLOR_BLACK_4 HB_RGBCOLOR(100, 100, 100)
#define COLOR_BLACK_5 HB_RGBCOLOR(115, 115, 115)
#define COLOR_BLACK_6 HB_RGBCOLOR(52,  52,  52)
#define COLOR_BLACK_7 HB_RGBCOLOR(92,  90,  89)
#define COLOR_GRAY_1  HB_RGBCOLOR(163, 163, 162)
#define COLOR_GRAY_2  HB_RGBCOLOR(243, 243, 242)
#define COLOR_GRAY_3  HB_RGBCOLOR(192, 198, 201)
#define COLOR_GRAY_4  HB_RGBCOLOR(229, 228, 230)
#define COLOR_GRAY_5  HB_RGBCOLOR(238, 238, 246)
#define COLOR_GRAY_6  HB_RGBCOLOR(180, 180, 180)
#define COLOR_GRAY_7  HB_RGBCOLOR(141, 141, 141)
#define COLOR_GRAY_8  HB_RGBCOLOR(240, 240, 240)
#define COLOR_GRAY_9  HB_RGBCOLOR(116, 117, 117)
#define COLOR_GRAY_10 HB_RGBCOLOR(211, 212, 213)
#define COLOR_WHITE_1  HB_RGBCOLOR(255, 255, 255)
#define COLOR_BLUE_1  HB_RGBCOLOR(0,   189, 211)
#define COLOR_BLUE_2  HB_RGBCOLOR(0,   121, 254)
#define COLOR_BLUE_3  HB_RGBCOLOR(0,   122, 255)
#define COLOR_PINK_1  HB_RGBCOLOR(231, 81 , 141)
#define COLOR_RED_1   HB_RGBCOLOR(250, 70 , 70 )
#define COLOR_RED_2   HB_RGBCOLOR(255, 87 , 81 )
#define COLOR_YELLOW_3 HB_RGBCOLOR(252, 192, 0 )
#define COLOR_ORANGE_1 HB_RGBCOLOR(255,156, 70 )
#define COLOR_ORANGE_2 HB_RGBCOLOR(255,192, 0 )
#define COLOR_GREEN_1 HB_RGBCOLOR(114, 202, 62 )
#define COLOR_PURPLE_1 HB_RGBCOLOR(115, 115, 115)//主文
#define COLOR_PURPLE_2 HB_RGBCOLOR(205, 113, 241)//紫色2
#define COLOR_SILVER_1 HB_RGBCOLOR(234, 237, 247)//银色1
#define COLOR_THIN_GRAY_1  HB_RGBACOLOR(243, 243, 242, 0.5)
#define COLOR_HIGHTLIGHT1 HB_RGBACOLOR(0, 0, 0, 0.07)
#define COLOR_HIGHTLIGHT2 HB_RGBACOLOR(0, 0, 0, 0.07)

/*
 * 新版
 */

#define COLOR_GRAY_BG    HB_RGBCOLOR(234, 234, 234) //view灰色背景
#define COLOR_NAVBAR_BG  HB_RGBCOLOR(246, 246, 246) //顶部导航栏背景底色 二级页面
#define COLOR_IMAGE_GAY_BG HB_RGBCOLOR(241, 241, 241)  //没图片的默认灰色背景

#define COLOR_YELLOW_1 HB_RGBCOLOR(255, 224, 78) //黄色 主色
#define COLOR_YELLOW_2 HB_RGBCOLOR(255, 220, 40) //黄色 辅助色

#define COLOR_BROWN_1  HB_RGBCOLOR(243, 152, 0) //褐色 主色

//文本颜色
#define COLOR_TEXT_1 HB_RGBCOLOR(53, 53, 53)  //主文
#define COLOR_TEXT_1_UP HB_RGBACOLOR(53, 53, 53, 0.5)  //主文
#define COLOR_TEXT_2 HB_RGBCOLOR(115, 115, 115) //副文
#define COLOR_TEXT_3 HB_RGBCOLOR(163, 163, 163) //提示文案
#define COLOR_TEXT_4 HB_RGBCOLOR(210, 211, 212) //弱化文案
#define COLOR_TEXT_5 HB_RGBCOLOR(184, 184, 184) //弱化文案（空页面提醒）
#define COLOR_TEXT_RED HB_RGBCOLOR(250, 70, 70)  //价格，备注
#define COLOR_TEXT_WHITE HB_RGBCOLOR(255, 255, 255)  //纯白色

#define COLOR_TEXT_88 HB_RGBCOLOR(88, 88, 88) //88 文本

#define COLOR_LINE_1 HB_RGBCOLOR(241, 241, 241) //一般分隔
#define COLOR_LINE_2 HB_RGBCOLOR(213, 213, 213) //顶部、底部导航
#define COLOR_LINE_3 HB_RGBCOLOR(215, 215, 215) //特殊情况



//#define HB_Font(font) [UIFont systemFontOfSize:font]
//#define HB_Font_B(font) [UIFont boldSystemFontOfSize:font]
//
//#define HBLabelInit0(type, name, bold, font, color) \
//        type name = [UILabel new]; \
//        name.textColor = color; \
//        name.font = HBFont##_bold(font); \
//
//#define HBLabelInit1(type, name, bold, font, color, superView) \
//        HBLabelInit0(type, name, bold, font, color); \
//        [superView addSubview:name]

//配配
#define FONT_P1  35
#define FONT_P2  23
#define FONT_P3  18
#define FONT_P4  17
#define FONT_P5  16
#define FONT_P6  15
#define FONT_P7  14
#define FONT_P8  13
#define FONT_P9  12
#define FONT_P10 11
#define FONT_P11 10
#define FONT_P12 9

#define COLOR_B    HB_RGBACOLOR(0 , 0, 0, 1)
#define COLOR_B_80 HB_RGBACOLOR(0 , 0, 0, 0.8)
#define COLOR_B_60 HB_RGBACOLOR(0 , 0, 0, 0.6)
#define COLOR_B_40 HB_RGBACOLOR(0 , 0, 0, 0.4)
#define COLOR_B_20 HB_RGBACOLOR(0 , 0, 0, 0.2)
#define COLOR_B_10 HB_RGBACOLOR(0 , 0, 0, 0.1)
#define COLOR_B_4  HB_RGBACOLOR(0 , 0, 0, 0.04)

#define COLOR_W    HB_RGBACOLOR(255 , 255, 255, 1)
#define COLOR_W_80 HB_RGBACOLOR(255 , 255, 255, 0.8)
#define COLOR_W_60 HB_RGBACOLOR(255 , 255, 255, 0.6)
#define COLOR_W_40 HB_RGBACOLOR(255 , 255, 255, 0.4)
#define COLOR_W_20 HB_RGBACOLOR(255 , 255, 255, 0.2)

//配配社交按钮不可点击-特殊颜色
#define COLOR_YELLOW_DISABLE HB_RGBACOLOR(255, 255, 255, 0.6)

#define COLOR_S1   HB_RGBACOLOR(160 , 97, 239, 1)
#define COLOR_S2   HB_RGBACOLOR(129 , 27, 255, 1)
#define COLOR_S3   HB_RGBACOLOR(255 , 19, 60, 1)




#pragma mark ---
#pragma mark --- 新 UI

/*
 颜色
 */

#define TH_Gray001 HB_RGBACOLOR(255, 255, 255, 1)
#define TH_Gray100 HB_RGBACOLOR(250, 251, 253, 1)
#define TH_Gray150 HB_RGBACOLOR(245, 247, 250, 1)
#define TH_Gray200 HB_RGBACOLOR(237, 240, 245, 1)
#define TH_Gray250 HB_RGBACOLOR(192, 195, 201, 1)
#define TH_Gray300 HB_RGBACOLOR(216, 219, 223, 1)
#define TH_Gray350 HB_RGBACOLOR(193, 196, 201, 1)
#define TH_Gray400 HB_RGBACOLOR(177, 180, 186, 1)
#define TH_Gray500 HB_RGBACOLOR(141, 143, 148, 1)
#define TH_Gray600 HB_RGBACOLOR(112, 114, 119, 1)
#define TH_Gray650 HB_RGBACOLOR(90, 92, 97, 1)
#define TH_Gray700 HB_RGBACOLOR(78, 80, 85, 1)
#define TH_Gray750 HB_RGBACOLOR(57, 59, 63, 1)
#define TH_Gray770 HB_RGBACOLOR(50, 52, 56, 1)
#define TH_Gray800 HB_RGBACOLOR(39, 40, 42, 1)
#define TH_Gray850 HB_RGBACOLOR(29, 30, 31, 1)
#define TH_Gray900 HB_RGBACOLOR(24, 25, 26, 1)
#define TH_Gray990 HB_RGBACOLOR(0, 0, 0, 1)

#define TH_Gray001_Dark HB_RGBACOLOR(0, 0, 0, 1)
#define TH_Gray100_Dark HB_RGBACOLOR(28, 29, 31, 1)
#define TH_Gray150_Dark HB_RGBACOLOR(39, 40, 43, 1)
#define TH_Gray200_Dark HB_RGBACOLOR(43, 45, 48, 1)
#define TH_Gray250_Dark HB_RGBACOLOR(50, 52, 56, 1)
#define TH_Gray300_Dark HB_RGBACOLOR(59, 61, 66, 1)
#define TH_Gray350_Dark HB_RGBACOLOR(67, 69, 74, 1)
#define TH_Gray400_Dark HB_RGBACOLOR(90, 93, 99, 1)
#define TH_Gray500_Dark HB_RGBACOLOR(96, 99, 105, 1)
#define TH_Gray600_Dark HB_RGBACOLOR(125, 127, 133, 1)
#define TH_Gray650_Dark HB_RGBACOLOR(158, 160, 163, 1)
#define TH_Gray700_Dark HB_RGBACOLOR(171, 172, 176, 1)
#define TH_Gray750_Dark HB_RGBACOLOR(190, 192, 196, 1)
#define TH_Gray770_Dark HB_RGBACOLOR(198, 200, 204, 1)
#define TH_Gray800_Dark HB_RGBACOLOR(204, 206, 210, 1)
#define TH_Gray850_Dark HB_RGBACOLOR(210, 212, 216, 1)
#define TH_Gray900_Dark HB_RGBACOLOR(215, 218, 222, 1)
#define TH_Gray990_Dark HB_RGBACOLOR(223, 226, 232, 1)


#define TH_Black100 HB_RGBACOLOR(0, 0, 0, 1)
#define TH_Black95  HB_RGBACOLOR(0, 0, 0, 0.95)
#define TH_Black90  HB_RGBACOLOR(0, 0, 0, 0.90)
#define TH_Black85  HB_RGBACOLOR(0, 0, 0, 0.85)
#define TH_Black80  HB_RGBACOLOR(0, 0, 0, 0.80)
#define TH_Black75  HB_RGBACOLOR(0, 0, 0, 0.75)
#define TH_Black70  HB_RGBACOLOR(0, 0, 0, 0.70)
#define TH_Black65  HB_RGBACOLOR(0, 0, 0, 0.65)
#define TH_Black60  HB_RGBACOLOR(0, 0, 0, 0.60)
#define TH_Black55  HB_RGBACOLOR(0, 0, 0, 0.55)
#define TH_Black50  HB_RGBACOLOR(0, 0, 0, 0.50)
#define TH_Black45  HB_RGBACOLOR(0, 0, 0, 0.45)
#define TH_Black40  HB_RGBACOLOR(0, 0, 0, 0.40)
#define TH_Black35  HB_RGBACOLOR(0, 0, 0, 0.35)
#define TH_Black30  HB_RGBACOLOR(0, 0, 0, 0.30)
#define TH_Black25  HB_RGBACOLOR(0, 0, 0, 0.25)
#define TH_Black20  HB_RGBACOLOR(0, 0, 0, 0.20)
#define TH_Black15  HB_RGBACOLOR(0, 0, 0, 0.15)
#define TH_Black10  HB_RGBACOLOR(0, 0, 0, 0.10)
#define TH_Black5   HB_RGBACOLOR(0, 0, 0, 0.05)


#define TH_White100 HB_RGBACOLOR(255, 255, 255, 1)
#define TH_White95  HB_RGBACOLOR(255, 255, 255, 0.95)
#define TH_White90  HB_RGBACOLOR(255, 255, 255, 0.90)
#define TH_White85  HB_RGBACOLOR(255, 255, 255, 0.85)
#define TH_White80  HB_RGBACOLOR(255, 255, 255, 0.80)
#define TH_White75  HB_RGBACOLOR(255, 255, 255, 0.75)
#define TH_White70  HB_RGBACOLOR(255, 255, 255, 0.70)
#define TH_White65  HB_RGBACOLOR(255, 255, 255, 0.65)
#define TH_White60  HB_RGBACOLOR(255, 255, 255, 0.60)
#define TH_White55  HB_RGBACOLOR(255, 255, 255, 0.55)
#define TH_White50  HB_RGBACOLOR(255, 255, 255, 0.50)
#define TH_White45  HB_RGBACOLOR(255, 255, 255, 0.45)
#define TH_White40  HB_RGBACOLOR(255, 255, 255, 0.40)
#define TH_White35  HB_RGBACOLOR(255, 255, 255, 0.35)
#define TH_White30  HB_RGBACOLOR(255, 255, 255, 0.30)
#define TH_White25  HB_RGBACOLOR(255, 255, 255, 0.25)
#define TH_White20  HB_RGBACOLOR(255, 255, 255, 0.20)
#define TH_White15  HB_RGBACOLOR(255, 255, 255, 0.15)
#define TH_White10  HB_RGBACOLOR(255, 255, 255, 0.10)
#define TH_White5   HB_RGBACOLOR(255, 255, 255, 0.05)


#define TH_Yellow100 HB_RGBACOLOR(255, 252, 223, 1)
#define TH_Yellow200 HB_RGBACOLOR(255, 250, 216, 1)
#define TH_Yellow300 HB_RGBACOLOR(255, 243, 165, 1)
#define TH_Yellow400 HB_RGBACOLOR(255, 239, 138, 1)
#define TH_Yellow600 HB_RGBACOLOR(255, 234, 99, 1)
#define TH_Yellow800 HB_RGBACOLOR(255, 222, 51, 1)

#define TH_Yellow100_Dark HB_RGBACOLOR(69, 64, 22, 1)
#define TH_Yellow200_Dark HB_RGBACOLOR(88, 82, 30, 1)
#define TH_Yellow300_Dark HB_RGBACOLOR(116, 107, 38, 1)
#define TH_Yellow400_Dark HB_RGBACOLOR(153, 142, 50, 1)
#define TH_Yellow600_Dark HB_RGBACOLOR(191, 178, 62, 1)
#define TH_Yellow800_Dark HB_RGBACOLOR(238, 221, 77, 1)


#define TH_Cyan100 HB_RGBACOLOR(204, 246, 255, 1)
#define TH_Cyan200 HB_RGBACOLOR(153, 237, 255, 1)
#define TH_Cyan300 HB_RGBACOLOR(102, 227, 255, 1)
#define TH_Cyan400 HB_RGBACOLOR(51, 218, 255, 1)
#define TH_Cyan600 HB_RGBACOLOR(0, 209, 255, 1)
#define TH_Cyan800 HB_RGBACOLOR(0, 178, 217, 1)

#define TH_Cyan100_Dark HB_RGBACOLOR(50, 82, 89, 1)
#define TH_Cyan200_Dark HB_RGBACOLOR(63, 106, 115, 1)
#define TH_Cyan300_Dark HB_RGBACOLOR(85, 141, 153, 1)
#define TH_Cyan400_Dark HB_RGBACOLOR(106, 176, 191, 1)
#define TH_Cyan600_Dark HB_RGBACOLOR(141, 235, 255, 1)
#define TH_Cyan800_Dark HB_RGBACOLOR(78, 185, 208, 1)


#define TH_Green100 HB_RGBACOLOR(213, 250, 228, 1)
#define TH_Green200 HB_RGBACOLOR(170, 245, 200, 1)
#define TH_Green300 HB_RGBACOLOR(128, 241, 173, 1)
#define TH_Green400 HB_RGBACOLOR(85, 236, 145, 1)
#define TH_Green600 HB_RGBACOLOR(43, 231, 118, 1)
#define TH_Green800 HB_RGBACOLOR(37, 196, 100, 1)

#define TH_Green100_Dark HB_RGBACOLOR(39, 83, 56, 1)
#define TH_Green200_Dark HB_RGBACOLOR(49, 107, 72, 1)
#define TH_Green300_Dark HB_RGBACOLOR(66, 142, 96, 1)
#define TH_Green400_Dark HB_RGBACOLOR(83, 178, 120, 1)
#define TH_Green600_Dark HB_RGBACOLOR(110, 237, 160, 1)
#define TH_Green800_Dark HB_RGBACOLOR(55, 184, 130, 1)



#define TH_Orange100 HB_RGBACOLOR(255, 232, 214, 1)
#define TH_Orange200 HB_RGBACOLOR(255, 208, 173, 1)
#define TH_Orange300 HB_RGBACOLOR(255, 185, 133, 1)
#define TH_Orange400 HB_RGBACOLOR(255, 161, 92, 1)
#define TH_Orange600 HB_RGBACOLOR(255, 138, 51, 1)
#define TH_Orange800 HB_RGBACOLOR(241, 126, 41, 1)

#define TH_Orange100_Dark HB_RGBACOLOR(89, 56, 31, 1)
#define TH_Orange200_Dark HB_RGBACOLOR(115, 72, 41, 1)
#define TH_Orange300_Dark HB_RGBACOLOR(153, 96, 53, 1)
#define TH_Orange400_Dark HB_RGBACOLOR(191, 120, 67, 1)
#define TH_Orange600_Dark HB_RGBACOLOR(255, 160, 89, 1)
#define TH_Orange800_Dark HB_RGBACOLOR(220, 120, 45, 1)


#define TH_Blue100 HB_RGBACOLOR(220, 235, 255, 1)
#define TH_Blue200 HB_RGBACOLOR(185, 216, 255, 1)
#define TH_Blue300 HB_RGBACOLOR(151, 196, 254, 1)
#define TH_Blue400 HB_RGBACOLOR(116, 177, 254, 1)
#define TH_Blue600 HB_RGBACOLOR(81, 157, 254, 1)
#define TH_Blue800 HB_RGBACOLOR(69, 133, 216, 1)

#define TH_Blue100_Dark HB_RGBACOLOR(43, 61, 88, 1)
#define TH_Blue200_Dark HB_RGBACOLOR(54, 81, 115, 1)
#define TH_Blue300_Dark HB_RGBACOLOR(71, 107, 153, 1)
#define TH_Blue400_Dark HB_RGBACOLOR(89, 134, 191, 1)
#define TH_Blue600_Dark HB_RGBACOLOR(119, 179, 255, 1)
#define TH_Blue800_Dark HB_RGBACOLOR(77, 134, 204, 1)


#define TH_Pink100 HB_RGBACOLOR(255, 228, 239, 1)
#define TH_Pink200 HB_RGBACOLOR(255, 200, 223, 1)
#define TH_Pink300 HB_RGBACOLOR(255, 173, 208, 1)
#define TH_Pink400 HB_RGBACOLOR(255, 145, 192, 1)
#define TH_Pink600 HB_RGBACOLOR(255, 118, 176, 1)
#define TH_Pink800 HB_RGBACOLOR(217, 100, 150, 1)

#define TH_Pink100_Dark HB_RGBACOLOR(89, 56, 70, 1)
#define TH_Pink200_Dark HB_RGBACOLOR(115, 71, 90, 1)
#define TH_Pink300_Dark HB_RGBACOLOR(153, 95, 119, 1)
#define TH_Pink400_Dark HB_RGBACOLOR(191, 119, 149, 1)
#define TH_Pink600_Dark HB_RGBACOLOR(255, 158, 199, 1)
#define TH_Pink800_Dark HB_RGBACOLOR(211, 107, 152, 1)



#define TH_Red100 HB_RGBACOLOR(254, 215, 215, 1)
#define TH_Red200 HB_RGBACOLOR(253, 174, 174, 1)
#define TH_Red300 HB_RGBACOLOR(252, 134, 134, 1)
#define TH_Red400 HB_RGBACOLOR(251, 93, 93, 1)
#define TH_Red600 HB_RGBACOLOR(250, 53, 53, 1)
#define TH_Red800 HB_RGBACOLOR(213, 45, 45, 1)

#define TH_Red100_Dark HB_RGBACOLOR(89, 35, 35, 1)
#define TH_Red200_Dark HB_RGBACOLOR(116, 45, 45, 1)
#define TH_Red300_Dark HB_RGBACOLOR(153, 61, 61, 1)
#define TH_Red400_Dark HB_RGBACOLOR(191, 76, 76, 1)
#define TH_Red600_Dark HB_RGBACOLOR(255, 101, 101, 1)
#define TH_Red800_Dark HB_RGBACOLOR(235, 73, 73, 1)

#define TH_Purple100 HB_RGBACOLOR(240, 224, 255, 1)
#define TH_Purple200 HB_RGBACOLOR(224, 194, 255, 1)
#define TH_Purple300 HB_RGBACOLOR(209, 163, 255, 1)
#define TH_Purple400 HB_RGBACOLOR(193, 133, 255, 1)
#define TH_Purple600 HB_RGBACOLOR(178, 102, 255, 1)
#define TH_Purple800 HB_RGBACOLOR(151, 87, 217, 1)

#define TH_Purple100_Dark HB_RGBACOLOR(70, 52, 88, 1)
#define TH_Purple200_Dark HB_RGBACOLOR(90, 68, 115, 1)
#define TH_Purple300_Dark HB_RGBACOLOR(90, 68, 115, 1)
#define TH_Purple400_Dark HB_RGBACOLOR(152, 113, 191, 1)
#define TH_Purple600_Dark HB_RGBACOLOR(202, 150, 255, 1)
#define TH_Purple800_Dark HB_RGBACOLOR(150, 93, 209, 1)



#define TH_Navy001 HB_RGBACOLOR(255, 255, 255, 1)
#define TH_Navy002 HB_RGBACOLOR(255, 255, 255, 1)
#define TH_Navy003 HB_RGBACOLOR(229, 231, 237, 1)
#define TH_Navy100 HB_RGBACOLOR(245, 247, 250, 1)
#define TH_Navy110 HB_RGBACOLOR(239, 241, 249, 1)
#define TH_Navy200 HB_RGBACOLOR(249, 244, 244, 0.8)
#define TH_Navy210 HB_RGBACOLOR(255, 255, 255, 1)
#define TH_Navy990 HB_RGBACOLOR(0, 0, 0, 1)


#define TH_Navy001_Dark HB_RGBACOLOR(37, 37, 37, 1)
#define TH_Navy002_Dark HB_RGBACOLOR(48, 50, 56, 1)
#define TH_Navy003_Dark HB_RGBACOLOR(63, 63, 63, 1)
#define TH_Navy100_Dark HB_RGBACOLOR(56, 56, 56, 1)
#define TH_Navy110_Dark HB_RGBACOLOR(28, 28, 28, 1)
#define TH_Navy200_Dark HB_RGBACOLOR(56, 57, 59, 0.8)
#define TH_Navy210_Dark HB_RGBACOLOR(42, 42, 43, 1)
#define TH_Navy990_Dark HB_RGBACOLOR(255, 255, 255, 1)

#define TH_Magenta600 HB_RGBACOLOR(255, 32, 86, 1)

#define TH_Indigo600 HB_RGBACOLOR(79, 124, 176, 1)
#define TH_Indigo600_Dark HB_RGBACOLOR(113, 138, 167, 1)


/*
 字体
 */

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


#endif /* HBUIStyle_h */
