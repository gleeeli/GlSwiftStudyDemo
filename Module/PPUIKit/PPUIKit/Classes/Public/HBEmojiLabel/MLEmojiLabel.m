//
//  MLEmojiLabel.m
//  MLEmojiLabel
//
//  Created by molon on 5/19/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import "MLEmojiLabel.h"
//#import "ConfigModule.h"

#pragma mark - 正则列表

#define REGULAREXPRESSION_OPTION(regularExpression,regex,option) \
\
static inline NSRegularExpression * k##regularExpression() { \
static NSRegularExpression *_##regularExpression = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_##regularExpression = [[NSRegularExpression alloc] initWithPattern:(regex) options:(option) error:nil];\
});\
\
return _##regularExpression;\
}\


#define REGULAREXPRESSION(regularExpression,regex) REGULAREXPRESSION_OPTION(regularExpression,regex,NSRegularExpressionCaseInsensitive)


REGULAREXPRESSION(URLRegularExpression,@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)")

REGULAREXPRESSION(PhoneNumerRegularExpression, @"\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[358]+\\d{9}|\\d{8}|\\d{7}")

REGULAREXPRESSION(EmailRegularExpression, @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}")

REGULAREXPRESSION(AtRegularExpression, @"@[\\u4e00-\\u9fa5\\w\\-]+")


//@"#([^\\#|.]+)#"
REGULAREXPRESSION_OPTION(PoundSignRegularExpression, @"#([\\u4e00-\\u9fa5\\w\\-]+)#", NSRegularExpressionCaseInsensitive)

//微信的表情符其实不是这种格式，这个格式的只是让人看起来更友好。。
//REGULAREXPRESSION(EmojiRegularExpression, @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]")

//@"/:[\\w:~!@$&*()|+<>',?-]{1,8}" , // @"/:[\\x21-\\x2E\\x30-\\x7E]{1,8}" ，经过检测发现\w会匹配中文
REGULAREXPRESSION(SlashEmojiRegularExpression, @"/:[\\x21-\\x2E\\x30-\\x7E]{1,8}")

const CGFloat kLineSpacing = 4.0;
const CGFloat kAscentDescentScale = 0.25; //在这里的话无意义，高度的结局都是和宽度一样

const CGFloat kEmojiWidthRatioWithLineHeight = 1.15;//和字体高度的比例

const CGFloat kEmojiOriginYOffsetRatioWithLineHeight = 0.10; //表情绘制的y坐标矫正值，和字体高度的比例，越大越往下

const CGFloat kEmojiNewHeight = 26; //表情新高度

NSString *const kCustomGlyphAttributeImageName = @"CustomGlyphAttributeImageName";

#define kEmojiReplaceCharacter @"\uFFFC"

#define kURLActionCount 5

NSString * const kURLActions[] = {@"url->",@"email->",@"phoneNumber->",@"at->",@"poundSign->"};

/**
 *  plist管理器，自定义plist
 */
@interface MLEmojiLabelRegexPlistManager : NSObject

- (NSDictionary*)emojiDictForKey:(NSString*)key;

@property (nonatomic, strong) NSMutableDictionary *emojiDictRecords;
@property (nonatomic, strong) NSMutableDictionary *emojiRegularExpressions;

@end



@implementation MLEmojiLabelRegexPlistManager

+ (instancetype)sharedInstance {
    static MLEmojiLabelRegexPlistManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc]init];
    });
    return _sharedInstance;
}

#pragma mark - getter
- (NSMutableDictionary *)emojiDictRecords
{
	if (!_emojiDictRecords) {
		_emojiDictRecords = [NSMutableDictionary new];
	}
	return _emojiDictRecords;
}

- (NSMutableDictionary *)emojiRegularExpressions
{
	if (!_emojiRegularExpressions) {
		_emojiRegularExpressions = [NSMutableDictionary new];
	}
	return _emojiRegularExpressions;
}

#pragma mark - common
- (NSDictionary *)emojiDictForKey:(NSString *)key
{
    NSAssert(key&&key.length > 0, @"emojiDictForKey:参数不得为空");
    
    if (self.emojiDictRecords[key]) {
        return self.emojiDictRecords[key];
    }
    
    
    NSString *emojiFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:key];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:emojiFilePath];
    NSAssert(dict, @"表情字典%@找不到", key);
    self.emojiDictRecords[key] = dict;
    
    return self.emojiDictRecords[key];
}

