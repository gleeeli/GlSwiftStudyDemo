//
//  GLAutoLayoutAlertViewController.m
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2024/3/26.
//  Copyright © 2024 gleeeli. All rights reserved.
//

#import "GLAutoLayoutAlertViewController.h"
#import "ChatRoomCommAlertView.h"
#import <Masonry/Masonry.h>

@interface GLAutoLayoutAlertViewController ()
@property(nonatomic, strong) ChatRoomCommAlertModel *testModel;
@end

@implementation GLAutoLayoutAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getmyModelWith:_testModel.testNum];
    
    
    ChatRoomCommAlertModel *model = [[ChatRoomCommAlertModel alloc] init];
    model.title = @"确认选中吗？";
    model.cancelBtnTitle = @"取消";
    model.sureBtnTitle = @"确认";

    __weak typeof(self) weakself = self;
    model.bottomViewBlock = ^UIView * _Nonnull(ChatRoomCommAlertView *alertView, UIView * _Nonnull contentView, UIView * _Nonnull topView) {
        UIButton *changesBtn = [[UIButton alloc] init];
        [changesBtn setTitle:[NSString stringWithFormat:@" 次数/总机会%d/%d",4, 5] forState:UIControlStateNormal];
        [contentView addSubview:changesBtn];
        changesBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [changesBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [changesBtn setImage:[UIImage imageNamed:@"chatroom_comm_unselected"] forState:UIControlStateNormal];
        [changesBtn setImage:[UIImage imageNamed:@"chatroom_comm_selected"] forState:UIControlStateSelected];
        [changesBtn addTarget:alertView action:@selector(outViewTouchCommEventHandle:) forControlEvents:UIControlEventTouchUpInside];
        changesBtn.tag = 1111;
        
        [contentView addSubview:changesBtn];
        [changesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (topView != nil) {
                make.top.equalTo(topView.mas_bottom).offset(9);
            }
            make.leading.equalTo(contentView).offset(16);
            make.trailing.equalTo(contentView).offset(-16);
        }];
        
        return  changesBtn;
    };
    
    model.eventBlock = ^(ChatRoomCommAlertEvent event) {
        if (event == ChatRoomCommAlertEventSure) {
//            if (weakself.curChangesBtn.isSelected) {
//                complete(YES);
//            }else {
//                complete(NO);
//            }
        }
    };
    
    model.outViewAllEventBlock = ^(id  _Nonnull sender) {//外部按钮注册的事件
        if([sender isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)sender;
            if(btn.tag == 1111) {
                [self changesBtnClick];
            }
        }
    };
    
    ChatRoomCommAlertView *alertView = [[ChatRoomCommAlertView alloc] initWithModel:model];
    //防止释放
    //alertView.alertManager = self;
    [alertView show:self.view];
}

- (void)getmyModelWith:(NSInteger)modelType {
    NSLog(@"modelType:%zd", modelType);
}

- (void)changesBtnClick {
    
}

@end
