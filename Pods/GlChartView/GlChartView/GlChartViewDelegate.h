//
//  GlChartViewDelegate.h
//  YKCharts
//
//  Created by gleeeli on 2018/8/24.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlChartConfig.h"

@protocol GlChartViewDelegate <NSObject>
- (NSArray *)glPopClickShowContent:(GlChartConfig *)dataSource index:(NSInteger)index;
@end