- (NSRegularExpression *)regularExpressionForRegex:(NSString *)regex
{
    NSAssert(regex&&regex.length>0, @"regularExpressionForKey:参数不得为空");
    
    if (self.emojiRegularExpressions[regex]) {
        return self.emojiRegularExpressions[regex];
    }
    
    NSRegularExpression *re = [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSAssert(re,@"正则%@有误",regex);
    self.emojiRegularExpressions[regex] = re;
    
    return self.emojiRegularExpressions[regex];
}

@end




@interface MLEmojiLabel()

@property (nonatomic, weak) NSRegularExpression *customEmojiRegularExpression;
@property (nonatomic, weak) NSRegularExpression *customEmojiNewRegularExpression;
@property (nonatomic, weak) NSDictionary *customEmojiDictionary; //同时在MLEmojiLabelPlistManager单例里面存着
@property (nonatomic, weak) NSDictionary *customEmojiNewDictionary; //同时在MLEmojiLabelPlistManager单例里面存着

@property (nonatomic, assign) BOOL ignoreSetText;

@property (nonatomic, copy) id emojiText;
@property (nonatomic, assign) int emojiCount;

@end




@implementation MLEmojiLabel

@dynamic delegate;

#pragma mark - 表情包字典
+ (NSDictionary *)emojiDictionary {
    static NSDictionary *emojiDictionary = nil;
    static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    NSString *emojiFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"expressionImage.plist"];
	    emojiDictionary = [[NSDictionary alloc] initWithContentsOfFile:emojiFilePath];
	});
	return emojiDictionary;
}

#pragma mark - 表情 callback
typedef struct CustomGlyphMetrics {
    CGFloat ascent;
    CGFloat descent;
    CGFloat width;
} CustomGlyphMetrics, *CustomGlyphMetricsRef;

static void deallocCallback(void *refCon) {
	free(refCon), refCon = NULL;
}

static CGFloat ascentCallback(void *refCon) {
	CustomGlyphMetricsRef metrics = (CustomGlyphMetricsRef)refCon;
	return metrics->ascent;
}

static CGFloat descentCallback(void *refCon) {
	CustomGlyphMetricsRef metrics = (CustomGlyphMetricsRef)refCon;
	return metrics->descent;
}

static CGFloat widthCallback(void *refCon) {
	CustomGlyphMetricsRef metrics = (CustomGlyphMetricsRef)refCon;
	return metrics->width;
}

#pragma mark - 初始化和TTT的一些修正
/**
 *  下面这个方法覆盖TTT里的，因为个别设置与其不同
 *  TTT的commonInit是被调用了两回。如果直接init的话，因为init其中会调用initWithFrame
 *  PS.此问题已经向matt提交issue，他已经修正。
 */
