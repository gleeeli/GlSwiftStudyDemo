//
//  ChatRoomLikeHallTagModel.h
//  ChatRoomModule
//
//  Created by liguanglei on 2023/12/5.
//

#import <Foundation/Foundation.h>
#import "GLCommHeader.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//控制一种alertview重叠显示
@protocol ChatRoomLikeMatchingVcProtocol <NSObject>
- (BOOL)isCanShowAlertViewClass:(Class )cls;
- (void)willShow:(UIView *)alertView;
- (void)willHidden:(UIView *)alertView;
@end

@interface ChatRoomLikeHallTagModel : NSObject
@property(nonatomic, assign) BOOL isSelect;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, copy) NSString *value;

@end

@interface ChatRoomLikeHallFillInfoBannerModel : NSObject
@property(nonatomic, copy) NSString *url;

@property(nonatomic, strong) UIColor *backColor;
@end

NS_ASSUME_NONNULL_END
