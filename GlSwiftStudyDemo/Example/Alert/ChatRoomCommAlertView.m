//
//  ChatRoomFreeMicInviteAlertView.m
//  ChatRoomModule
//
//  Created by liguanglei on 2023/7/26.
//

#import "ChatRoomCommAlertView.h"
#import <Masonry/Masonry.h>

@interface ChatRoomCommAlertView ()

@property(nonatomic, strong) UIView *lastConBottomView;
@property(nonatomic, strong) ChatRoomCommAlertModel *model;
@property(nonatomic, assign) CGFloat btnHeight;
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIImageView *bgImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *cancelBtn;
@property(nonatomic, strong) UIButton *sureBtn;
@property(nonatomic, strong) UIButton *closeBtn;
@property(nonatomic, strong) UILabel *bottomLabel;
@property(nonatomic, strong) UIStackView *btnsStackView;
@property(nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation ChatRoomCommAlertView
- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (instancetype)initWithModel:(ChatRoomCommAlertModel *)model {
    self  = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self){
        _model = model;
        self.btnHeight = 40;
        [self setUI];
        if(model.dismissTime > 0) {
            [self performSelector:@selector(autoDimissEvent) withObject:self afterDelay:model.dismissTime];
        }
    }
    return self;
}

- (void)setTagEvent {
    //加上不然会触发个人主页弹窗的取消
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)setUI {
    [self setTagEvent];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 16;
    self.contentView.layer.masksToBounds = YES;
    [self addSubview:self.contentView];
    
    self.bgImageView = [[UIImageView alloc] init];
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    //self.bgImageView.image = [UIImage chatroom_imageNamed:@"chatroom_likehall_bg_alert"];
    [self.contentView addSubview:self.bgImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.text = self.model.title;
    self.lastConBottomView = self.titleLabel;
    
    if(self.model.showRightCloseBtn) {
        [self.contentView addSubview:self.closeBtn];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(2);
            make.trailing.equalTo(self.contentView).offset(-12);
            make.width.height.mas_equalTo(24);
        }];
    }
    
    
    if (![self isEmpty:self.model.subTitle]) {
        self.subTitleLabel = [[UILabel alloc] init];
        self.subTitleLabel.font = [UIFont systemFontOfSize:14];
        self.subTitleLabel.textColor = [UIColor colorWithRed:112/255.0 green:114/255.0 blue:119/255.0 alpha:1];
        self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.subTitleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.subTitleLabel];
        self.subTitleLabel.text = self.model.subTitle;
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
            make.leading.equalTo(self.contentView).offset(12);
            make.trailing.equalTo(self.contentView).offset(-12);
        }];
        self.lastConBottomView = self.subTitleLabel;
    }
    
    if(self.model.centerViewBlock) {
        UIView *centerContentView = self.model.centerViewBlock(self.contentView, self.lastConBottomView);
        self.lastConBottomView = centerContentView;
    }
    
    BOOL isNeedStackView = NO;
    if (![self isEmpty:self.model.cancelBtnTitle]) {
        isNeedStackView = YES;
        [self.cancelBtn setTitle:self.model.cancelBtnTitle forState:UIControlStateNormal];
        [self.btnsStackView addArrangedSubview:self.cancelBtn];
    }
    
    if (![self isEmpty:self.model.sureBtnTitle]) {
        isNeedStackView = YES;
        [self.sureBtn setTitle:self.model.sureBtnTitle forState:UIControlStateNormal];
        [self.btnsStackView addArrangedSubview:self.sureBtn];
    }
    
    if (isNeedStackView) {
        [self.contentView addSubview:self.btnsStackView];
        [self.btnsStackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lastConBottomView.mas_bottom).offset(16);
            make.leading.equalTo(self.contentView).offset(16);
            make.trailing.equalTo(self.contentView).offset(-16);
            make.height.mas_equalTo(self.btnHeight);
        }];
        self.lastConBottomView = self.btnsStackView;
    }
    
    if (self.model.bottomViewBlock != nil) {
        UIView *bottomView = self.model.bottomViewBlock(self.contentView, self.lastConBottomView);
        self.lastConBottomView = bottomView;
    }
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.trailing.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView).offset(16);
    }];
    
    
    [self refreshLayout];
}

