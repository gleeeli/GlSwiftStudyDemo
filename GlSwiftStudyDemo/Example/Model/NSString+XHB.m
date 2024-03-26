//
//  NSString+HB.m
//  iOS-Category
//
//  Created by zxwo0o on 2017/5/17.
//  Copyright © 2017年 . All rights reserved.
//

#import "NSString+XHB.h"

#define KFileHashDefaultChunkSizeForReadingData 1024 * 8 // 8K

@implementation NSString (XHB)

+ (BOOL)isEmpty:(NSString *)str {
    if (str == nil || ![str isKindOfClass:[NSString class]]) {
        return YES;
    }
    if ([str length] == 0 || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

//+ (NSString *)stringWithInteger:(NSInteger)value {
//    NSNumber *number = [NSNumber numberWithInteger:value];
//    return [number stringValue];
//}
//
//+ (NSString *)stringWithLong:(long)value {
//    return [NSString stringWithFormat:@"%ld", value];
//}
//
//+ (NSString *)stringWithLongLong:(int64_t)value {
//    return [NSString stringWithFormat:@"%lld", value];
//}
//
//+ (NSString *)stringWithFloat:(float)value {
//    return [NSString stringWithFormat:@"%f", value];
//}
//
//+ (NSString *)stringWithDouble:(double)value {
//    return [NSString stringWithFormat:@"%lf", value];
//}
//
//- (NSString *)hb_capitalizedString {
//    if (self.length)
//        return [NSString stringWithFormat:@"%@%@", [self substringToIndex:1].uppercaseString, [self substringFromIndex:1]].copy;
//    return nil;
//}
//
//- (NSString *)md5Hash {
//    if ([self length] == 0)
//        return nil;
//
//    const char *value = [self UTF8String];
//
//    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(value, (CC_LONG) strlen(value), outputBuffer);
//
//    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
//        [outputString appendFormat:@"%02x", outputBuffer[count]];
//    }
//
//    return [NSString stringWithString:outputString];
//}
//
//+ (NSString *)getMD5WithData:(NSData *)data{
//    const char* original_str = (const char *)[data bytes];
//    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
//    CC_MD5(original_str, (uint)strlen(original_str), digist);
//    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
//    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
//        [outPutStr appendFormat:@"%02x",digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
//    }
//
//    //也可以定义一个字节数组来接收计算得到的MD5值
//    //    Byte byte[16];
//    //    CC_MD5(original_str, strlen(original_str), byte);
//    //    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
//    //    for(int  i = 0; i<CC_MD5_DIGEST_LENGTH;i++){
//    //        [outPutStr appendFormat:@"%02x",byte[i]];
//    //    }
//    //    [temp release];
//    return [outPutStr lowercaseString];
//}
//
//+ (NSString *)getFileMD5WithPath:(NSString *)path {
//    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)path,KFileHashDefaultChunkSizeForReadingData);
//}
//
//CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,
//                                      size_t chunkSizeForReadingData) {
//
//    // Declare needed variables
//    CFStringRef result = NULL;
//    CFReadStreamRef readStream = NULL;
//
//    // Get the file URL
//    CFURLRef fileURL =
//    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
//                                  (CFStringRef)filePath,
//                                  kCFURLPOSIXPathStyle,
//                                  (Boolean)false);
//
//    CC_MD5_CTX hashObject;
//    bool hasMoreData = true;
//    bool didSucceed;
//
//    if (!fileURL) goto done;
//
//    // Create and open the read stream
//    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
//                                            (CFURLRef)fileURL);
//    if (!readStream) goto done;
//    didSucceed = (bool)CFReadStreamOpen(readStream);
//    if (!didSucceed) goto done;
//
//    // Initialize the hash object
//    CC_MD5_Init(&hashObject);
//
//    // Make sure chunkSizeForReadingData is valid
//    if (!chunkSizeForReadingData) {
//        chunkSizeForReadingData = KFileHashDefaultChunkSizeForReadingData;
//    }
//
//    // Feed the data to the hash object
//    while (hasMoreData) {
//        uint8_t buffer[chunkSizeForReadingData];
//        CFIndex readBytesCount = CFReadStreamRead(readStream,
//                                                  (UInt8 *)buffer,
//                                                  (CFIndex)sizeof(buffer));
//        if (readBytesCount == -1)break;
//        if (readBytesCount == 0) {
//            hasMoreData =false;
//            continue;
//        }
//        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
//    }
//
//    // Check if the read operation succeeded
//    didSucceed = !hasMoreData;
//
//    // Compute the hash digest
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5_Final(digest, &hashObject);
//
//    // Abort if the read operation failed
//    if (!didSucceed) goto done;
//
//    // Compute the string result
//    char hash[2 *sizeof(digest) + 1];
//    for (size_t i =0; i < sizeof(digest); ++i) {
//        snprintf(hash + (2 * i),3, "%02x", (int)(digest[i]));
//    }
//    result = CFStringCreateWithCString(kCFAllocatorDefault,
//                                       (const char *)hash,
//                                       kCFStringEncodingUTF8);
//
//done:
//
//    if (readStream) {
//        CFReadStreamClose(readStream);
//        CFRelease(readStream);
//    }
//    if (fileURL) {
//        CFRelease(fileURL);
//    }
//    return result;
//}
//
////sha1Hash
//- (NSString *)sha1Hash {
//    if ([self length] == 0)
//        return nil;
//
//    const char *value = [self UTF8String];
//
//    unsigned char outputBuffer[CC_SHA1_DIGEST_LENGTH];
//    CC_SHA1(value, (CC_LONG) strlen(value), outputBuffer);
//
//    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
//    for (NSInteger count = 0; count < CC_SHA1_DIGEST_LENGTH; count++) {
//        [outputString appendFormat:@"%02x", outputBuffer[count]];
//    }
//
//    return [NSString stringWithString:outputString];
//}
//
//- (NSString *)urlDecode {
//    NSString *decodedString = (__bridge_transfer NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
//        NULL,
//        (__bridge CFStringRef) self,
//        CFSTR(""),
//        CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
//    return decodedString;
//}
//
//- (NSString *)urlEncode {
//    NSString *encodedString = (NSString *)
//        CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                                  (CFStringRef) self,
//                                                                  (CFStringRef) @"!$&'()*+,-./:;=?@_~%#[]",
//                                                                  NULL,
//                                                                  kCFStringEncodingUTF8));
//    return encodedString;
//}
//
//- (NSDictionary *)toDictionary {
//    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err = nil;
//    if (!jsonData) {
//        return nil;
//    }
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&err];
//    if (err) {
//        DDLogError(@"jsonString  to dic 解析失败");
//        return nil;
//    }
//    return dic;
//}
//
//- (NSMutableDictionary *)toMutableDictionary {
//    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err = nil;
//    if (!jsonData) {
//        return nil;
//    }
//    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
//    if (err) {
//        DDLogError(@"jsonString  to mutable dic 解析失败");
//        return nil;
//    }
//    return dic;
//}
//
//+ (NSString *)encodeBase64String:(NSString *)input {
//    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//
//    data = [XHBGTMBase64 encodeData:data];
//    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//    return base64String;
//}
//
//+ (NSString *)decodeBase64String:(NSString *)input {
//    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//
//    data = [XHBGTMBase64 decodeData:data];
//
//    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//    return base64String;
//}
//
//+ (NSString *)encodeBase64Data:(NSData *)data {
//    data = [XHBGTMBase64 encodeData:data];
//
//    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//    return base64String;
//}
//
//+ (NSString *)decodeBase64Data:(NSData *)data {
//    data = [XHBGTMBase64 decodeData:data];
//
//    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//    return base64String;
//}
//
///*
// *获取指定个数的字符串,length是字符长度
// *unitCharCount:字符的个数，中文：2
// */
//+ (NSString *)subString:(NSString *)str length:(NSInteger)charIndex trail:(BOOL)trail unitCharCount:(int)unitCharCount {
//    int count = 0;
//    if ([NSString isEmpty:str]) {
//        return nil;
//    }
//    NSString *subStr = str;
//    for (int i = 0; i < [str length]; i++) {
//        unichar c = [str characterAtIndex:(NSUInteger) i];
//        if (isblank(c) || isascii(c)) {
//            count++;
//        } else {
//            count += unitCharCount;
//        }
//        if (count >= charIndex) {
//            if (trail) {
//                subStr = [NSString stringWithFormat:@"%@...", [str substringToIndex:(NSUInteger) i]];
//            } else {
//                subStr = [str substringToIndex:(NSUInteger) i];
//            }
//            break;
//        }
//    }
//    return subStr;
//}
//
///*
// *获取指定个数的字符串,length是字符长度（得到的字符串至少有length个字符）
// *unitCharCount:字符的个数，中文：2
// */
//+ (NSString *)subString:(NSString *)str minimumLength:(NSInteger)charIndex trail:(BOOL)trail unitCharCount:(int)unitCharCount {
//    int count = 0;
//    if ([NSString isEmpty:str]) {
//        return nil;
//    }
//    NSString *subStr = str;
//    for (int i = 0; i < [str length]; i++) {
//        unichar c = [str characterAtIndex:(NSUInteger) i];
//        if (isblank(c) || isascii(c)) {
//            count++;
//        } else {
//            count += unitCharCount;
//        }
//        if (count > charIndex) {
//            if (trail) {
//                subStr = [NSString stringWithFormat:@"%@...", [str substringToIndex:(NSUInteger) i]];
//            } else {
//                subStr = [str substringToIndex:(NSUInteger) i];
//            }
//            break;
//        }
//    }
//    return subStr;
//}
//
///*
// *获取指定个数的中文字符串,length是字符长度
// */
//+ (NSString *)subString:(NSString *)str length:(NSInteger)charIndex trail:(BOOL)trail {
//    return [self subString:str length:charIndex trail:trail unitCharCount:2];
//}
//
///*
// *获取指定个数的中文字符串,length是字符长度（至少会有length个字符）
// */
//+ (NSString *)subString:(NSString *)str minimumLength:(NSInteger)charIndex trail:(BOOL)trail {
//    return [self subString:str minimumLength:charIndex trail:trail unitCharCount:2];
//}
//
///*
// *获取指定个数的字符串,length是字符长度,中文当1个
// */
//+ (NSString *)subStringOnlyChar:(NSString *)str length:(NSInteger)charIndex trail:(BOOL)trail {
//    return [self subString:str length:charIndex trail:trail unitCharCount:1];
//}
//
///*
// *获取指定个数的字符串,length是字符长度,中文当1个（至少会有length个字符）
// */
//+ (NSString *)subStringOnlyChar:(NSString *)str minimumLength:(NSInteger)charIndex trail:(BOOL)trail {
//    return [self subString:str minimumLength:charIndex trail:trail unitCharCount:1];
//}
//
//+ (int)charCountOfString:(NSString *)content unitCharCount:(int)unitCharCount {
//    int count = 0;
//    for (int i = 0; i < [content length]; i++) {
//        NSString *c = [content substringWithRange:NSMakeRange(i, 1)];
//        NSRange range = [c rangeOfString:@"^[A-Za-z0-9_]$" options:NSRegularExpressionSearch];
//        if (range.location != NSNotFound) {
//            count++;
//        } else {
//            count += unitCharCount;
//        }
//    }
//
//    return count;
//}
//
///**
// 去除html标签
// */
//+ (NSString *)removeHTML:(NSString *)html {
//    NSScanner *theScanner;
//
//    NSString *text = nil;
//
//    theScanner = [NSScanner scannerWithString:html];
//
//    while ([theScanner isAtEnd] == NO) {
//        // find start of tag
//        [theScanner scanUpToString:@"<" intoString:NULL];
//
//        // find end of tag
//        [theScanner scanUpToString:@">" intoString:&text];
//
//        // replace the found tag with a space
//        //(you can filter multi-spaces out later if you wish)
//        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
//    }
//    return html;
//}
//
///**
// 去除空格
// */
//+ (NSString *)trimWhitespace:(NSString *)str {
//    if (str != nil && (NSNull *) str != [NSNull null] && [str isKindOfClass:[NSString class]]) {
//        NSString *spaceStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        return [spaceStr stringByReplacingOccurrencesOfString:@" " withString:@""];
//    }
//    return nil;
//}
//
//+ (NSString *)trimIllegal:(NSString *)str {
//    if (str != nil && (NSNull *) str != [NSNull null] && [str isKindOfClass:[NSString class]]) {
//        return [str stringByTrimmingCharactersInSet:[NSCharacterSet illegalCharacterSet]];
//    }
//    return nil;
//}
//
//+ (NSString *)trimPunch:(NSString *)str {
//    if (str != nil && (NSNull *) str != [NSNull null] && [str isKindOfClass:[NSString class]]) {
//        return [str stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
//    }
//    return nil;
//}
//
///**
// 通过key从字典中获取字符
// */
//+ (NSString *)getString:(NSDictionary *)dict key:(NSString *)key {
//    NSString *value = @"";
//    if ([dict isKindOfClass:[NSDictionary class]] && ![NSString isEmpty:key]) {
//        id result = [dict objectForKey:key];
//        if ([result isKindOfClass:[NSNumber class]]) {
//            NSNumber *number = (NSNumber *) result;
//            value = [NSString stringWithFormat:@"%@", number];
//        } else if ([result isKindOfClass:[NSString class]]) {
//            value = result;
//        } else {
//            //            DDLogInfo(@"字典中获取字符 error key:%@ result 非字符串:%@",key,result);
//        }
//    } else {
//        DDLogInfo(@"字典中获取字符error dic:%@ key:%@", dict, key);
//    }
//    return value;
//}
//
///**
// 通过key从字典中获取字符
// 由外部保证key不为空，不再判断![NSString isEmpty:key]，适用于接口字段解析(eg key为固定字符串)
// 当数据量较大时![NSString isEmpty:key]可能存在性能卡顿问题，在很多接口解析场景中，key为写死的固定字段，已无需判断
// */
//+ (NSString *)getString:(NSDictionary *)dict withNonNullKey:(NSString *)key {
//    NSString *value = @"";
//    if ([dict isKindOfClass:[NSDictionary class]]) {
//        id result = [dict objectForKey:key];
//        if ([result isKindOfClass:[NSNumber class]]) {
//            NSNumber *number = (NSNumber *) result;
//            value = [NSString stringWithFormat:@"%@", number];
//        } else if ([result isKindOfClass:[NSString class]]) {
//            value = result;
//        } else {
//            //            DDLogInfo(@"字典中获取字符 error key:%@ result 非字符串:%@",key,result);
//        }
//    } else {
//        DDLogInfo(@"字典中获取字符error dic:%@ key:%@", dict, key);
//    }
//    return value;
//}
//
//// 将 new_count 格式转换 为 newCount oc编码风格
//- (NSString *)transformString {
//    NSString *newStr = nil;
//    NSMutableString *string = [NSMutableString stringWithFormat:@"%@", self];
//    NSRange range;
//    range = [string rangeOfString:@"_"];
//    if (range.location != NSNotFound) {
//        if (string.length <= range.location) {
//            [string deleteCharactersInRange:range];
//            newStr = [NSString stringWithFormat:@"%@", string];
//            return newStr;
//        }
//        NSString *ok = [[string substringWithRange:NSMakeRange(range.location + 1, 1)] uppercaseString];
//        if (![NSString isEmpty:ok]) {
//            [string replaceCharactersInRange:NSMakeRange(range.location + 1, 1) withString:ok];
//            [string deleteCharactersInRange:range];
//
//            NSRange ra = [string rangeOfString:@"_"];
//            if (ra.location == NSNotFound) {
//                newStr = [NSString stringWithFormat:@"%@", string];
//            } else {
//                newStr = [string transformString];
//            }
//        } else {
//            [string deleteCharactersInRange:range];
//            newStr = [NSString stringWithFormat:@"%@", string];
//        }
//    } else {
//        newStr = string;
//    }
//    return newStr;
//}
//
//+ (BOOL)isNickLegal:(NSString *)str {
//    return [self isLegal:str regex:@"^[a-zA-Z0-9_\u0391-\uFFE5]+$"];
//}
//
//+ (BOOL)isLegal:(NSString *)str regex:(NSString *)regex {
//    if ([self isEmpty:str]) {
//        return NO;
//    }
//
//    NSRegularExpression *regularexpression = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
//    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
//    return numberofMatch > 0;
//}
//
//+ (NSString *)cleanNewline:(NSString *)str {
//    NSString *result = str;
//    result = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
//    NSRange range1 = [result rangeOfString:@"\n"];
//    if (range1.length > 0) {
//        result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    }
//    NSRange range2 = [result rangeOfString:@"\r"];
//    if (range2.length > 0) {
//        result = [result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    }
//    return result;
//}
//
////将整数秒格式转成 mm:ss格式
//+ (NSString *)mmssStringWithLeftTime:(int)leftTime {
//    int second = leftTime % 60;
//    int minute = leftTime / 60;
//    NSString *secondStr = second < 10 ? [NSString stringWithFormat:@"0%d", second] : [NSString stringWithFormat:@"%d", second];
//    NSString *minuteStr = minute < 10 ? [NSString stringWithFormat:@"0%d", minute] : [NSString stringWithFormat:@"%d", minute];
//    return [NSString stringWithFormat:@"%@:%@", minuteStr, secondStr];
//}
//
- (CGSize)hb_sizeWithFont:(UIFont *)font {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [self sizeWithAttributes:dic];
}

- (CGSize)hb_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    return [self hb_sizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)];
}

