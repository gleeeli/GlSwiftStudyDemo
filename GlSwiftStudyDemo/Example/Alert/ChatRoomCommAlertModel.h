//
//  ChatRoomCommAlertModel.h
//  ChatRoomModule
//
//  Created by liguanglei on 2023/7/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ChatRoomCommAlertEventCancel = 0,
    ChatRoomCommAlertEventSure,
    ChatRoomCommAlertEventClickSpaceCancel,//点击空白取消
    ChatRoomCommAlertEventAutoCancel,//自动取消
} ChatRoomCommAlertEvent;

@class ChatRoomCommAlertView;

@interface ChatRoomCommAlertModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *sureBtnTitle;
@property (nonatomic, copy) NSString *cancelBtnTitle;
//是否点击空白消失
@property (nonatomic, assign) BOOL isClickSpaceCancel;
@property (nonatomic, assign) CGFloat defaultContentWidth;
//多久无点击消失
@property (nonatomic, assign) NSTimeInterval dismissTime;
//右上角显示关闭按钮
@property (nonatomic, assign) BOOL showRightCloseBtn;
@property (nonatomic, assign) BOOL testNum;

//标题下的视图,位于中间部位
@property (nonatomic, copy) UIView*(^centerViewBlock)(ChatRoomCommAlertView *alertView, UIView *contentView, UIView *topView);
@property (nonatomic, copy) UIView*(^bottomViewBlock)(ChatRoomCommAlertView *alertView, UIView *contentView, UIView *topView);
@property (nonatomic, copy) void(^eventBlock)(ChatRoomCommAlertEvent event);
//外部view事件通用回调
@property (nonatomic, copy) void(^outViewAllEventBlock)(id sender);
@end

NS_ASSUME_NONNULL_END
