//
//  ObjectiveCViewController.m
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/5/5.
//  Copyright © 2023 gleeeli. All rights reserved.
//

#import "ObjectiveCViewController.h"

@interface ObjectiveCViewController ()

@end

@implementation ObjectiveCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