- (CGSize)hb_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

- (CGSize)hb_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size withContentInsets:(UIEdgeInsets)contentInsets {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGSize realSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return CGSizeMake(realSize.width + contentInsets.left + contentInsets.right, realSize.height + contentInsets.top + contentInsets.bottom);
}

//- (CGSize)hb_sizeWithAttributes:(NSMutableDictionary *)attributes constrainedToSize:(CGSize)size withContentInsets:(UIEdgeInsets)contentInsets {
//    CGSize realSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
//    return CGSizeMake(realSize.width + contentInsets.left + contentInsets.right, realSize.height + contentInsets.top + contentInsets.bottom);
//}
//
//// 返回以.W为单位的字符串 小数点后一位 如1.1W
//+ (NSString *)wanStringWithLong:(long)value {
//    return [self wanStringWithLong:value truncType:HBNumberTruncType_Floor decimals:1];
//}
//
//+ (NSString *)wanStringWithLong:(long)value truncType:(HBNumberTruncType)type decimals:(int)decimals {
//    if (value <= 9999) {
//        return [self stringWithInteger:value];
//    } else {
//        CGFloat temp = (value * 1.0) / 10000.0;
//        CGFloat result = hb_truncFloat(temp, type, decimals);
//        if (decimals == 1) {
//            return [NSString stringWithFormat:@"%.1fW", result];
//        } else if (decimals == 2) {
//            return [NSString stringWithFormat:@"%.2fW", result];
//        } else if (decimals == 3) {
//            return [NSString stringWithFormat:@"%.3fW", result];
//        }
//        return [NSString stringWithFormat:@"%.1fW", result];
//    }
//}
//
//+ (BOOL)isMobileNum:(NSString *)num {
//    if ([self isEmpty:num]) {
//        return NO;
//    }
//
//    NSString *regex = @"^((1\\d{10}))$";
//    NSRegularExpression *regularexpression = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
//    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:num options:NSMatchingReportProgress range:NSMakeRange(0, num.length)];
//    return numberofMatch > 0;
//}
//
///**
// *判断一个字符串是否是一个IP地址
// **/
//+ (BOOL)isValidIP:(NSString *)ipStr {
//    if (nil == ipStr) {
//        return NO;
//    }
//    NSArray *ipArray = [ipStr componentsSeparatedByString:@"."];
//    if (ipArray.count == 4) {
//        for (NSString *ipnumberStr in ipArray) {
//            int ipnumber = [ipnumberStr intValue];
//            if (!(ipnumber >= 0 && ipnumber <= 255)) {
//                return NO;
//            }
//        }
//        return YES;
//    }
//    return NO;
//}
//
////Email
//+ (BOOL)isEmail:(NSString *)email {
//    return [self isLegal:email regex:@"^([a-zA-Z0-9]*[-_.]?[a-zA-Z0-9]+)@([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)+[\\.][A-Za-z]{2,3}([\\.][A-Za-z]{2})?$"];
//}
//
//+ (NSString *)getNumberFromStr:(NSString *)str {
//    if ([NSString isEmpty:str]) {
//        return nil;
//    }
//    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
//    return [[str componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
//}
//
//- (NSArray<NSValue *> *)getAllRangesOfSubString:(NSString *)subStr {
//    NSMutableArray *rangeArray = [NSMutableArray array];
//    if ([NSString isEmpty:subStr]) {
//        return rangeArray;
//    }
//    NSString *tempStr = @"";
//    int length = (int) self.length - (int) subStr.length;
//    for (int i = 0; i <= length; i++) {
//        NSRange range = NSMakeRange(i, subStr.length);
//        tempStr = [self substringWithRange:range];
//        if ([tempStr isEqualToString:subStr]) {
//            [rangeArray addObject:[NSValue valueWithRange:range]];
//        }
//    }
//    return rangeArray;
//}
//
////判断全汉字
//+ (BOOL)stringIsAllChinese:(NSString *)inputString {
//    if ([NSString isEmpty:inputString]) {
//        return NO;
//    }
//    NSString *regex = @"[\u4e00-\u9fa5]+";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    return [pred evaluateWithObject:inputString];
//}
//
////判断全数字
//+ (BOOL)stringIsAllNumber:(NSString *)inputString {
//    if (inputString.length == 0)
//        return NO;
//    NSString *regex = @"[0-9]*";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    return [pred evaluateWithObject:inputString];
//}
//
////密码加密
//+ (NSString *)encrypt:(NSString *)psw {
//    //先对密码进行md5加密
//    NSString *md5Pwd = [psw md5Hash];
//
//    //再对密码进行sha1加密
//    NSString *sha1Pwd = [md5Pwd sha1Hash];
//    return sha1Pwd;
//}
//
///**
// * url 拼装 host
// */
//+ (NSString *)appendWithHost:(NSString *)host urlPath:(NSString *)urlPath {
//    if ([NSString isEmpty:host]) {
//        DDLogError(@"**url 拼装 host: null** urlPath:%@", urlPath);
//        return nil;
//    }
//    // 防止 服务端下发 如 ： /   的非正常地址
//    if ([NSString isEmpty:urlPath] || urlPath.length < 3) {
//        return nil;
//    }
//    if ([urlPath hasPrefix:@"http"]) {
//        return urlPath;
//    }
//    if (![urlPath hasPrefix:@"/"] && ![host hasSuffix:@"/"]) {
//        urlPath = [NSString stringWithFormat:@"/%@", urlPath];
//    }
//    return [host stringByAppendingString:urlPath];
//}
//
//- (NSString *)HBLocalizable {
//    NSString *mainBundlePath = [[NSBundle bundleForClass:[XHBGTMBase64 class]] resourcePath];
//    NSString *languageBundlePath = [mainBundlePath stringByAppendingPathComponent:@"HBPublicLocalizable.bundle"];
//    NSBundle *targetBundlePath = [NSBundle bundleWithPath:languageBundlePath];
//    NSString *string = NSLocalizedStringFromTableInBundle(self, @"HBPublic", targetBundlePath, nil);
//    if ([NSString isEmpty:string]) {
//        return self;
//    }
//    return string;
//}
//
////获得含中英文混合字符串的长度
//+ (NSInteger)getLength:(NSString *)complexString {
//    if ([self isEmpty:complexString]) {
//        return 0;
//    }
//
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSData *data = [complexString dataUsingEncoding:enc];
//    NSInteger length = data.length;
//    return length;
//}
//
///** float保留两位小数*/
//+ (NSString *)getStringTwoDecimal:(NSDictionary *)dict key:(NSString *)key {
//    NSString *value = @"";
//    if ([dict isKindOfClass:[NSDictionary class]] && ![NSString isEmpty:key]) {
//        id result = [dict objectForKey:key];
//        if ([result isKindOfClass:[NSNumber class]]) {
//            NSNumber *number = (NSNumber *) result;
//            value = [NSString stringWithFormat:@"%.2f", [number floatValue]];
//        } else if ([result isKindOfClass:[NSString class]]) {
//            value = result;
//        } else {
//            //            DDLogInfo(@"字典中获取字符 error key:%@ result 非字符串:%@",key,result);
//        }
//    } else {
//        DDLogInfo(@"字典中获取字符error dic:%@ key:%@", dict, key);
//    }
//    return value;
//}
//
//+ (BOOL)isStringWithAnyText:(id)object {
//    return [object isKindOfClass:[NSString class]] && [(NSString *) object length] > 0;
//}
//
//+ (NSString *)updateLeftTime:(int)leftTime {
//    int second = leftTime % 60;
//    int minute = leftTime / 60;
//    NSString *secondStr = second < 10 ? [NSString stringWithFormat:@"0%d", second] : [NSString stringWithFormat:@"%d", second];
//    NSString *minuteStr = minute < 10 ? [NSString stringWithFormat:@"0%d", minute] : [NSString stringWithFormat:@"%d", minute];
//
//    return [NSString stringWithFormat:@"%@:%@", minuteStr, secondStr];
//}
//
//+ (NSString *)replaceNewlineAndBreak:(NSString *)str {
//    NSRange range = [[str lowercaseString] rangeOfString:@"\\r\\n"];
//    if (range.location == NSNotFound) {
//        return str;
//    }
//    return [str stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\r\n"];
//}
//
////中文数字_ && 非纯数字 && 不包含“@”
//+ (BOOL)isNickLegalForName:(NSString *)str {
//    BOOL isContain;
//    NSRange foundObj = [str rangeOfString:@"@" options:NSCaseInsensitiveSearch];
//    if (foundObj.length > 0) {
//        isContain = YES;
//    } else {
//        isContain = NO;
//    }
//
//    return [self isNickLegal:str] && ![self stringIsAllNumber:str] && (!isContain);
//}
//+ (NSString *)encodeNewLineAndBreak:(NSString *)str {
//    NSString *lowercaseString = [str lowercaseString];
//    NSString *resultString = str;
//    NSRange range1 = [lowercaseString rangeOfString:@"\r"];
//    if (range1.location != NSNotFound) {
//        resultString = [resultString stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
//    }
//
//    NSRange range2 = [lowercaseString rangeOfString:@"\n"];
//    if (range2.location != NSNotFound) {
//        resultString = [resultString stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
//    }
//
//    return resultString;
//}
////城市名称，删除“市”
//+ (NSString *)deleteCityNameSomeStr:(NSString *)str {
//    if ([self isEmpty:str]) {
//        return @"";
//    }
//    NSString *resultStr = str;
//    NSString *targetStr = [str substringFromIndex:[str length] - 1];
//    if ([targetStr isEqualToString:@"市"]) {
//        resultStr = [resultStr substringToIndex:([resultStr length] - 1)];
//    }
//    return resultStr;
//}
//
//+ (NSString *)deleteProvinceName:(NSString *)str {
//    if ([self isEmpty:str]) {
//        return @"";
//    }
//    NSString *resultStr = str;
//    NSString *targetStr = [str substringFromIndex:[str length] - 1];
//    if ([targetStr isEqualToString:@"省"]) {
//        resultStr = [resultStr substringToIndex:([resultStr length] - 1)];
//    }
//    return resultStr;
//}
//
//+ (NSString *)getStringForNotNull:(NSString *)inparam {
//    NSString *string = @"";
//    if (inparam != nil && (NSNull *) inparam != [NSNull null] && [inparam isKindOfClass:[NSString class]]) {
//        string = inparam;
//    }
//    return string;
//}
//
//+ (NSNumber *)getNumberFromString:(NSString *)string {
//    if ([self isEmpty:string]) {
//        return nil;
//    }
//    NSNumber *num = [NSNumber numberWithFloat:[string floatValue]];
//    return num;
//}
//+ (NSString *)stringOfJsonFromDic:(NSDictionary *)dic {
//    if (!dic) {
//        return nil;
//    }
//
//    NSArray *dicKeys = [dic allKeys];
//    if (!dicKeys || [dicKeys count] == 0) {
//        return nil;
//    }
//
//    NSMutableString *resultString = [NSMutableString string];
//    for (int i = 0; i < [dicKeys count]; i++) {
//        id oneKey = [dicKeys objectAtIndex:i];
//        if (!oneKey || ![oneKey isKindOfClass:[NSString class]]) {
//            continue;
//        }
//
//        NSString *keyString = (NSString *) oneKey;
//        id oneValue = [dic objectForKey:keyString];
//        if (!oneValue || ![oneValue isKindOfClass:[NSString class]]) {
//            continue;
//        }
//        NSString *valueString = (NSString *) oneValue;
//        if (i == 0) {
//            [resultString appendFormat:@"%@=%@", keyString, valueString];
//        } else {
//            [resultString appendFormat:@"&%@=%@", keyString, valueString];
//        }
//    }
//
//    return resultString;
//}
//
////密码必须包含大小写字母和数字
//+ (BOOL)isPassword:(NSString *)ps {
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?:(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])).*$"];
//    BOOL result = [predicate evaluateWithObject:ps];
//    return result;
//}
//
//+ (NSString *)tenThousandStringWithInteger:(NSInteger)value{
//    if (value <= 9999) {
//        return [self stringWithInteger:value];
//    }else{
//        NSInteger wan = value / 10000;
//        NSInteger last = value % 10000;
//        return [NSString stringWithFormat:@"%ld万%ld",(long)wan,(long)last];
//    }
//}
//
//////x.x k
//+ (NSString *)thousandStringWithString:(NSString *)string {
//    NSInteger value = [string integerValue];
//    if (value <= 999) {
//        return [self stringWithInteger:value];
//    }else{
//        float k = value / 1000;
//        float h = (value % 1000) / 100;
//        return [NSString stringWithFormat:@"%.0f.%.0fk", k, h];
//    }
//}
//
////// 返回以.万为单位的字符串 小数点后一位 如1.1万
//+ (NSString *)wanChineseStringWithLong:(long)value {
//    if (value <= 9999) {
//        return [self stringWithInteger:value];
//    }else{
//        NSInteger wan = value / 10000;
//        NSInteger last = value % 10000;
//        NSInteger qian = last / 1000;
//        //        last = last % 1000;
//        //        NSInteger bai = last / 100;
//        //        last = last % 100;
//        //        NSInteger shi = last / 10;
//        //        NSInteger ge = last % 10;
//        return [NSString stringWithFormat:@"%ld.%ld万",wan,qian];
//    }
//}
//
//+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData{
//    if (jsonData == nil) {
//        return nil;
//    }
//    //转化为字典   NSJSONReadingMutableContainers  返回可变字典   0  返回不变的 NSDictionary
//    NSError *error = nil;
//    NSDictionary *jsonDic =  [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
//    if (error) {
//        DDLogError(@"jsonData to dic 解析失败 ");
//    }
//    return jsonDic;
//}
//
////// json格式字符串转字典：
////
//+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
//    if (jsonString == nil) {
//        return nil;
//    }
//    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err = nil;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
//    if(err) {
//        DDLogError(@"jsonString  to dic 解析失败");
//        return nil;
//    }
//    return dic;
//}
//
//+ (NSString *)toJSONString:(NSArray *)arr {
//    NSData *data = [NSJSONSerialization dataWithJSONObject:arr
//                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
//                                                     error:nil];
//    if (data == nil) {
//        return nil;
//    }
//
//    NSString *string = [[NSString alloc] initWithData:data
//                                             encoding:NSUTF8StringEncoding];
//    return string;
//}
//
/////**
//// 根据剩余秒数转换为分秒的形式 eg: 08:30
////
//// @param leftTime 剩余秒数
//// */
//+ (NSString *)minuteAndSecondStringWithLeftTime:(int)leftTime {
//    int second = leftTime % 60;
//    int minute = leftTime / 60;
//    NSString *secondStr = second < 10 ? [NSString stringWithFormat:@"0%d",second] : [NSString stringWithFormat:@"%d",second];
//    NSString *minuteStr = minute < 10 ? [NSString stringWithFormat:@"0%d",minute] : [NSString stringWithFormat:@"%d",minute];
//
//    return [NSString stringWithFormat:@"%@:%@",minuteStr,secondStr];
//
//}
//
////统一处理距离显示
//+ (NSString *)dealWithPosition:(NSString *)positionStr {
//    if ([NSString isEmpty:positionStr]) {
//        return @"";
//    }
//    float position = [positionStr floatValue];
//    NSString *resultStr = @"";
//    if (position < 1) {
//        resultStr = @"<1";
//    }else{
//        resultStr = [self removeFloatAllZeroByString:[NSString stringWithFormat:@"%0.1f",position]];
//    }
//    return resultStr;
//}
//
////去除字符后面为0
//+ (NSString *)removeFloatAllZeroByString:(NSString *)floatStr {
//    if ([NSString isEmpty:floatStr]) {
//        return @"0";
//    }
//    NSString *outNumber = [NSString stringWithFormat:@"%@", @(floatStr.floatValue)];
//    return outNumber;
//}

@end
