//
//  NSString+HB.h
//  iOS-Category
//
//  Created by zxwo0o on 2017/5/17.
//  Copyright © 2017年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//#import <CocoaLumberjack/CocoaLumberjack.h>

//static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

typedef NS_ENUM(int, HBNumberTruncType) {
    HBNumberTruncType_Round = 0, // 四舍五入
    HBNumberTruncType_Ceil = 1,  // 向上取整
    HBNumberTruncType_Floor = 2, // 向下取整
};

/**
 截取浮点小数
 
 @param value 浮点型
 @param type 截取类型
 @param decimals 保留几位小数
 @return 截取后的值
 */
static inline CGFloat hb_truncFloat(CGFloat value, HBNumberTruncType type, int decimals) {
    if (value == 0) {
        return value;
    }
    CGFloat result = value;
    int unit = 1;
    if (decimals == 1) {
        unit = 10;
    } else if (decimals == 2) {
        unit = 100;
    } else if (decimals == 3) {
        unit = 1000;
    }
    switch (type) {
        case HBNumberTruncType_Round:
            result = round(value * unit) / unit;
            break;
        case HBNumberTruncType_Ceil:
            result = ceil(value * unit) / unit;
            break;
        case HBNumberTruncType_Floor:
            result = floor(value * unit) / unit;
            break;
        default:
            break;
    }

    return result;
}

@interface NSString (XHB)

@property (copy, nonatomic, readonly) NSString *HBLocalizable;

/// 把当前文本的第一个字符改为大写，其他的字符保持不变，例如 backgroundView.qmui_capitalizedString -> BackgroundView（系统的 capitalizedString 会变成 Backgroundview）
@property (readonly, copy) NSString *hb_capitalizedString;

+ (BOOL)isEmpty:(NSString *)str;
//是否手机号
+ (BOOL)isMobileNum:(NSString *)num;
// 是否 iP
+ (BOOL)isValidIP:(NSString *)ipStr;
//Email
+ (BOOL)isEmail:(NSString *)email;
//判断全汉字
+ (BOOL)stringIsAllChinese:(NSString *)inputString;

//判断全数字
+ (BOOL)stringIsAllNumber:(NSString *)inputString;

///
+ (NSString *)stringWithInteger:(NSInteger)value;

+ (NSString *)stringWithLong:(long)value;

+ (NSString *)stringWithLongLong:(int64_t)value;

+ (NSString *)stringWithFloat:(float)value;

+ (NSString *)stringWithDouble:(double)value;

- (NSString *)md5Hash;

+ (NSString *)getMD5WithData:(NSData *)data;

+ (NSString *)getFileMD5WithPath:(NSString *)path;

- (NSString *)sha1Hash;

- (NSString *)urlEncode;

- (NSString *)urlDecode;

- (NSDictionary *)toDictionary;

- (NSMutableDictionary *)toMutableDictionary;

// 将 new_count 格式转换 为 newCount oc编码风格
- (NSString *)transformString;

+ (NSString *)encodeBase64String:(NSString *)input;

+ (NSString *)decodeBase64String:(NSString *)input;

+ (NSString *)encodeBase64Data:(NSData *)data;

+ (NSString *)decodeBase64Data:(NSData *)data;

+ (NSString *)subString:(NSString *)str length:(NSInteger)charIndex trail:(BOOL)trail unitCharCount:(int)unitCharCount;

/*
 *获取指定个数的中文字符串,length是字符长度
 */
+ (NSString *)subString:(NSString *)str length:(NSInteger)charIndex trail:(BOOL)trail;

/*
 *获取指定个数的中文字符串,length是字符长度（至少会有length个字符）
 */
+ (NSString *)subString:(NSString *)str minimumLength:(NSInteger)charIndex trail:(BOOL)trail;

/*
 *获取指定个数的字符串,length是字符长度,中文当1个
 */
+ (NSString *)subStringOnlyChar:(NSString *)str length:(NSInteger)charIndex trail:(BOOL)trail;

/*
 *获取指定个数的字符串,length是字符长度,中文当1个（至少会有length个字符）
 */
