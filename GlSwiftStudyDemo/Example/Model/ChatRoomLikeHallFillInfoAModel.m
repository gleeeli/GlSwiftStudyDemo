//
//  ChatRoomLikeHallFillInfoAModel.m
//  ChatRoomModule
//
//  Created by liguanglei on 2023/12/5.
//

#import "ChatRoomLikeHallFillInfoAModel.h"

@implementation ChatRoomLikeHallFillInfoAModel
+ (nullable NSDictionary<NSString *, id> *)hb_modelContainerPropertyGenericClass {
    return @{@"affectivestatusInfo" : [ChatRoomLikeHallTagModel class],@"mateSelectionInfo" : [ChatRoomLikeHallTagModel class]
    };
}

- (void)updateBannerArrayWithArr:(NSArray *)cardImgArr {
    [self.bannerArray removeAllObjects];
    for (NSString *url in cardImgArr) {
        ChatRoomLikeHallFillInfoBannerModel *model = [[ChatRoomLikeHallFillInfoBannerModel alloc] init];
        model.url = url;
        [self.bannerArray addObject:model];
    }
}

- (NSMutableArray<ChatRoomLikeHallFillInfoBannerModel *> *)bannerArray {
    if(!_bannerArray) {
        _bannerArray = [[NSMutableArray alloc] init];
    }
    return _bannerArray;
}
@end

@implementation ChatRoomLikeHallAwaitBellModel
+ (NSString *)getCardEventKey {
    return @"CardEventKey";
}

//+ (NSString * _Nullable)getPreLottieIdWithEventKey:(NSString *)eventKey {
//    NSString *value = [XHBUserDefaultsUtils getValue:eventKey];
//    
//    return value;
//}
//
//+ (void)setCurLottieIdWithEventKey:(NSString *)eventKey lottieId:(NSString *)lottieId {
//    [XHBUserDefaultsUtils storeToUserDefault:lottieId key:eventKey];
//}
@end
