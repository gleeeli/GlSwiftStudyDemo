//
//  ObjectiveCViewController.m
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/5/5.
//  Copyright © 2023 gleeeli. All rights reserved.
//

#import "ObjectiveCViewController.h"
#import <CoreText/CoreText.h>
#import "TestModel.h"
#import "ChatRoomCommRedView.h"
#import <Masonry/Masonry.h>
#import "GLCommHeader.h"
#import "ChatRoomLikeFillInformationAlertView.h"
#import "GlAddClickButton.h"


@interface ObjectiveCViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableSet *itemUUids;
@property (nonatomic, strong) NSString *testuuid;
@property (nonatomic, copy) NSString *testGetSet;

@property (nonatomic, strong) ChatRoomCommRedView *redOfHeartRateView;
@property (nonatomic, strong) dispatch_semaphore_t sem;
@end

@implementation ObjectiveCViewController
//这次需要回滚的行2
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger cur = 3.0/4.0;
    NSLog(@"cur:%zd", cur);
    
//    //增加点击范围
//    //666777
//    GlAddClickButton *button = [[GlAddClickButton alloc] initWithFrame:CGRectMake(10, 180, 100, 44)];
//    button.clickEdge = UIEdgeInsetsMake(-20, -20, -20, -20);
//    button.backgroundColor = [UIColor greenColor];
//    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    
//    
//    UIButton *glBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 250, 100, 44)];
//    glBtn.backgroundColor = [UIColor redColor];
//    [glBtn addTarget:self action:@selector(glBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:glBtn];
    
//    _testGetSet = @"hhhha";
//    NSString *name1 = self.testGetSet;
//    NSString *name = self->_testGetSet;
//    NSLog(@"name1:%@, name:%@", name1, name);
//
//    UITapGestureRecognizer *tagGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(giftTagEvent:)];
//    [self.view addGestureRecognizer:tagGest];
//
//    UILabel *testView = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
//    testView.backgroundColor = [UIColor redColor];
//    testView.userInteractionEnabled = YES;
//    [self.view addSubview:testView];
//
////    UITapGestureRecognizer *tagGest2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(giftTagEvent2:)];
////    [testView addGestureRecognizer:tagGest2];
//
//    NSString *allStr = @"123456";
//    NSRange range = [allStr rangeOfString:@"8"];
//    NSMutableAttributedString *allValueAttrs = [[NSMutableAttributedString alloc] init];
//    if (range.location != NSNotFound) {
//        [allValueAttrs addAttributes:@{NSForegroundColorAttributeName: COLOR_C5} range:range];
//    }
//
//    testView.attributedText = allValueAttrs;
}

- (void)buttonClick:(UIButton *)btn {
    NSLog(@"点击xxxx");
}

- (void)giftTagEvent:(UIGestureRecognizer *)ges {
    NSLog(@"xx：111");
}

- (void)giftTagEvent2:(UIGestureRecognizer *)ges {
    NSLog(@"xx：222");
}

- (NSString *)testGetSet {
    return _testGetSet;
}