- (void)commonInit {
    
    //快速生产plist方法
    //    [self initPlist];
    
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = NO;
    
    self.numberOfLines = 0;
    self.font = [UIFont systemFontOfSize:14.0];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.lineBreakMode = NSLineBreakByCharWrapping;
    
    self.textInsets = UIEdgeInsetsZero;
    self.lineHeightMultiple = 1.0f;
    self.lineSpacing = kLineSpacing; //默认行间距
    
    [self setValue:[NSArray array] forKey:@"links"];
    
    NSMutableDictionary *mutableLinkAttributes = [NSMutableDictionary dictionary];
    [mutableLinkAttributes setObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    
    NSMutableDictionary *mutableActiveLinkAttributes = [NSMutableDictionary dictionary];
    [mutableActiveLinkAttributes setObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    
    NSMutableDictionary *mutableInactiveLinkAttributes = [NSMutableDictionary dictionary];
    [mutableInactiveLinkAttributes setObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    
    // 链接字体颜色
    UIColor *commonLinkColor = self.commonLinkColor ? self.commonLinkColor : [UIColor colorWithRed:129/255.0 green:27/255.0 blue:1.0 alpha:1];
    
    /*
     //链接下划线
     [mutableLinkAttributes setObject:@(NSUnderlineStyleSingle) forKey:NSUnderlineStyleAttributeName];
    
    if (Isios7()) {
        //链接下划线 颜色
        [mutableLinkAttributes setObject:COLOR_TEXT_RED forKey:NSUnderlineColorAttributeName];
    }
     */
    
    //点击时候的背景色
    [mutableActiveLinkAttributes setValue:(__bridge id)[[UIColor clearColor] CGColor] forKey:(NSString *)kTTTBackgroundFillColorAttributeName]; //[UIColor colorWithWhite:0.631 alpha:0.5] CGColor]
    
    if ([NSMutableParagraphStyle class]) {
        [mutableLinkAttributes setObject:commonLinkColor forKey:(NSString *)kCTForegroundColorAttributeName];
        [mutableActiveLinkAttributes setObject:commonLinkColor forKey:(NSString *)kCTForegroundColorAttributeName];
        [mutableInactiveLinkAttributes setObject:[UIColor grayColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        
        
        //把原有TTT的NSMutableParagraphStyle设置给去掉了。会影响到整个段落的设置
    } else {
        [mutableLinkAttributes setObject:(__bridge id)[commonLinkColor CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        [mutableActiveLinkAttributes setObject:(__bridge id)[commonLinkColor CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        [mutableInactiveLinkAttributes setObject:(__bridge id)[[UIColor grayColor] CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        
        
        //把原有TTT的NSMutableParagraphStyle设置给去掉了。会影响到整个段落的设置
    }
    
    self.linkAttributes = [NSDictionary dictionaryWithDictionary:mutableLinkAttributes];
    self.activeLinkAttributes = [NSDictionary dictionaryWithDictionary:mutableActiveLinkAttributes];
    self.inactiveLinkAttributes = [NSDictionary dictionaryWithDictionary:mutableInactiveLinkAttributes];
}

/**
 *  如果是有attributedText的情况下，有可能会返回少那么点的，这里矫正下
 */
- (CGSize)sizeThatFits:(CGSize)size {
    if (!self.attributedText) {
        return [super sizeThatFits:size];
    }
    
    CGSize rSize = [super sizeThatFits:size];
    rSize.height += 1;
    return rSize;
}


//这里是抄TTT里的，因为他不是放在外面的
static inline CGFloat TTTFlushFactorForTextAlignment(NSTextAlignment textAlignment) {
    switch (textAlignment) {
        case NSTextAlignmentCenter:
            return 0.5f;
        case NSTextAlignmentRight:
            return 1.0f;
        case NSTextAlignmentLeft:
        default:
            return 0.0f;
    }
}

#pragma mark - 绘制表情
- (void)drawOtherForEndWithFrame:(CTFrameRef)frame
                          inRect:(CGRect)rect
                         context:(CGContextRef)c
{
    //PS:这个是在TTT里drawFramesetter....方法最后做了修改的基础上。
    /*
     * by Soldier
     */
    CGFloat emojiWith = self.font.lineHeight * (self.emojiWidthRatioWithLineHeight != 0 ? self.emojiWidthRatioWithLineHeight : kEmojiWidthRatioWithLineHeight);//无自定义时使用默认值;


    CGFloat emojiOriginYOffset = self.font.lineHeight * (self.emojiOriginYOffsetRatioWithLineHeight != 0 ? self.emojiOriginYOffsetRatioWithLineHeight : kEmojiOriginYOffsetRatioWithLineHeight); //无自定义时使用默认值;
   
    //修正绘制offset，根据当前设置的textAlignment
    CGFloat flushFactor = TTTFlushFactorForTextAlignment(self.textAlignment);
    
    CFArrayRef lines = CTFrameGetLines(frame);
    NSInteger numberOfLines = self.numberOfLines > 0 ? MIN(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines);
    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);
    
    BOOL truncateLastLine = (self.lineBreakMode == NSLineBreakByTruncatingHead || self.lineBreakMode == NSLineBreakByTruncatingMiddle || self.lineBreakMode == NSLineBreakByTruncatingTail);
    CFRange textRange = CFRangeMake(0, (CFIndex)[self.attributedText length]);
    
    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        
        //这里其实是能获取到当前行的真实origin.x，根据textAlignment，而lineBounds.origin.x其实是默认一直为0的(不会受textAlignment影响)
        CGFloat penOffset = (CGFloat)CTLineGetPenOffsetForFlush(line, flushFactor, rect.size.width);
        
        CFIndex truncationAttributePosition = -1;
        //检测如果是最后一行，是否有替换...
        if (lineIndex == numberOfLines - 1 && truncateLastLine) {
            // Check if the range of text in the last line reaches the end of the full attributed string
            CFRange lastLineRange = CTLineGetStringRange(line);
            
            if (!(lastLineRange.length == 0 && lastLineRange.location == 0) && lastLineRange.location + lastLineRange.length < textRange.location + textRange.length) {
                // Get correct truncationType and attribute position
                truncationAttributePosition = lastLineRange.location;
                NSLineBreakMode lineBreakMode = self.lineBreakMode;
                
                // Multiple lines, only use UILineBreakModeTailTruncation
                if (numberOfLines != 1) {
                    lineBreakMode = NSLineBreakByTruncatingTail;
                }
                
                switch (lineBreakMode) {
                    case NSLineBreakByTruncatingHead:
                        break;
                    case NSLineBreakByTruncatingMiddle:
                        truncationAttributePosition += (lastLineRange.length / 2);
                        break;
                    case NSLineBreakByTruncatingTail:
                    default:
                        truncationAttributePosition += (lastLineRange.length - 1);
                        break;
                }
                
                //如果要在truncationAttributePosition这个位置画表情需要忽略
            }
        }
        
        //找到当前行的每一个要素，姑且这么叫吧。可以理解为有单独的attr属性的各个range。
        for (id glyphRun in (__bridge NSArray *)CTLineGetGlyphRuns(line)) {
            //找到此要素所对应的属性
            NSDictionary *attributes = (__bridge NSDictionary *)CTRunGetAttributes((__bridge CTRunRef) glyphRun);
            //判断是否有图像，如果有就绘制上去
            NSString *imageName = attributes[kCustomGlyphAttributeImageName];
            if (imageName) {
                CFRange glyphRange = CTRunGetStringRange((__bridge CTRunRef)glyphRun);
                if (glyphRange.location == truncationAttributePosition) {
                    //这里因为glyphRange的length肯定为1，所以只做这一个判断足够
                    continue;
                }
                
                CGRect runBounds = CGRectZero;
                CGFloat runAscent = 0.0f;
                CGFloat runDescent = 0.0f;
                
                runBounds.size.width = (CGFloat)CTRunGetTypographicBounds((__bridge CTRunRef)glyphRun, CFRangeMake(0, 0), &runAscent, &runDescent, NULL);
                
                if (runBounds.size.width!=emojiWith) {
                    //这一句是为了在某些情况下，例如单行省略号模式下，默认行为会将个别表情的runDelegate改变，也就改变了其大小。这时候会引起界面上错乱，这里做下检测(浮点数做等于判断似乎有点操蛋啊。。)
                    continue;
                }
                
                runBounds.size.height = runAscent + runDescent;
                
                CGFloat xOffset = 0.0f;
                switch (CTRunGetStatus((__bridge CTRunRef)glyphRun)) {
                    case kCTRunStatusRightToLeft:
                        xOffset = CTLineGetOffsetForStringIndex(line, glyphRange.location + glyphRange.length, NULL);
                        break;
                    default:
                        xOffset = CTLineGetOffsetForStringIndex(line, glyphRange.location, NULL);
                        break;
                }
                runBounds.origin.x = penOffset + xOffset;
                runBounds.origin.y = lineOrigins[lineIndex].y;
                runBounds.origin.y -= runDescent;
                
                UIImage *image = [UIImage imageNamed:imageName];
                runBounds.origin.y -= emojiOriginYOffset; //稍微矫正下。
                CGContextDrawImage(c, runBounds, image.CGImage);
            }
        }
    }
}


#pragma mark - main
- (NSArray *)getEmojiArrayWith:(NSString *)string {
    NSArray *emojis = nil;
    
    if (self.customEmojiRegularExpression) {
/**
 * by wuy 香蕉表情与新表情 由于正则含括不一致 用了两张表和两个正则表达式 所以表情需要取两次 再冒泡排序
*/
        NSArray *arr1 = [self.customEmojiRegularExpression matchesInString:string
                                                                  options:NSMatchingWithTransparentBounds
                                                                    range:NSMakeRange(0, [string length])];
        NSArray *arr2 = [self.customEmojiNewRegularExpression matchesInString:string
                                                                  options:NSMatchingWithTransparentBounds
                                                                    range:NSMakeRange(0, [string length])];
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObjectsFromArray:arr1];
        [arr addObjectsFromArray:arr2];
        if (arr.count >= 2 && arr1.count >= 1 && arr2.count >= 1) {
            for (int i = 0; i<arr.count-1; i++) {//冒个泡
                    for (int j = 0; j<arr.count-1-i; j++) {
                        NSTextCheckingResult *resultLeft = arr[j];
                        NSTextCheckingResult *resultRight = arr[j+1];
                        if (resultLeft.range.location>resultRight.range.location) {
                            [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
        }
        emojis =[NSArray arrayWithArray:arr];
    } else {
        emojis = [kSlashEmojiRegularExpression() matchesInString:string
                                                         options:NSMatchingWithTransparentBounds
                                                           range:NSMakeRange(0, [string length])];
    }
    return emojis;
}
/**
 *  返回经过表情识别处理的Attributed字符串
 */
- (NSMutableAttributedString *)mutableAttributeStringWithEmojiText:(NSAttributedString *)emojiText
{
    //获取所有表情的位置
//        NSArray *emojis = [kEmojiRegularExpression() matchesInString:emojiText
//                                                             options:NSMatchingWithTransparentBounds
//                                                               range:NSMakeRange(0, [emojiText length])];
    
    NSArray *emojis = [self getEmojiArrayWith:emojiText.string];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    NSUInteger location = 0;
    
    
    CGFloat emojiWith = self.font.lineHeight * (self.emojiWidthRatioWithLineHeight != 0 ? self.emojiWidthRatioWithLineHeight : kEmojiWidthRatioWithLineHeight);//无自定义时使用默认值;;
    _emojiCount = 0;
    for (NSTextCheckingResult *result in emojis) {
        NSRange range = result.range;
        NSAttributedString *attSubStr = [emojiText attributedSubstringFromRange:NSMakeRange(location, range.location - location)];
		[attrStr appendAttributedString:attSubStr];
        
		location = range.location + range.length;
        
		NSAttributedString *emojiKey = [emojiText attributedSubstringFromRange:range];
        
        NSDictionary *emojiDict = self.customEmojiRegularExpression?self.customEmojiDictionary:[MLEmojiLabel emojiDictionary];
        NSDictionary *emojiNewDict = self.customEmojiNewRegularExpression?self.customEmojiNewDictionary:[MLEmojiLabel emojiDictionary];
        
        //如果当前获得key后面有多余的，这个需要记录下
        NSAttributedString *otherAppendStr = nil;
        
		NSString *imageName = emojiNewDict[emojiKey.string];
        if (!imageName) {
            imageName = emojiDict[emojiKey.string];
        }
        
        if (!self.customEmojiRegularExpression) {
            //微信的表情没有结束符号,所以有可能会发现过长的只有头部才是表情的段，需要循环检测一次。微信最大表情特殊字符是8个长度，检测8次即可
            if (!imageName&&emojiKey.length > 2) {
                NSUInteger maxDetctIndex = emojiKey.length > 8 + 2 ? 8 : emojiKey.length - 2;
                //从头开始检测是否有对应的
                for (NSUInteger i = 0; i < maxDetctIndex; i++) {
                    imageName = emojiDict[[emojiKey.string substringToIndex:3 + i]];
                    if (imageName) {
                        otherAppendStr = [emojiKey attributedSubstringFromRange:NSMakeRange(3 + i, emojiKey.length - 3 - i)];
                        break;
                    }
                }
            }
        }
        
		if (imageName) {
/**
 * by wuy 统计当前表情数量 以便校正时使用
 */
            _emojiCount ++;
			// 这里不用空格，空格有个问题就是连续空格的时候只显示在一行
			NSMutableAttributedString *replaceStr = [[NSMutableAttributedString alloc] initWithString:kEmojiReplaceCharacter];
			NSRange __range = NSMakeRange([attrStr length], 1);
			[attrStr appendAttributedString:replaceStr];
            if (otherAppendStr) { //有其他需要添加的
                [attrStr appendAttributedString:otherAppendStr];
            }
            
			// 定义回调函数
			CTRunDelegateCallbacks callbacks;
			callbacks.version = kCTRunDelegateCurrentVersion;
			callbacks.getAscent = ascentCallback;
			callbacks.getDescent = descentCallback;
			callbacks.getWidth = widthCallback;
			callbacks.dealloc = deallocCallback;
            
			// 这里设置下需要绘制的图片的大小，这里我自定义了一个结构体以便于存储数据
			CustomGlyphMetricsRef metrics = malloc(sizeof(CustomGlyphMetrics));
            metrics->width = emojiWith;
			metrics->ascent = 1 / (1 + kAscentDescentScale) * metrics->width;
			metrics->descent = metrics->ascent * kAscentDescentScale;
			CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, metrics);
			[attrStr addAttribute:(NSString *)kCTRunDelegateAttributeName
                            value:(__bridge id)delegate
                            range:__range];
			CFRelease(delegate);
            
			// 设置自定义属性，绘制的时候需要用到
			[attrStr addAttribute:kCustomGlyphAttributeImageName
                            value:imageName
                            range:__range];
		} else {
			[attrStr appendAttributedString:emojiKey];
		}
    }
    if (location < [emojiText length]) {
        NSRange range = NSMakeRange(location, [emojiText length] - location);
        NSAttributedString *attrSubStr = [emojiText attributedSubstringFromRange:range];
        [attrStr appendAttributedString:attrSubStr];
    }
    return attrStr;
}


- (void)setText:(id)text
{
    NSParameterAssert(!text || [text isKindOfClass:[NSAttributedString class]] || [text isKindOfClass:[NSString class]]);
    
    if (self.ignoreSetText) {
        [super setText:text];
        return;
    }
    
    if (!text) {
        self.emojiText = nil;
        [super setText:nil];
        return;
    }
    
    //记录下原始的留作备份使用
    self.emojiText = text;
    
    NSMutableAttributedString *mutableAttributedString = nil;
    
    if (self.disableEmoji) {
        mutableAttributedString = [text isKindOfClass:[NSAttributedString class]] ? [text mutableCopy] : [[NSMutableAttributedString alloc]initWithString:text];
        //直接设置text即可,这里text可能为attrString，也可能为String,使用TTT的默认行为
        [super setText:text];
    }else{
        //如果是String，必须通过setText:afterInheritingLabelAttributesAndConfiguringWithBlock:来添加一些默认属性，例如字体颜色。这是TTT的做法，不可避免
        if([text isKindOfClass:[NSString class]]){
            mutableAttributedString = [self mutableAttributeStringWithEmojiText:[[NSAttributedString alloc] initWithString:text]];
            //这里面会调用 self setText:，所以需要做个标记避免下无限循环
            self.ignoreSetText = YES;
            [super setText:mutableAttributedString afterInheritingLabelAttributesAndConfiguringWithBlock:nil];
            self.ignoreSetText = NO;
        }else{
            mutableAttributedString = [self mutableAttributeStringWithEmojiText:text];
            //这里虽然会调用
            [super setText:mutableAttributedString];
        }
    }
    
    NSRange stringRange = NSMakeRange(0, mutableAttributedString.length);
    
    NSRegularExpression * const regexps[] = {kURLRegularExpression(), kEmailRegularExpression(),kPhoneNumerRegularExpression(), kAtRegularExpression(), kPoundSignRegularExpression()};
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSUInteger maxIndex = self.isNeedAtAndPoundSign ? kURLActionCount : kURLActionCount - 2;
    for (NSUInteger i = 0; i < maxIndex; i++) {
        if (self.disableThreeCommon && i < kURLActionCount - 2) {
            continue;
        }
        NSString *urlAction = kURLActions[i];
        [regexps[i] enumerateMatchesInString:mutableAttributedString.string options:0 range:stringRange usingBlock:^(NSTextCheckingResult *result, __unused NSMatchingFlags flags, __unused BOOL *stop) {
            
            //检查是否和之前记录的有交集，有的话则忽略
            for (NSTextCheckingResult *record in results){
                if (NSMaxRange(NSIntersectionRange(record.range, result.range))>0){
                    return;
                }
            }
            
            //添加链接
            NSString *actionString = [NSString stringWithFormat:@"%@%@",urlAction,[self.text substringWithRange:result.range]];
            
            //这里暂时用NSTextCheckingTypeCorrection类型的传递消息吧
            //因为有自定义的类型出现，所以这样方便点。
            NSTextCheckingResult *aResult = [NSTextCheckingResult correctionCheckingResultWithRange:result.range replacementString:actionString];
            
            [results addObject:aResult];
        }];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    //这里直接调用父类私有方法，好处能内部只会setNeedDisplay一次。一次更新所有添加的链接
    [super performSelector:@selector(addLinksWithTextCheckingResults:attributes:) withObject:results withObject:self.linkAttributes];
#pragma clang diagnostic pop
    
}

#pragma mark - size fit result
- (CGSize)preferredSizeWithMaxWidth:(CGFloat)maxWidth
{
    CGSize size;
    maxWidth = maxWidth - self.textInsets.left - self.textInsets.right;
    size = [self sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    
    if (_emojiCount > 0) {
/**
 * by wuy 主要为解决表情包改变比例后，整行宽度计算后不足引起的少字少表情的情况
 */
        CGFloat emojiWith = self.font.lineHeight * (self.emojiWidthRatioWithLineHeight != 0 ? self.emojiWidthRatioWithLineHeight : kEmojiWidthRatioWithLineHeight);
        CGFloat emojiOriginYOffset = self.font.lineHeight * (self.emojiOriginYOffsetRatioWithLineHeight != 0 ? self.emojiOriginYOffsetRatioWithLineHeight : kEmojiOriginYOffsetRatioWithLineHeight);
        CGFloat emojiHeight = emojiWith - emojiOriginYOffset;
        if (emojiHeight / self.font.lineHeight > 1) {

            int row = size.height/self.font.lineHeight;
            int emojiRow = _emojiCount/(maxWidth/emojiWith) + 1;
            if (row == 1) {//只有一行时
                CGFloat widthIncrease = _emojiCount * (emojiWith - self.font.lineHeight);
                widthIncrease = _emojiCount * 4.0;
                if ((widthIncrease + size.width) > maxWidth) {
                    size.width = maxWidth;
                    size.height += emojiHeight;
                } else {
                    size.width += widthIncrease;
                }
            } else {
                if (emojiRow-row>0) {
                    size.width = maxWidth;
                    size.height += emojiHeight*(emojiRow-row);
                }
            }
        }
    }
    
    return size;
}

#pragma mark - setter
- (void)setIsNeedAtAndPoundSign:(BOOL)isNeedAtAndPoundSign
{
    _isNeedAtAndPoundSign = isNeedAtAndPoundSign;
    self.text = self.emojiText; //简单重新绘制处理下
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode
{
    [super setLineBreakMode:lineBreakMode];
    self.text = self.emojiText; //简单重新绘制处理下
}

- (void)setDisableEmoji:(BOOL)disableEmoji
{
    _disableEmoji = disableEmoji;
    self.text = self.emojiText; //简单重新绘制处理下
}

- (void)setDisableThreeCommon:(BOOL)disableThreeCommon
{
    _disableThreeCommon = disableThreeCommon;
    self.text = self.emojiText; //简单重新绘制处理下
}

- (void)setCustomEmojiRegex:(NSString *)customEmojiRegex
{
    _customEmojiRegex = customEmojiRegex;
    
    if (customEmojiRegex && customEmojiRegex.length>0) {
        self.customEmojiRegularExpression = [[MLEmojiLabelRegexPlistManager sharedInstance]regularExpressionForRegex:customEmojiRegex];
    }else{
        self.customEmojiRegularExpression = nil;
    }
    
    self.text = self.emojiText; //简单重新绘制处理下
}

- (void)setCustomEmojiNewRegex:(NSString *)customEmojiNewRegex
{
    _customEmojiNewRegex = customEmojiNewRegex;
    
    if (customEmojiNewRegex && customEmojiNewRegex.length>0) {
        self.customEmojiNewRegularExpression = [[MLEmojiLabelRegexPlistManager sharedInstance]regularExpressionForRegex:customEmojiNewRegex];
    }else{
        self.customEmojiNewRegularExpression = nil;
    }
    
    self.text = self.emojiText; //简单重新绘制处理下
}

- (void)setCustomEmojiNewPlistName:(NSString *)customEmojiNewPlistName {
    if (customEmojiNewPlistName && customEmojiNewPlistName.length > 0 && ![[customEmojiNewPlistName lowercaseString] hasSuffix:@".plist"]) {
        customEmojiNewPlistName = [customEmojiNewPlistName stringByAppendingString:@".plist"];
    }

    _customEmojiNewPlistName = customEmojiNewPlistName;

    if (customEmojiNewPlistName && customEmojiNewPlistName.length>0) {
        self.customEmojiNewDictionary = [[MLEmojiLabelRegexPlistManager sharedInstance]emojiDictForKey:customEmojiNewPlistName];
    }else{
        self.customEmojiNewDictionary = nil;
    }

    self.text = self.emojiText; //简单重新绘制处理下
}

- (void)setCustomEmojiPlistName:(NSString *)customEmojiPlistName
{
    if (customEmojiPlistName && customEmojiPlistName.length > 0 && ![[customEmojiPlistName lowercaseString] hasSuffix:@".plist"]) {
        customEmojiPlistName = [customEmojiPlistName stringByAppendingString:@".plist"];
    }
    
    _customEmojiPlistName = customEmojiPlistName;
    
    if (customEmojiPlistName && customEmojiPlistName.length>0) {
	    self.customEmojiDictionary = [[MLEmojiLabelRegexPlistManager sharedInstance]emojiDictForKey:customEmojiPlistName];
    }else{
        self.customEmojiDictionary = nil;
    }
    
    self.text = self.emojiText; //简单重新绘制处理下
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.text = self.emojiText; //简单重新绘制处理下
}


#pragma mark - select link override
//PS:此处是在TTT代码里添加一个供继承的行为
- (BOOL)didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result
{
    if (result.resultType == NSTextCheckingTypeCorrection) {
        //判断消息类型
        for (NSUInteger i = 0; i < kURLActionCount; i++) {
            if ([result.replacementString hasPrefix:kURLActions[i]]) {
                NSString *content = [result.replacementString substringFromIndex:kURLActions[i].length];
                if(self.delegate && [self.delegate respondsToSelector:@selector(mlEmojiLabel:didSelectLink:withType:)]){
                    //type的数组和i刚好对应
                    [self.delegate mlEmojiLabel:self didSelectLink:content withType:i];
                    return YES;
                }
                return NO;
            }
        }
    }
    return NO;
}

#pragma mark - UIResponderStandardEditActions
- (void)copy:(__unused id)sender {
    if (!self.emojiText) {
        return;
    }
    
    NSString *text = [self.emojiText isKindOfClass:[NSAttributedString class]]?((NSAttributedString *)self.emojiText).string:self.emojiText;
    
    if (text.length > 0) {
        [[UIPasteboard generalPasteboard] setString:text];
    }
}

#pragma mark - 快速生产plist方法
//- (void)initPlist
//{
//    NSString *testString = @"/::)/::~/::B/::|/:8-)/::</::$/::X/::Z/::'(/::-|/::@/::P/::D/::O/::(/::+/:--b/::Q/::T/:,@P/:,@-D/::d/:,@o/::g/:|-)/::!/::L/::>/::,@/:,@f/::-S/:?/:,@x/:,@@/::8/:,@!/:!!!/:xx/:bye/:wipe/:dig/:handclap/:&-(/:B-)/:<@/:@>/::-O/:>-|/:P-(/::'|/:X-)/::*/:@x/:8*/:pd/:<W>/:beer/:basketb/:oo/:coffee/:eat/:pig/:rose/:fade/:showlove/:heart/:break/:cake/:li/:bome/:kn/:footb/:ladybug/:shit/:moon/:sun/:gift/:hug/:strong/:weak/:share/:v/:@)/:jj/:@@/:bad/:lvu/:no/:ok/:love/:<L>/:jump/:shake/:<O>/:circle/:kotow/:turn/:skip/:oY";
//    NSMutableArray *testArray = [NSMutableArray array];
//    NSMutableDictionary *testDict = [NSMutableDictionary dictionary];
//    [kSlashEmojiRegularExpression() enumerateMatchesInString:testString options:0 range:NSMakeRange(0, testString.length) usingBlock:^(NSTextCheckingResult *result, __unused NSMatchingFlags flags, __unused BOOL *stop) {
//        [testArray addObject:[testString substringWithRange:result.range]];
//        [testDict setObject:[NSString stringWithFormat:@"Expression_%u",testArray.count] forKey:[testString substringWithRange:result.range]];
//    }];
//    
//    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *doc = [NSString stringWithFormat:@"%@/expression.plist",documentDir];
//    NSLog(@"%@,length:%u",doc,testArray.count);
//    if ([testArray writeToFile:doc atomically:YES]) {
//        NSLog(@"归档expression.plist成功");
//    }
//    doc = [NSString stringWithFormat:@"%@/expressionImage.plist",documentDir];
//    if ([testDict writeToFile:doc atomically:YES]) {
//        NSLog(@"归档到expressionImage.plist成功");
//    }
//    
//    //    NSString *testString = @"[微笑][撇嘴][色][发呆][得意][流泪][害羞][闭嘴][睡][大哭][尴尬][发怒][调皮][呲牙][惊讶][难过][酷][冷汗][抓狂][吐][偷笑][愉快][白眼][傲慢][饥饿][困][惊恐][流汗][憨笑][悠闲][奋斗][咒骂][疑问][嘘][晕][疯了][衰][骷髅][敲打][再见][擦汗][抠鼻][鼓掌][糗大了][坏笑][左哼哼][右哼哼][哈欠][鄙视][委屈][快哭了][阴险][亲亲][吓][可怜][菜刀][西瓜][啤酒][篮球][乒乓][咖啡][饭][猪头][玫瑰][凋谢][嘴唇][爱心][心碎][蛋糕][闪电][炸弹][刀][足球][瓢虫][便便][月亮][太阳][礼物][拥抱][强][弱][握手][胜利][抱拳][勾引][拳头][差劲][爱你][NO][OK][爱情][飞吻][跳跳][发抖][怄火][转圈][磕头][回头][跳绳][投降]";
//    //    NSMutableArray *testArray = [NSMutableArray array];
//    //    NSMutableDictionary *testDict = [NSMutableDictionary dictionary];
//    //    [kEmojiRegularExpression() enumerateMatchesInString:testString options:0 range:NSMakeRange(0, testString.length) usingBlock:^(NSTextCheckingResult *result, __unused NSMatchingFlags flags, __unused BOOL *stop) {
//    //        [testArray addObject:[testString substringWithRange:result.range]];
//    //        [testDict setObject:[NSString stringWithFormat:@"Expression_%ld",testArray.count] forKey:[testString substringWithRange:result.range]];
//    //    }];
//    //    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    //    NSString *doc = [NSString stringWithFormat:@"%@/expression.plist",documentDir];
//    //    NSLog(@"%@,length:%ld",doc,testArray.count);
//    //    if ([testArray writeToFile:doc atomically:YES]) {
//    //        NSLog(@"归档expression.plist成功");
//    //    }
//    //    doc = [NSString stringWithFormat:@"%@/expressionImage.plist",documentDir];
//    //    if ([testDict writeToFile:doc atomically:YES]) {
//    //        NSLog(@"归档到expressionImage.plist成功");
//    //    }
//    
//    
//}

@end
