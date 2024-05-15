//
//  GlAddClickButton.m
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2024/5/15.
//  Copyright © 2024 gleeeli. All rights reserved.
//

#import "GlAddClickButton.h"

@implementation GlAddClickButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clickEdge = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.clickEdge);
    return CGRectContainsPoint(hitFrame, point);
}

@end
