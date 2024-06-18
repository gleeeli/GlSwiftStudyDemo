//
//  GlCommObjectManager.m
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2024/6/18.
//  Copyright © 2024 gleeeli. All rights reserved.
//

#import "GlCommObjectManager.h"

#import <GPUUtilization/GPUUtilization.h>
#import <DoraemonKit/DoraemonKit.h>
#import <GlChartView/GlLineChartView.h>

@interface GlCommObjectManager ()
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) GlLineChartView *glChartView;
@property (nonatomic, strong) NSMutableArray *muCpuArray;
@property (nonatomic, strong) NSMutableArray *xDescriptionDataSourceArray;

@end
@implementation GlCommObjectManager


- (void)launchAppWithWindow:(UIWindow *)window {
    self.window = window;
    [self addGPUTest:window];
    
    [[DoraemonManager shareInstance] install];
}

- (void)addGPUTest:(UIWindow *)window {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.5
                                                repeats:YES
                                                  block:^(NSTimer * timer) {
            [GPUUtilization fetchCurrentUtilization:^(GPUUtilization *current) {
                [self.muCpuArray addObject:[NSNumber numberWithInteger:current.deviceUtilization]];
                
                NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
                [dataFormatter setDateFormat:@"mm:ss.SSS"];
                NSString *dateStr = [dataFormatter stringFromDate:[NSDate date]];
                
                [self.xDescriptionDataSourceArray addObject:dateStr];
                
                if ([self.muCpuArray count] > 10) {
                    [self.muCpuArray removeObjectAtIndex:0];
                    [self.xDescriptionDataSourceArray removeObjectAtIndex:0];
                }
                
                [self drawGpuLine];
            }];
        }];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    });
}

- (void)drawGpuLine {
    //y轴
    GlChartConfig *config = [GlChartConfig getCommConfig];
    config.iscurtailX = YES;
    config.speed = 0;
    config.lineColors = [NSArray arrayWithObjects:[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor cyanColor],[UIColor blueColor], nil];
    
    config.ySuffix = @"%";
    config.xDescriptionDataSource = self.xDescriptionDataSourceArray;
    config.originNumbers = self.muCpuArray;//,@(90.72)
    config.minValue = 0;
    config.maxValue = 100;
    config.linesCountY = 10;
    //----------------------------------
    CGSize windowsize = self.window.frame.size;
    CGFloat bottom = self.window.safeAreaInsets.bottom;
    
    if (self.glChartView.superview == nil) {
        GlLineChartView *glChartView = [[GlLineChartView alloc] initWithFrame:CGRectMake(0, windowsize.height - 130 - bottom, windowsize.width, 130)];
        glChartView.userInteractionEnabled = NO;
        self.glChartView = glChartView;
        glChartView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self.window addSubview:glChartView];
    }
    
    [self.glChartView setupwithConfgi:config];
}

- (NSMutableArray *)muCpuArray {
    if (!_muCpuArray) {
        _muCpuArray = [[NSMutableArray alloc] init];
    }
    return _muCpuArray;
}

- (NSMutableArray *)xDescriptionDataSourceArray {
    if (!_xDescriptionDataSourceArray) {
        _xDescriptionDataSourceArray = [[NSMutableArray alloc] init];
    }
    
    return _xDescriptionDataSourceArray;
}
@end
