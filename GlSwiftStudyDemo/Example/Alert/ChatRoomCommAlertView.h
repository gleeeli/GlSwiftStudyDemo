//
//  ChatRoomFreeMicInviteAlertView.h
//  ChatRoomModule
//
//  Created by liguanglei on 2023/7/26.
//

#import <UIKit/UIKit.h>
#import "ChatRoomCommAlertModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatRoomCommAlertView : UIView

@property(nonatomic, strong, readonly) UIView *contentView;
@property(nonatomic, strong, readonly) UIImageView *bgImageView;
@property(nonatomic, strong, readonly) UILabel *titleLabel;
@property(nonatomic, strong, readonly) UIButton *cancelBtn;
@property(nonatomic, strong, readonly) UIButton *sureBtn;
@property(nonatomic, strong, readonly) UILabel *bottomLabel;
@property(nonatomic, strong, readonly) UIStackView *btnsStackView;
@property(nonatomic, strong, readonly) UILabel *subTitleLabel;

@property(nonatomic, strong) NSObject * _Nullable alertManager;

- (instancetype)initWithModel:(ChatRoomCommAlertModel *)model;
- (void)show:(UIView *)onView;

- (void)dismiss;

@end


typedef NS_ENUM(NSInteger, ChatRoomCommAlertButtonType) {
    ChatRoomCommAlertButtonNormal  = 0,
    ChatRoomCommAlertButtonSelected  = 1,//选中带边框
};
@interface ChatRoomCommAlertButton : UIButton
@property (nonatomic, assign) ChatRoomCommAlertButtonType customBtnType;
@property (nonatomic, strong) UIImageView *selImageView;

@end

NS_ASSUME_NONNULL_END