- (void)test3 {
    //
    //    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, UIScreen.mainScreen.bounds.size.width, 300)];
    //    _label.textColor = [UIColor whiteColor];
    //    [self.view addSubview:self.label];
    
    //    [self test2];
    //
    //    NSString *curProgress = @"";
    //    NSString *allProgress = @"1";
    //
    //    NSString *allText = [NSString stringWithFormat:@"%@/%@", curProgress, allProgress];
    //    NSMutableAttributedString *muAttr = [[NSMutableAttributedString alloc] initWithString:allText];
    //    [muAttr addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:NSMakeRange(0, curProgress.length)];
    //    self.label.attributedText = muAttr;
    //    [self test3];
    //    [self testShape];
//    [self testDelay];
    
//    [self timeDelay];
    
//    [self testImageView];
    
//    [self startAsync];
//    [self testNan];
//    NSString * str = [self.class  overOneWShow:@"10001"];
//    NSLog(@"当前是：%@", str);
    
//    [self testNum:0.1234];
    
//
//    UILabel *testLabel = [[UILabel alloc] init];
//    testLabel.font = [UIFont systemFontOfSize:TH_FONT_B2_FIT];
//    testLabel.textColor = [UIColor whiteColor];
//    testLabel.layer.borderColor = [UIColor whiteColor].CGColor;
//    testLabel.layer.borderWidth = 1;
//    testLabel.text = @"哈哈哈哈哈123hhhhhhcc";
//    [self.view addSubview:testLabel];
//    [testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }];
    
//
    //iphone14:17
    //    ChatRoomLikeHallFillInfoAModel *model = [[ChatRoomLikeHallFillInfoAModel alloc] init];
    //    model.delistingNumber = @"12345";
    //    model.age = @"25";
    //    model.cityName = @"深圳市";
    //    model.constellation = @"巨蟹座";
    //
    //    NSArray *titles = @[@"单身", @"离异", @"丧偶"];
    //    NSMutableArray *muArray = [[NSMutableArray alloc] init];
    //    for (int i = 0; i < 3; i++) {
    //        ChatRoomLikeHallTagModel *tagModel = [[ChatRoomLikeHallTagModel alloc] init];
    //        tagModel.text  = titles[i];
    //        if(i < 1) {
    //            tagModel.isSelect = YES;
    //        }
    //        [muArray addObject:tagModel];
    //    }
    //    model.affectivestatusInfo = muArray;
    //
    //    NSArray *titles2 = @[@"单身", @"离异", @"丧偶"];
    //    NSMutableArray *muArray2 = [[NSMutableArray alloc] init];
    //    for (int i = 0; i < 10; i++) {
    //        ChatRoomLikeHallTagModel *tagModel = [[ChatRoomLikeHallTagModel alloc] init];
    //        tagModel.text  = i < titles2.count ? titles[i]: [NSString stringWithFormat:@"单身%d", i];
    //        if(i < 3) {
    //            tagModel.isSelect = YES;
    //        }
    //        [muArray2 addObject:tagModel];
    //    }
    //    model.mateSelectionInfo = muArray2;
    //
    //
    //    ChatRoomLikeFillInformationAlertView *alertView = [[ChatRoomLikeFillInformationAlertView alloc] initWithModel:model];
    //    [self.view addSubview:alertView];
}

- (void)testFloat {
    NSDecimalNumber*numDecimal = [NSDecimalNumber decimalNumberWithString: @"1.2000"];
    NSString*numString = [NSString stringWithFormat:@"%@", numDecimal];
    NSLog(@"当前是：%@", numString);
    
    CGFloat sin = sinf(0);
    NSLog(@"当前是：%f", sin);
}

- (void)testGetLocalJsonFile {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"blTestjson" ofType:@"json"];
    //获取文件内容
    NSString *jsonStr  = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //将文件内容转成数据
    NSData *jaonData   = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        //将数据转成数组
    NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:jaonData options:NSJSONReadingMutableContainers error:nil];

    NSDictionary *testDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"path:%@", path);
    NSLog(@"testDic:%@", testDic);
}

- (void)testDict {
    NSDictionary *testdict = @{@"result": [NSNumber numberWithBool:NO], @"ddd":@"dd"};
    BOOL result = [testdict objectForKey:@"result"];
    if(result) {
        NSLog(@"ddddresult---YES");
    }else {
        NSLog(@"ddddresult---NO");
    }
}

- (void)testNum:(CGFloat)numf {
    float nowValue = numf * 100;
    if(nowValue > 100) {
        nowValue = 100;
    }
    NSString *onlyOneStr = [NSString stringWithFormat:@"%.1f", nowValue];
    
    NSDecimalNumber*numDecimal = [NSDecimalNumber decimalNumberWithString: onlyOneStr];
    NSString*numString = [NSString stringWithFormat:@"%@", numDecimal];
    NSLog(@"当前是：%@", numString);
}