+ (NSString *)subStringOnlyChar:(NSString *)str minimumLength:(NSInteger)charIndex trail:(BOOL)trail;

+ (int)charCountOfString:(NSString *)content unitCharCount:(int)unitCharCount;

/**
 去除html标签
 */
+ (NSString *)removeHTML:(NSString *)html;

/**
 去除空格
 */
+ (NSString *)trimWhitespace:(NSString *)str;

/**
 去除非法字符
 */
+ (NSString *)trimIllegal:(NSString *)str;

/**
 去除标点符号
 */
+ (NSString *)trimPunch:(NSString *)str;

/**
 通过key从字典中获取字符
 */
+ (NSString *)getString:(NSDictionary *)dict key:(NSString *)key;

/**
 通过key从字典中获取字符
 由外部保证key不为空，不再判断![NSString isEmpty:key]，适用于接口字段解析(eg key为固定字符串)
 当数据量较大时![NSString isEmpty:key]可能存在性能卡顿问题，在很多接口解析场景中，key为写死的固定字段，已无需判断
 */
+ (NSString *)getString:(NSDictionary *)dict withNonNullKey:(NSString *)key;

//获得一个类的类名  NSStringFromClass 系统有方法
//+ (NSString *)className:(Class)aClass;

+ (BOOL)isNickLegal:(NSString *)str;

+ (NSString *)cleanNewline:(NSString *)str;

//将整数秒格式转成 mm:ss格式
+ (NSString *)mmssStringWithLeftTime:(int)leftTime;

- (CGSize)hb_sizeWithFont:(UIFont *)font;

- (CGSize)hb_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

- (CGSize)hb_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize)hb_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size withContentInsets:(UIEdgeInsets)contentInsets;

- (CGSize)hb_sizeWithAttributes:(NSMutableDictionary *)attributes constrainedToSize:(CGSize)size withContentInsets:(UIEdgeInsets)contentInsets;

// 返回以.W为单位的字符串 小数点后一位 如1.1W
+ (NSString *)wanStringWithLong:(long)value;

// 返回以.W为单位的字符串
+ (NSString *)wanStringWithLong:(long)value truncType:(HBNumberTruncType)type decimals:(int)decimals;

// 获取字符串中的所有数字
+ (NSString *)getNumberFromStr:(NSString *)str;

// 寻找字符串中 包含subStr 的所有range
- (NSArray<NSValue *> *)getAllRangesOfSubString:(NSString *)subStr;

//密码加密
+ (NSString *)encrypt:(NSString *)psw;

/**
 * url 拼装 host 方便如 配配 有单独域名
 */
+ (NSString *)appendWithHost:(NSString *)host urlPath:(NSString *)urlPath;

//获得含中英文混合字符串的长度
+ (NSInteger)getLength:(NSString *)complexString;
/** float保留两位小数*/
+ (NSString *)getStringTwoDecimal:(NSDictionary *)dict key:(NSString *)key;

+ (BOOL)isStringWithAnyText:(id)object;

+ (NSString *)updateLeftTime:(int)leftTime;

+ (NSString *)replaceNewlineAndBreak:(NSString *)str;

+ (NSString *)encodeNewLineAndBreak:(NSString *)str;
//城市名称，删除“市”
+ (NSString *)deleteCityNameSomeStr:(NSString *)str;

+ (NSString *)deleteProvinceName:(NSString *)str;

+ (NSString *)getStringForNotNull:(NSString *)inparam;

+ (NSNumber *)getNumberFromString:(NSString *)string;

+ (NSString *)stringOfJsonFromDic:(NSDictionary *)dic;
//中文数字_ && 非纯数字 && 不包含“@”
+ (BOOL)isNickLegalForName:(NSString *)str;

//密码必须包含大小写字母和数字
+ (BOOL)isPassword:(NSString *)ps;

//// 返回以万为单位的字符串
+ (NSString *)tenThousandStringWithInteger:(NSInteger)value;

//// 返回以.万为单位的字符串 小数点后一位 如1.1万
+ (NSString *)wanChineseStringWithLong:(long)value;
//
+ (NSString *)thousandStringWithString:(NSString *)string;
//

