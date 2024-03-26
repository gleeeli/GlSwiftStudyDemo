//
//  ChatRoomLikeHallFillInfoAModel.h
//  ChatRoomModule
//
//  Created by liguanglei on 2023/12/5.
//

#import <Foundation/Foundation.h>
#import "ChatRoomLikeHallTagModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChatRoomLikeHallFillInfoAModel : NSObject
//@property(nonatomic, copy) NSString *canStartMatch;//可以直接开始匹配：0、否，1、是
@property(nonatomic, copy) NSArray *cardImgArr;
@property(nonatomic, strong) NSMutableArray<ChatRoomLikeHallFillInfoBannerModel *> *bannerArray;//需要本地组装
@property(nonatomic, copy) NSString *age;
@property(nonatomic, copy) NSString *cityName;
@property(nonatomic, copy) NSString *constellation;//用户星座
@property(nonatomic, copy) NSArray<ChatRoomLikeHallTagModel *> *affectivestatusInfo;
@property(nonatomic, copy) NSArray<ChatRoomLikeHallTagModel *> *mateSelectionInfo;
@property(nonatomic, copy) NSString *delistingNumber;//脱单人数
- (void)updateBannerArrayWithArr:(NSArray *)cardImgArr;
@end

@interface ChatRoomLikeHallAwaitBellModel : NSObject
@property(nonatomic, copy) NSArray<NSDictionary *> *matchAvatarArr;//快速匹配头像数组
@property(nonatomic, copy) NSString *cardLottieId;//卡片动效ID
@property(nonatomic, copy) NSString *lottieId;//背景动效ID

@property(nonatomic, copy) NSString *comeonMsg;//红娘正在赶来的路上...
@property(nonatomic, copy) NSString *countdownMsg;//倒计时文案
@property(nonatomic, assign) long countdown;//倒计时
@property(nonatomic, copy) NSString *delistingNumber;//脱单人数


+ (NSString *)getCardEventKey;
+ (NSString * _Nullable)getPreLottieIdWithEventKey:(NSString *)eventKey;
+ (void)setCurLottieIdWithEventKey:(NSString *)eventKey lottieId:(NSString *)lottieId;
@end


NS_ASSUME_NONNULL_END
