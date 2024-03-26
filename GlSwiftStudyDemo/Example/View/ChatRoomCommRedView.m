//
//  ChatRoomCommRedView.m
//  ChatRoomModule
//
//  Created by liguanglei on 2023/9/22.
//

#import "ChatRoomCommRedView.h"

@interface ChatRoomCommRedView()
@property(nonatomic, strong) UIView *centerView;
@end

@implementation ChatRoomCommRedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if(self) {
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [self addSubview:self.centerView];
        
//        self.layer.borderWidth = 5;
//        self.layer.masksToBounds = YES;
//        self.layer.borderColor = [UIColor whiteColor].CGColor;
        [self updateCoreRadius];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateCoreRadius];
}

- (void)updateCoreRadius {
    self.layer.cornerRadius = self.bounds.size.height * 0.5;
    CGFloat borderW = 5;
    CGRect cFrame = self.bounds;
    
    self.centerView.frame = CGRectMake(borderW, borderW, cFrame.size.width - borderW * 2, cFrame.size.height - borderW * 2);
    self.centerView.layer.cornerRadius = self.centerView.frame.size.height * 0.5;
}

- (UIView *)centerView {
    if(!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor redColor];
    }
    return _centerView;
}
@end