//// json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData;
//
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//

// 数组转json格式字符串：
+ (NSString *)toJSONString:(NSArray *)arr;
//
///**
// 根据剩余秒数转换为分秒的形式 eg: 08:30
//
// @param leftTime 剩余秒数
// */
+ (NSString *)minuteAndSecondStringWithLeftTime:(int)leftTime;

//统一处理距离显示
+ (NSString *)dealWithPosition:(NSString *)positionStr;

//去除字符后面为0
+ (NSString *)removeFloatAllZeroByString:(NSString *)floatStr;

/**
*  正则表达式简单说明
*  语法：
.       匹配除换行符以外的任意字符
\w      匹配字母或数字或下划线或汉字
\s      匹配任意的空白符
\d      匹配数字
\b      匹配单词的开始或结束
^       匹配字符串的开始
$       匹配字符串的结束
*       重复零次或更多次
+       重复一次或更多次
?       重复零次或一次
{n}     重复n次
{n,}     重复n次或更多次
{n,m}     重复n到m次
\W      匹配任意不是字母，数字，下划线，汉字的字符
\S      匹配任意不是空白符的字符
\D      匹配任意非数字的字符
\B      匹配不是单词开头或结束的位置
[^x]     匹配除了x以外的任意字符
[^aeiou]匹配除了aeiou这几个字母以外的任意字符
*?      重复任意次，但尽可能少重复
+?      重复1次或更多次，但尽可能少重复
??      重复0次或1次，但尽可能少重复
{n,m}?     重复n到m次，但尽可能少重复
{n,}?     重复n次以上，但尽可能少重复
\a      报警字符(打印它的效果是电脑嘀一声)
\b      通常是单词分界位置，但如果在字符类里使用代表退格
\t      制表符，Tab
\r      回车
\v      竖向制表符
\f      换页符
\n      换行符
\e      Escape
\0nn     ASCII代码中八进制代码为nn的字符
\xnn     ASCII代码中十六进制代码为nn的字符
\unnnn     Unicode代码中十六进制代码为nnnn的字符
\cN     ASCII控制字符。比如\cC代表Ctrl+C
\A      字符串开头(类似^，但不受处理多行选项的影响)
\Z      字符串结尾或行尾(不受处理多行选项的影响)
\z      字符串结尾(类似$，但不受处理多行选项的影响)
\G      当前搜索的开头
\p{name}     Unicode中命名为name的字符类，例如\p{IsGreek}
(?>exp)     贪婪子表达式
(?<x>-<y>exp)     平衡组
(?im-nsx:exp)     在子表达式exp中改变处理选项
(?im-nsx)       为表达式后面的部分改变处理选项
(?(exp)yes|no)     把exp当作零宽正向先行断言，如果在这个位置能匹配，使用yes作为此组的表达式；否则使用no
(?(exp)yes)     同上，只是使用空表达式作为no
(?(name)yes|no) 如果命名为name的组捕获到了内容，使用yes作为表达式；否则使用no
(?(name)yes)     同上，只是使用空表达式作为no

捕获
(exp)               匹配exp,并捕获文本到自动命名的组里
(?<name>exp)        匹配exp,并捕获文本到名称为name的组里，也可以写成(?'name'exp)
(?:exp)             匹配exp,不捕获匹配的文本，也不给此分组分配组号
零宽断言
(?=exp)             匹配exp前面的位置
(?<=exp)            匹配exp后面的位置
(?!exp)             匹配后面跟的不是exp的位置
(?<!exp)            匹配前面不是exp的位置
注释
(?#comment)         这种类型的分组不对正则表达式的处理产生任何影响，用于提供注释让人阅读

*  表达式：\(?0\d{2}[) -]?\d{8}
*  这个表达式可以匹配几种格式的电话号码，像(010)88886666，或022-22334455，或02912345678等。
*  我们对它进行一些分析吧：
*  首先是一个转义字符\(,它能出现0次或1次(?),然后是一个0，后面跟着2个数字(\d{2})，然后是)或-或空格中的一个，它出现1次或不出现(?)，
*  最后是8个数字(\d{8})
*/

@end
