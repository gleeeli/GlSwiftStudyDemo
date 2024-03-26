//
//  ChatRoomLikeFillInformationAlertView.h
//  ChatRoomModule
//
//  Created by liguanglei on 2023/12/4.
//

#import <UIKit/UIKit.h>
#import "ChatRoomLikeHallTagModel.h"
#import "GLCommHeader.h"
#import "ChatRoomLikeHallFillInfoAModel.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, CRLFITagButtonType) {
    CRLFITagButtonTypeEffective  = 0, //情感状态
    CRLFITagButtonTypeMateSelection  = 1,// 择偶要求
};

@interface ChatRoomLikeFillInformationAlertView : UIView
@property(nonatomic , weak) id<ChatRoomLikeMatchingVcProtocol> delegateVC;
@property(nonatomic, assign) BOOL isFromFun;//是否娱乐tab
- (instancetype)initWithModel:(ChatRoomLikeHallFillInfoAModel *)model;

/// 根据后台返回是否显示确认资料弹窗
/// - Parameters:
///   - isShowMsg: 是否显示报错信息
///   - delegateVC: 防重复弹的
///   - isCanQuickMatch: 是否可以快速匹配,这个防止循环调用
///   isFromFun:来源：是否来自tab
+ (void)showIfNeedIsShowMsg:(BOOL )isShowMsg delegateVC:(id<ChatRoomLikeMatchingVcProtocol>) delegateVC isCanQuickMatch:(BOOL) isCanQuickMatch isFromFun:(BOOL)isFromFun;

/// 检查是否可以匹配和开始匹配
/// - Parameters:
///   - complete: 完成block
///   - delegateVC: 防重复弹的
///   - isCanFillInfo: 是否可以显示确认资料弹窗 防死循环的
///   isFromFun:来源：是否来自tab
+ (void)checkAndStartMatchComPlete:(void(^)(BOOL isSuccess)) complete delegateVC:(id<ChatRoomLikeMatchingVcProtocol>) delegateVC isCanFillInfo:(BOOL) isCanFillInfo isShowMsg:(BOOL)isShowMsg isFromFun:(BOOL)isFromFun;
@end


@interface ChatRoomLikeFillInformationTagButton : UIButton
@property(nonatomic, strong) ChatRoomLikeHallTagModel *model;
@property(nonatomic, assign) NSInteger maxSelectCount;//最大选中个数,默认0 不限制个数
@property(nonatomic, assign) CRLFITagButtonType cutomBtnType;

@end

NS_ASSUME_NONNULL_END
