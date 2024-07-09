//
//  TestCollectionCollectionViewCell.m
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2024/7/9.
//  Copyright © 2024 gleeeli. All rights reserved.
//

#import "TestCollectionCollectionViewCell.h"

@implementation TestCollectionCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if(self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    [self.contentView addSubview:self.label];
}

- (UILabel *)label {
    if(!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 30)];
        _label.textColor = [UIColor whiteColor];
    }
    return _label;
}

@end