+ (NSString *)flokeepOnedecimal:(float)fvalue {
    NSString *onlyOneStr = [NSString stringWithFormat:@"%.1f", fvalue];
    
    NSDecimalNumber*numDecimal = [NSDecimalNumber decimalNumberWithString: onlyOneStr];
    NSString*numString = [NSString stringWithFormat:@"%@", numDecimal];
    return numString;
}

//保留一位小数，末尾是0就去掉
+ (NSString *)overOneWShow:(NSString *)originStr {
    float orignCount = [originStr floatValue];
    if(orignCount >= 10000) {
        float wCount = orignCount / 10000;
        
        NSString *onlyOneStr = [NSString stringWithFormat:@"%.1f", wCount];
        
        NSDecimalNumber*numDecimal = [NSDecimalNumber decimalNumberWithString: onlyOneStr];
        NSString*numString = [NSString stringWithFormat:@"%@", numDecimal];
        
        return [NSString stringWithFormat:@"%@w", numString];
    }else {
        return originStr;
    }
}

- (void)testNan {
    CGFloat progress = 100.0 / 0;
    
    UIView *tv = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 4)];
    tv.backgroundColor = [UIColor blueColor];
    tv.layer.cornerRadius = 2;
    tv.layer.masksToBounds = YES;
    [self.view addSubview:tv];
    CGRect ofrmae = tv.frame;
    ofrmae.size.width = self.view.frame.size.width * progress;
    tv.frame = ofrmae;
    NSLog(@"frame:%@", NSStringFromCGRect(tv.frame));
}

- (void)startAsync {
    //创建信号量 值为0
    self.sem = dispatch_semaphore_create(0);
    //开启异步并发线程执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"dispatch_semaphore 2\n");
        sleep(5);
        //发送信号，信号量值+1
        dispatch_semaphore_signal(self.sem);
        NSLog(@"dispatch_semaphore 3\n");
    });
    NSLog(@"dispatch_semaphore 0\n");
    //信号量 值-1 小于0 等待信号。。。
    dispatch_semaphore_wait(self.sem, DISPATCH_TIME_FOREVER);
    NSLog(@"dispatch_semaphore 1\n");
}

- (void)testRed {
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    CGFloat scale = width / 1125.0;
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, width, 570 * scale)];
    bgImageView.image = [UIImage imageNamed:@"chatroom_blinddate_top_bg"];
//    bgImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgImageView];
    
    [self.view addSubview:self.redOfHeartRateView];
    [self.redOfHeartRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view.mas_trailing).offset(-10);
        make.top.equalTo(self.view).offset(150);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
}

- (ChatRoomCommRedView *)redOfHeartRateView {
    if(!_redOfHeartRateView) {
        _redOfHeartRateView = [[ChatRoomCommRedView alloc] init];
//        _redOfHeartRateView.hidden = YES;
    }
    return _redOfHeartRateView;
}


- (void)testArray {
    self.testuuid = @"123456";
    NSString *testUuid = [NSString stringWithFormat:@"%@", @"123456"];
    NSString *testUuid1 = @"123456";
    NSString *testUuid2 = @"123456";
    if(testUuid == testUuid1) {
        NSLog(@"相等");
    }else {
        NSLog(@"不相等");
    }
    if(testUuid1 == testUuid2) {
        NSLog(@"==相等");
    }else {
        NSLog(@"==不相等");
    }
//    TestModel *tmodel = [[TestModel alloc] init];
//    tmodel.testuuid = @"123456";
//
//    TestModel *tmodel2 = [[TestModel alloc] init];
//    tmodel2.testuuid = @"1234567";
//    tmodel2.testuuid = @"123456";
    
    NSLog(@"testUuid:%p, testUuid1: %p, testUuid2: %p", testUuid, testUuid1, testUuid2);
//    NSLog(@"testUuid:%p, testUuid: %p", tmodel.testuuid, tmodel2.testuuid);
    self.itemUUids = [[NSMutableSet alloc] init];
    
    [self.itemUUids addObject:@"hhahh"];
    [self.itemUUids addObject:testUuid];
    
    if([self.itemUUids containsObject:testUuid1]) {
        NSLog(@"包含");
    }else {
        NSLog(@"不包含");
    }
    
    for (NSString *item in self.itemUUids) {
        NSLog(@"testUuid:%p, testUuid: %p", &item, &testUuid1);
        if(item == testUuid1) {
            NSLog(@"遍历-包含");
        }else {
            NSLog(@"遍历-不包含");
        }
    }
}



