//
//  ObjectiveCViewController.m
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/5/5.
//  Copyright © 2023 gleeeli. All rights reserved.
//

#import "ObjectiveCViewController.h"
#import <CoreText/CoreText.h>

@interface ObjectiveCViewController ()
@property(nonatomic, strong) UILabel *label;
@end

@implementation ObjectiveCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, UIScreen.mainScreen.bounds.size.width, 300)];
    _label.textColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    //这次是需要的行1
    //这次需要回滚的行1
    
//    [self test2];
//
//    NSString *curProgress = @"";
//    NSString *allProgress = @"1";
//
//    NSString *allText = [NSString stringWithFormat:@"%@/%@", curProgress, allProgress];
//    NSMutableAttributedString *muAttr = [[NSMutableAttributedString alloc] initWithString:allText];
//    [muAttr addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:NSMakeRange(0, curProgress.length)];
//    self.label.attributedText = muAttr;
    [self test3];
}

- (void)test3 {
    NSString *test123 = @"12345哈哈";
    NSData *data=[NSMutableData dataWithData:[test123 dataUsingEncoding:NSUTF8StringEncoding]];
    unsigned char *bytePtr = (unsigned char *)[data bytes];
    
    NSString *str16 = @"";
    NSInteger totalData = [data length] / sizeof(uint8_t);
    for (int i = 0 ; i < totalData; i ++)
    {
        str16 = [NSString stringWithFormat:@"%@%x", str16, bytePtr[i]];
    }
    NSLog(@"data byte chunk:%@", str16);
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSLog(@"二进制字符串：%@", jsonStr);
    
    NSString *binaryString = @"11000100110010001100110011010000110101111001011001001110001000111001011001001110001000";
    unsigned int intValue = (unsigned int)strtoul([binaryString UTF8String], NULL, 2);
    NSString *hexString = [NSString stringWithFormat:@"%X", intValue];
    NSLog(@"手动转结果：%@", hexString);
}

- (void)test2 {
    NSString *content = @"";// @"红娘%s邀请你免费%s上麦%s";
    NSArray *replaceStrs = @[@"使用特权",@"liguanglei",@"看看"];
    
    NSArray *arr = [content componentsSeparatedByString:@"%s"];
    NSMutableArray *muRangs = [[NSMutableArray alloc] init];
    
    NSString *realContent = @"";
    int startReplaceIndex = 0;
    for (int i = 0; i < [arr count]; i++) {
        realContent = [NSString stringWithFormat:@"%@%@",realContent,arr[i]];
        
        if (startReplaceIndex < [replaceStrs count]) {//有替代文本
            if (i == [arr count] - 1) {//特殊情况：字符串最后并没有%s符号，但replaceStrs有值，
                if (content.length > 2) {
                    NSString *lastStr = [content substringFromIndex:content.length - 2];
                    if (![lastStr isEqualToString:@"%s"]) {
                        break;;
                    }
                }else {
                    break;
                }
                
            }
            
            NSString *insertCon = replaceStrs[startReplaceIndex];
            NSRange range = NSMakeRange(realContent.length, insertCon.length);
            if(insertCon.length > 0) {
                realContent = [NSString stringWithFormat:@"%@%@",realContent, insertCon];
                [muRangs addObject:NSStringFromRange(range)];
            }
            startReplaceIndex ++;
        }
    }
    
    NSLog(@"content:%@", realContent);
    
    NSMutableAttributedString *muattr = [[NSMutableAttributedString alloc] initWithString:realContent];
    
    for (int i = 0; i < [muRangs count]; i++) {
        NSRange range = NSRangeFromString(muRangs[i]);
        [muattr addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:range];
    }
    
    self.label.attributedText = muattr;
}

- (void)test1 {
    NSString *nowStr = @"1234";
    NSMutableArray *ocArray = [[NSMutableArray alloc] init];
    [ocArray addObject:nowStr];
    [ocArray addObject:@"444444444444444444444444"];
    
    NSString *nowStr2 = @"1234";
    
    NSLog(@"地址比较：%p，%p",&nowStr, &nowStr2);
    if ([ocArray containsObject:nowStr2]) {
        NSLog(@"包含：%@",nowStr);
    }else {
        NSLog(@"不包含：%@",nowStr);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