- (void)tapAction:(UIGestureRecognizer *)gesture {
    if(self.model.isClickSpaceCancel) {
        if (self.model.eventBlock != nil) {
            self.model.eventBlock(ChatRoomCommAlertEventClickSpaceCancel);
        }
        [self dismiss];
    }
}

- (void)refreshLayout {//底部自适应高度
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(self.model.defaultContentWidth);
        
        if (self.lastConBottomView) {
            make.bottom.equalTo(self.lastConBottomView).offset(16);
        }
    }];
}

//MARK: Action
- (void)sureBtnClick:(UIButton *)btn {
    if (self.model.eventBlock != nil) {
        self.model.eventBlock(ChatRoomCommAlertEventSure);
    }
    [self dismiss];
}

- (void)cancelBtnClick:(UIButton *)btn {
    if (self.model.eventBlock != nil) {
        self.model.eventBlock(ChatRoomCommAlertEventCancel);
    }
    [self dismiss];
}

- (void)closeBtnClick:(UIButton *)btn {
    if (self.model.eventBlock != nil) {
        self.model.eventBlock(ChatRoomCommAlertEventCancel);
    }
    [self dismiss];
}

- (void)autoDimissEvent {
    if (self.model.eventBlock != nil) {
        self.model.eventBlock(ChatRoomCommAlertEventAutoCancel);
    }
    [self dismiss];
}

//MARK: Public
- (void)show:(UIView *)onView {
    self.frame = onView.bounds;
    [onView addSubview:self];
}
    
- (void)dismiss {
    self.alertManager = nil;
    [self removeFromSuperview];
}

- (BOOL)isEmpty:(NSString *)str {
    if(str == nil || [str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

- (UIStackView *)btnsStackView {
    if (_btnsStackView == nil) {
        _btnsStackView = [[UIStackView alloc] init];
        _btnsStackView.axis = UILayoutConstraintAxisHorizontal;
        _btnsStackView.alignment = UIStackViewAlignmentFill;
        _btnsStackView.spacing = 12;
        _btnsStackView.distribution = UIStackViewDistributionFillEqually;
    }
    
    return _btnsStackView;
}
- (UIButton *)sureBtn {
    if(_sureBtn == nil) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 238, self.btnHeight)];
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sureBtn.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:234/255.0 blue:99/255.0 alpha:1].CGColor;
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _sureBtn.layer.cornerRadius = self.btnHeight * 0.5;
        _sureBtn.layer.masksToBounds = YES;
        [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sureBtn;
}

- (UIButton *)cancelBtn {
    if(_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 238, self.btnHeight)];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBtn.layer.backgroundColor = [UIColor colorWithRed:245/255.0 green:247/255.0 blue:250/255.0 alpha:1].CGColor;
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _cancelBtn.layer.cornerRadius = self.btnHeight * 0.5;
        _cancelBtn.layer.masksToBounds = YES;
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelBtn;
}

- (UIButton *)closeBtn {
    if(!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        //[_closeBtn setImage:[UIImage chatroom_imageNamed:@"chatroom_c_close_black"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end


@implementation ChatRoomCommAlertButton
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if(self) {
        [self addSubview:self.selImageView];
        [self.selImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(2);
            make.trailing.equalTo(self).offset(-2);
        }];
    }
    return self;
}
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if(self.customBtnType == ChatRoomCommAlertButtonSelected) {
        if(self.selected) {
            self.layer.borderWidth = 1.5;
            [self bringSubviewToFront:self.selImageView];
            self.selImageView.hidden = NO;
        }else {
            self.layer.borderWidth = 0;
            self.selImageView.hidden = YES;
        }
    }
}

- (UIImageView *)selImageView {
    if(!_selImageView) {
        _selImageView = [[UIImageView alloc] init];
        _selImageView.image = [UIImage imageNamed:@"chatroom_comm_selected"];
        _selImageView.hidden = YES;
    }
    return _selImageView;
}
@end