- (void)testImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 80, 100, 20))];
    imageView.image = [UIImage imageNamed:@"chatroom_heat_hot_icon"];
    [self.view addSubview:imageView];
}


- (void)test {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(30, 150, 100, 200)];
    contentView.backgroundColor =[UIColor redColor];
    
    [self.view addSubview:contentView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemViewTapAction)];
    tapGesture.delegate = self;
    [contentView addGestureRecognizer:tapGesture];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 50, 30)];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor greenColor];
    [contentView addSubview:btn];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = btn.frame;
    imageView.backgroundColor = [UIColor grayColor];
    imageView.alpha = 0.5;
//    imageView.userInteractionEnabled = YES;
    [contentView addSubview:imageView];
}


/** 点击事件*/
- (void)itemViewTapAction {
    NSLog(@"点击内容");
}

- (void)btnclick {
    NSLog(@"点击按钮");
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIView *touchView = touch.view;
    if([touchView isKindOfClass:[UIImageView class]]) {
        return NO;
    }
    return YES;
}

- (void)timeDelay {
    [self cancelTime];
    NSLog(@"AF:开始延迟处理：%fs",3.0);
    _timer = [NSTimer timerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self delayHandle];
    }];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [self cancelDelay];
}

- (void)cancelTime {
    if(_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)testDelay {
    NSTimeInterval time = 3;
    NSLog(@"AF:开始延迟处理：%fs",time);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"AF:开始延迟处理：%@", [NSThread currentThread]);
        [self performSelector:@selector(delayHandle) withObject:self afterDelay:time inModes:@[NSRunLoopCommonModes]];
        NSLog(@"开启runloop");
        [self cancelDelay];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"延迟结束");
    });
    
    
   
}

- (void)cancelDelay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"开始取消延迟。。。");
        [self cancelTime];
//        [NSObject cancelPreviousPerformRequestsWithTarget:self];
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayHandle) object:self];
    });
}
- (void)delayHandle {
    NSLog(@"AF:延迟处理完成");
}

- (void)testShape {
    self.view.backgroundColor = [UIColor whiteColor];
    UIBezierPath *tempPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(120, 150, 100, 50) byRoundingCorners:(UIRectCornerTopLeft |UIRectCornerTopRight |UIRectCornerBottomRight|UIRectCornerBottomLeft) cornerRadii:CGSizeMake(4, 4)];
        UIView *guideView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        guideView.backgroundColor = [UIColor blackColor];
        guideView.alpha = 0.6;
        guideView.layer.mask = [self addTransparencyViewWith:tempPath];
        [[UIApplication sharedApplication].keyWindow addSubview:guideView];
}

- (CAShapeLayer *)addTransparencyViewWith:(UIBezierPath *)tempPath{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:[UIScreen mainScreen].bounds];
    [path appendPath:tempPath];
    path.usesEvenOddFillRule = YES;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor= [UIColor blackColor].CGColor;  //其他颜色都可以，只要不是透明的
    shapeLayer.fillRule=kCAFillRuleEvenOdd;
    return shapeLayer;
}

//这次是需要的行2
- (void)test13 {
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
