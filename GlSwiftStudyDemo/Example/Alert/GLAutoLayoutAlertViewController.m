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

@end

@implementation GLAutoLayoutAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    ChatRoomCommAlertModel *model = [[ChatRoomCommAlertModel alloc] init];
    model.title = @"确认选中吗？";
    model.cancelBtnTitle = @"取消";
    model.sureBtnTitle = @"确认";

    __weak typeof(self) weakself = self;
    model.bottomViewBlock = ^UIView * _Nonnull(UIView * _Nonnull contentView, UIView * _Nonnull topView) {
        UIButton *changesBtn = [[UIButton alloc] init];
        [changesBtn setTitle:[NSString stringWithFormat:@" 次数/总机会%d/%d",4, 5] forState:UIControlStateNormal];
        [contentView addSubview:changesBtn];
        changesBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [changesBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [changesBtn setImage:[UIImage imageNamed:@"chatroom_comm_unselected"] forState:UIControlStateNormal];
        [changesBtn setImage:[UIImage imageNamed:@"chatroom_comm_selected"] forState:UIControlStateSelected];
        [changesBtn addTarget:weakself action:@selector(changesBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
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
    
    ChatRoomCommAlertView *alertView = [[ChatRoomCommAlertView alloc] initWithModel:model];
    //防止释放
    alertView.alertManager = self;
    [alertView show:self.view];
}

- (void)changesBtnClick {
    
}

@end
