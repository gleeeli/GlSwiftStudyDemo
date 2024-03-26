//
//  ChatRoomLikeFillInformationAlertView.m
//  ChatRoomModule
//
//  Created by liguanglei on 2023/12/4.
//

#import "ChatRoomLikeFillInformationAlertView.h"
#import "ChatRoomLikeHallTagModel.h"
//#import <XHBUIKit/XHBBannerView.h>
//#import <XHBUIKit/XHBPageControl.h>
//#import "ChatRoomLikeFillInfoTopCollectionViewCell.h"
//#import "XHBInterface+ChatRoom.h"
#import "ChatRoomLikeHallFillInfoAModel.h"
//#import "ChatRoomLikeMatchingMatchmakerAlertView.h"
#import <Masonry/Masonry.h>
#import "UIFont+XHB.h"

@interface ChatRoomLikeFillInformationAlertView ()//<XHBBannerViewDelegate, XHBBannerViewDataSource>
//@property(nonatomic, strong) XHBBannerView *topBannerView;
//@property(nonatomic, strong) XHBPageControl *pageControl;
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UILabel *haveHelpLable;
@property(nonatomic, strong) UILabel *tSureLable;
@property(nonatomic, strong) UILabel *simpleInfoLable;

@property(nonatomic, strong) UILabel *emotionLable;//情感状态
@property(nonatomic, strong) UIView *emotionBackView;

@property(nonatomic, strong) UILabel *mateSelectionLable;//择偶要求（非必填）
@property(nonatomic, strong) UIView *mateSelectionBackView;
@property(nonatomic, strong) UIButton *matchBtn;
@property(nonatomic, strong) UIButton *lookBtn;
@property(nonatomic, strong) UIButton *closeBtn;
@property(nonatomic, strong) ChatRoomLikeHallFillInfoAModel *model;
@property(nonatomic, assign) BOOL isRequestingUpInfo;
//@property(nonatomic, strong) XHBProcessIndicator *indicator;
@end

@implementation ChatRoomLikeFillInformationAlertView

- (void)dealloc {
//    DDLogInfo(@"--dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithModel:(ChatRoomLikeHallFillInfoAModel *)model
{
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        self.model = model;
        
        [self customView];
        [self setUI];
        [self updateData];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterRoomNotification:) name:ChatRoomLikeMatchingSuccessEnterRoomNotification object:nil];
    }
    
    return self;
}

- (void)customView {
    [self addSubview:self.contentView];
    CGFloat height =  454 + [self getTopBannerHeight];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = CGRectMake(0,  self.frame.size.height - height, HB_UIScreenWidth, height);
    self.contentView .layer.cornerRadius = 16;
}

- (void)showView:(BOOL)show {
    if(show) {
        if(self.delegateVC && [self.delegateVC respondsToSelector:@selector(willShow:)]) {
            [self.delegateVC willShow:self];
        }
    }else {
        if(self.delegateVC && [self.delegateVC respondsToSelector:@selector(willHidden:)]) {
            [self.delegateVC willHidden:self];
        }
    }
    
//    [super showView:show];
}

#pragma mark - Private

- (CGFloat)getTopBannerHeight {
    CGFloat scale = HB_UIScreenWidth / 375.0;
    return 184 * scale;
}

- (void)setUI {
//    [self.contentView addSubview:self.topBannerView];
    [self.contentView addSubview:self.closeBtn];
    [self.contentView addSubview:self.haveHelpLable];
    [self.contentView addSubview:self.tSureLable];
    [self.contentView addSubview:self.simpleInfoLable];
    [self.contentView addSubview:self.emotionLable];
    [self.contentView addSubview:self.emotionBackView];
    [self.contentView addSubview:self.mateSelectionLable];
    [self.contentView addSubview:self.mateSelectionBackView];
    [self.contentView addSubview:self.matchBtn];
    [self.contentView addSubview:self.lookBtn];
    
    self.tSureLable.text = @"请确认以下信息";
    self.emotionLable.text = @"情感状态";
    self.mateSelectionLable.text = @"择偶要求（非必填）";
    NSLog(@"ddddfont:%f", self.emotionLable.font.pointSize);
   
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(6);
        make.trailing.equalTo(self.contentView).offset(2);
        make.width.height.mas_equalTo(34);
    }];
    
    [self.haveHelpLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(180);
        make.leading.equalTo(self.contentView).offset(24);
    }];
    
    [self.tSureLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.haveHelpLable.mas_bottom).offset(8);
        make.leading.equalTo(self.contentView).offset(24);
    }];
    
    [self.simpleInfoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tSureLable.mas_bottom).offset(16);
        make.leading.equalTo(self.tSureLable);
    }];
    
    [self.emotionLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.simpleInfoLable.mas_bottom).offset(24);
        make.leading.equalTo(self.contentView).offset(24);
    }];
    
    [self.emotionBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.emotionLable);
        make.trailing.equalTo(self.contentView).offset(-22);
        make.top.equalTo(self.emotionLable.mas_bottom).offset(8);
        make.height.mas_equalTo(0);
    }];
    
    [self.mateSelectionLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emotionBackView.mas_bottom).offset(24);
        make.trailing.equalTo(self.contentView).offset(-22);
        make.leading.equalTo(self.contentView).offset(24);
    }];
    
    [self.mateSelectionBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mateSelectionLable);
        make.trailing.equalTo(self.contentView).offset(-22);
        make.top.equalTo(self.mateSelectionLable.mas_bottom).offset(8);
        make.height.mas_equalTo(0);
    }];
    
    [self.matchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mateSelectionBackView.mas_bottom).offset(32);
        make.leading.equalTo(self.contentView).offset(22);
        make.trailing.equalTo(self.contentView).offset(-22);
        make.height.mas_equalTo(48);
    }];
    
    [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.matchBtn.mas_bottom).offset(15);
        make.leading.equalTo(self.contentView).offset(22);
        make.trailing.equalTo(self.contentView).offset(-22);
    }];
}

- (void)updateHaveHelpLabelWithKeyValue:(NSString *)keyValue {
//    if([NSString isEmpty:keyValue]) {
//        keyValue = @"";
//    }
    NSString *allStr = [NSString stringWithFormat:@"已帮助%@位用户成功脱单", keyValue];
    NSMutableAttributedString *allValueAttrs = [[NSMutableAttributedString alloc] initWithString:allStr attributes:@{NSForegroundColorAttributeName: HB_RGBACOLOR(112, 114, 119, 1), NSFontAttributeName: [UIFont hb_fontWithPingFangSCMediumSize:TH_FONT_H3_FIT]}];
    
//    if(![NSString isEmpty:keyValue]) {
        NSRange keyRang = [allStr rangeOfString:keyValue];
        if(keyRang.location != NSNotFound && keyRang.length > 0) {
            [allValueAttrs addAttributes:@{NSForegroundColorAttributeName: HB_RGBACOLOR(255, 222, 51, 1)} range:keyRang];
        }
//    }
    
    self.haveHelpLable.attributedText = allValueAttrs;
}

+ (void)requestFillInfoComplete:(void(^)(ChatRoomLikeHallFillInfoAModel *model, NSString *canStartMatch, NSString * _Nullable msg)) complete {
//    [XHBNetworking requestWithURL:[XHBInterfaceCenter chatRoomBlindDateGetNewMaleProfileInfo]
//                           method:kHBHTTPGet
//                     parameterDic:nil
//                     successBlock:^(XHBHTTPResponse *response) {
//        if (response.isSuccess && [response.responseData isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *profileInfo = [response.responseData objectForKey:@"profile_info"];
//            //可以直接开始匹配：0、否，1、是
//            NSString *canStartMatch = [NSString getString:response.responseData key:@"can_start_match"];
//            if([canStartMatch isEqualToString:@"1"]) {
//                if(complete) {
//                    complete(nil, canStartMatch, response.message);
//                }
//            }else if(profileInfo && [profileInfo isKindOfClass:[NSDictionary class]]) {
//                ChatRoomLikeHallFillInfoAModel *model = [[ChatRoomLikeHallFillInfoAModel alloc] init];
//
//                [model setPropertyWithDictionary:profileInfo];
//                [model updateBannerArrayWithArr:model.cardImgArr];
//                model.delistingNumber = [NSString getString:response.responseData key:@"delisting_number"];
//                if(complete) {
//                    complete(model, canStartMatch, response.message);
//                }
//            }else {
//                if(complete) {
//                    complete(nil, canStartMatch, response.message);
//                }
//            }
//        } else {
//            DDLogError(@"error： requestFillInfo %@", response.responseString);
//
//            if(complete) {
//                complete(nil, @"0", response.message);
//            }
//        }
//    } failureBlock:^(XHBHTTPResponse *response) {
//        DDLogError(@"error： requestFillInfo neterror %@", response.responseString);
//        if(complete) {
//            complete(nil, @"0", response.message);
//        }
//    }];
}

- (void)requestUpdateBaseInfo {
    
    if(self.isRequestingUpInfo) {
        return;
    }
    
    __block NSString *affectivestatusValue = @"";
    [self findAllTagButtonWithSubViews:self.emotionBackView.subviews complete:^(ChatRoomLikeFillInformationTagButton *btn) {
        if(btn.isSelected) {
            affectivestatusValue = btn.model.value;
        }
    }];
    
    if([NSString isEmpty:affectivestatusValue]) {
//        [XHBTipView showMsg:@"请选择情感状态"];
        return;
    }
    
    NSMutableArray *muarray = [[NSMutableArray alloc] init];
    [self findAllTagButtonWithSubViews:self.mateSelectionBackView.subviews complete:^(ChatRoomLikeFillInformationTagButton *btn) {
        if(btn.isSelected) {
            [muarray addObject:btn.model.value];
        }
    }];
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setObject:USERINFO.ticketId forKey:@"ticket_id"];
//    [param setObject:affectivestatusValue forKey:@"affectivestatus_value"];
    
//    if([muarray count] > 0) {
//        NSString *allValues = @"";
//        for (NSString *item in muarray) {
//            if([NSString isEmpty:allValues]) {
//                allValues = item;
//            }else {
//                allValues = [NSString stringWithFormat:@"%@,%@",allValues, item];
//            }
//
//        }
//        [param setObjectSafe:allValues forKeySafe:@"mate_selection_values"];
//    }
//
//    [self showAlertLoading:YES];
//
//    [XHBNetworking requestWithURL:[XHBInterfaceCenter chatRoomBlindDateSaveNewMaleProfileInfo]
//                           method:kHBHTTPPost
//                     parameterDic:param
//                     successBlock:^(XHBHTTPResponse *response) {
//        if (response.isSuccess && [response.responseData isKindOfClass:[NSDictionary class]]) {
//            BOOL result = [[NSString getString:response.responseData key:@"result"] boolValue];
//            if(result) {
//                [ChatRoomLikeFillInformationAlertView checkAndStartMatchComPlete:^(BOOL isSuccess) {
//                    [self showAlertLoading:NO];
//                } delegateVC:self.delegateVC isCanFillInfo:NO isShowMsg:YES isFromFun:self.isFromFun];
//
//                [self showView:NO];
//            }else {
//                [self showAlertLoading:NO];
//                [XHBTipView showMsg:response.message];
//            }
//        } else {
//            [self showAlertLoading:NO];
//            DDLogError(@"error： requestOnlineList %@", response.responseString);
//            [XHBTipView showMsg:response.message];
//        }
//    } failureBlock:^(XHBHTTPResponse *response) {
//        [self showAlertLoading:NO];
//        DDLogError(@"error： requestOnlineList neterror %@", response.responseString);
//        [XHBTipView showMsg:response.message];
//    }];
}

- (void)showAlertLoading: (BOOL)isShow {
    self.isRequestingUpInfo = isShow;
    [self showLoading:isShow];
}

/**
 * 显示正在加载页面
 */
- (void)showLoading:(BOOL)show {
//    if (show) {
//        if (_indicator) {
//            HB_ReleaseViewSafe(_indicator);
//        }
//        _indicator = [[XHBProcessIndicator alloc] initWithFrame:self.bounds];
//        [self addSubview:_indicator];
//        [_indicator showCustomIndicator];
//    } else {
//        [_indicator endCustomIndicator];
//    }
}

- (void)updateData {
//    [self.topBannerView reloadData];
    
    NSString *baseInfo = @"";
    NSString *pointStr = @"";
    if(![NSString isEmpty:self.model.age]) {
        baseInfo = [NSString stringWithFormat:@"%@", self.model.age];
    }
    
    if(![NSString isEmpty:self.model.cityName]) {
        if(![NSString isEmpty:baseInfo]) {
            pointStr = @"·";
        }
        baseInfo = [NSString stringWithFormat:@"%@%@%@", baseInfo, pointStr, self.model.cityName];
    }
    
    if(![NSString isEmpty:self.model.constellation]) {
        if(![NSString isEmpty:baseInfo]) {
            pointStr = @"·";
        }
        baseInfo = [NSString stringWithFormat:@"%@%@%@", baseInfo, pointStr, self.model.constellation];
    }
    
    self.simpleInfoLable.text = baseInfo;
    
    
    CGFloat tags1Height = [self createTagsWithModels:self.model.affectivestatusInfo backView:self.emotionBackView maxSelectCount:1 btnTyp:CRLFITagButtonTypeEffective];
    
    [self.emotionBackView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tags1Height);
    }];

    CGFloat tags2Height = [self createTagsWithModels:self.model.mateSelectionInfo backView:self.mateSelectionBackView maxSelectCount:3 btnTyp:CRLFITagButtonTypeMateSelection];
    [self.mateSelectionBackView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tags2Height);
    }];
    
    [self updateHaveHelpLabelWithKeyValue:self.model.delistingNumber];
}

- (CGFloat)createTagsWithModels:(NSArray *)models backView:(UIView *)backView maxSelectCount:(NSInteger) maxSelectCount btnTyp:(CRLFITagButtonType) btnType {
    CGFloat tx = 0;
    CGFloat ty = 0;
    CGFloat maxWidth = self.frame.size.width - 44;
    CGFloat height = 28;
    CGFloat rows = 0;
    for (ChatRoomLikeHallTagModel *model in models) {
        UIFont *font = [UIFont hb_fontWithPingFangSCRegularSize:TH_FONT_B4_FIT];
        NSString *title = model.text;
        CGFloat tWidth = 16;
        if(![NSString isEmpty:title]) {
            tWidth += [title hb_sizeWithFont:font maxWidth:maxWidth].width;
        }
        
        if(tx + tWidth > maxWidth) {
            rows += 1;
            if(rows == 2) {
                break;
            }
            tx = 0;
            ty += height + 15;
        }
        
        ChatRoomLikeFillInformationTagButton *btn = [[ChatRoomLikeFillInformationTagButton alloc] initWithFrame:CGRectMake(tx, ty, tWidth, height)];
        btn.titleLabel.font = font;
//        btn.hb_eventInterval = 0;
        btn.cutomBtnType = btnType;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:TH_Black100 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageWithColor:TH_Yellow800] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:TH_Black5] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        btn.model = model;
        btn.selected = model.isSelect;
        btn.maxSelectCount = maxSelectCount;
        
        [backView addSubview:btn];
        tx = CGRectGetMaxX(btn.frame) + 10;
    }
    
    return ty + 28;
}

#pragma mark - Public

/// 根据后台返回是否显示确认资料弹窗
/// - Parameters:
///   - isShowMsg: 是否显示报错信息
///   - delegateVC: 防重复弹的
///   - isCanQuickMatch: 是否可以快速匹配,这个防止循环调用
+ (void)showIfNeedIsShowMsg:(BOOL )isShowMsg delegateVC:(id<ChatRoomLikeMatchingVcProtocol>) delegateVC isCanQuickMatch:(BOOL) isCanQuickMatch isFromFun:(BOOL)isFromFun {
//    [self requestFillInfoComplete:^(ChatRoomLikeHallFillInfoAModel *model, NSString *canStartMatch, NSString * _Nullable msg) {
//        if([canStartMatch isEqualToString:@"1"] && isCanQuickMatch) {//可以直接匹配
////            [ChatRoomLikeMatchingMatchmakerAlertView showMatchingViewComplete:^(BOOL isSuccess) {
////
////            } delegateVC:delegateVC];
//        }
//        else if(model) {
//            if(delegateVC && [delegateVC respondsToSelector:@selector(isCanShowAlertViewClass:)]) {
//                BOOL canShow = [delegateVC isCanShowAlertViewClass:[ChatRoomLikeFillInformationAlertView class]];
//                if(!canShow) {
//                    DDLogWarn(@"warn:上一个ChatRoomLikeFillInformationAlertView正在显示，抛弃");
//                    return;
//                }
//            }
//            ChatRoomLikeFillInformationAlertView *alertView = [[ChatRoomLikeFillInformationAlertView alloc] initWithModel:model];
//            alertView.delegateVC = delegateVC;
//            alertView.isFromFun = isFromFun;
//            [alertView showView:YES];
//
//            NSString *fromType = isFromFun ? @"切换导航栏触发":@"瓷砖位触发";
//            NSMutableDictionary *param = [NSMutableDictionary dictionary];
//            [param setObjectSafe:fromType forKeySafe:@"from_type"];
//            [XHBStatisticsManager trackWithEventID:@"xiangqin_mate_datapage_exposure" withVariable:param];
//        }else if(isShowMsg) {
//            [XHBTipView showMsg:msg];
//        }
//    }];
}

/// 检查是否可以匹配和开始匹配
/// - Parameters:
///   - complete: 完成block
///   - delegateVC: 防重复弹的
///   - isCanFillInfo: 是否可以显示确认资料弹窗 防死循环的
+ (void)checkAndStartMatchComPlete:(void(^)(BOOL isSuccess)) complete delegateVC:(id<ChatRoomLikeMatchingVcProtocol>) delegateVC isCanFillInfo:(BOOL) isCanFillInfo isShowMsg:(BOOL)isShowMsg isFromFun:(BOOL)isFromFun {
//    [XHBNetworking requestWithURL:[XHBInterfaceCenter chatRoomBlindDateRoomCheckMatchUpMeeting]
//                           method:kHBHTTPGet
//                     parameterDic:nil
//                     successBlock:^(XHBHTTPResponse *response) {
//        if (response.isSuccess && [response.responseData isKindOfClass:[NSDictionary class]]) {
//            BOOL result = [[NSString getString:response.responseData key:@"check_result"] boolValue];
//            NSString *needSave = [NSString getString:response.responseData key:@"need_save"];
//
//            if(result) {
//                [ChatRoomLikeMatchingMatchmakerAlertView showMatchingViewComplete:complete delegateVC:delegateVC];
//            }else {
//                if(complete) {
//                    complete(NO);
//                }
//
//                if([needSave isEqualToString:@"1"] && isCanFillInfo) {//需要填写资料
//                    [ChatRoomLikeFillInformationAlertView showIfNeedIsShowMsg:isShowMsg delegateVC:delegateVC isCanQuickMatch:NO isFromFun:isFromFun];
//                }else if(isShowMsg) {
//                    [XHBTipView showMsg:response.message];
//                }
//            }
//
//        } else {
//            if(complete) {
//                complete(NO);
//            }
//            if(isShowMsg) {
//                [XHBTipView showMsg:response.message];
//            }
//
//        }
//    } failureBlock:^(XHBHTTPResponse *response) {
//        if(complete) {
//            complete(NO);
//        }
//        if(isShowMsg) {
//            [XHBTipView showMsg:response.message];
//        }
//
//    }];
    
}

#pragma mark - action
- (void)tagBtnClick:(ChatRoomLikeFillInformationTagButton *)btn {
    UIView *fatherView = btn.superview;
    if(btn.maxSelectCount == 1) {
        [self findAllTagButtonWithSubViews:fatherView.subviews complete:^(ChatRoomLikeFillInformationTagButton *btn) {
            btn.selected = NO;
            btn.model.isSelect = NO;
        }];
    }else if(btn.maxSelectCount > 1) {
        __block NSInteger curCount = 0;
        [self findAllTagButtonWithSubViews:fatherView.subviews complete:^(ChatRoomLikeFillInformationTagButton *btn) {
            if(btn.selected) {
                curCount += 1;
            }
        }];
        
        if(curCount >= btn.maxSelectCount && btn.selected == NO) {
            return;
        }
    }
    
    btn.selected = !btn.selected;
    btn.model.isSelect = btn.selected;
    
    NSString *element = @"修改情感状态";
    if(btn.cutomBtnType == CRLFITagButtonTypeMateSelection) {
        element = @"选择择偶要求";
    }
    [self trackStaticsClickElement:element];
}

- (void)findAllTagButtonWithSubViews:(NSArray *)subviews complete:(void(^)(ChatRoomLikeFillInformationTagButton *btn)) complte {
    for (UIView *view in subviews) {
        if([view isKindOfClass:[ChatRoomLikeFillInformationTagButton class]]) {
            ChatRoomLikeFillInformationTagButton *item = (ChatRoomLikeFillInformationTagButton *)view;
            complte(item);
        }
    }
}


- (void)lookBtnClick:(UIButton *)btn {
    [self showView:NO];
    
    [self trackStaticsClickElement:@"随意看看"];
}

- (void)matchBtnClick:(UIButton *)btn {
    [self requestUpdateBaseInfo];
    
    [self trackStaticsClickElement:@"立即匹配"];
}

- (void)closeBtnClick:(UIButton *)btn {
    [self showView:NO];
    [self trackStaticsClickElement:@"关闭页面"];
}

//- (void)enterRoomNotification:(NSNotificationCenter *)noti {
//    [self showView:NO];
//}

#pragma mark - XHBBannerViewDelegate, XHBBannerViewDataSource
//- (NSArray *)dataArrayInBannerView:(XHBBannerView *)bannerView {
//    return self.model.bannerArray;
//}
//
//- (Class)bannerView:(XHBBannerView *)bannerView cellClassForItemAtIndexPath:(NSIndexPath *)indexPath dataObject:(id)dataObject {
//
//    return [ChatRoomLikeFillInfoTopCollectionViewCell class];
//}
//
//- (void)bannerView:(XHBBannerView *)bannerView pageDidChange:(NSUInteger)page {
//    self.pageControl.currentPage = page;
//}

#pragma mark - 埋点
- (void)trackStaticsClickElement:(NSString *)element {
//    NSString *fromType = self.isFromFun ? @"切换导航栏触发":@"瓷砖位触发";
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setObjectSafe:fromType forKeySafe:@"from_type"];
//    [param setObjectSafe:element forKeySafe:@"element"];
//    [XHBStatisticsManager trackWithEventID:@"xiangqin_mate_datapage_click" withVariable:param];
}

#pragma mark - Getter
//- (XHBBannerView *)topBannerView {
//    if (!_topBannerView) {
//        _topBannerView = [[XHBBannerView alloc] initWithFrame:CGRectMake(0, 0, self.width, [self getTopBannerHeight])];
//        _topBannerView.delegate = self;
//        _topBannerView.dataSource = self;
//        _topBannerView.startImmediately = YES;
//        [_topBannerView scrollEnable:YES];
//
//        [_topBannerView addSubview:self.pageControl];
//    }
//    return _topBannerView;
//}

//- (XHBPageControl *)pageControl {
//    if(!_pageControl) {
//        long length = [self.model.bannerArray count];
//        CGFloat pwidth = length * 4 + (length - 1) * 4;
//        CGFloat pHeigth = 4;
//        _pageControl = [[XHBPageControl alloc] initWithFrame:CGRectMake(self.width - pwidth - 16, [self getTopBannerHeight] - 12 - pHeigth, pwidth, pHeigth)];
//        _pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        _pageControl.backgroundColor = [UIColor clearColor];
//        _pageControl.enabled = NO;
//        _pageControl.indicatorMargin = 4;
//        _pageControl.indicatorDiameter = 4;
//        _pageControl.alignment = HBPageControlAlignmentCenter;
//        _pageControl.pageIndicatorTintColor = HB_RGBACOLOR(22, 22, 22, 0.5);
//        _pageControl.currentPageIndicatorTintColor = TH_Yellow800;
//        _pageControl.numberOfPages = length;
//        _pageControl.currentPage = 0;
//    }
//    return _pageControl;
//}

- (UILabel *)simpleInfoLable {
    if(!_simpleInfoLable) {
        _simpleInfoLable = [[UILabel alloc] init];
        _simpleInfoLable.textColor = TH_Black100;
        _simpleInfoLable.font = [UIFont hb_fontWithPingFangSCMediumSize:TH_FONT_H2_FIT];
    }
    
    return _simpleInfoLable;
}

- (UILabel *)tSureLable {
    if(!_tSureLable) {
        _tSureLable = [[UILabel alloc] init];
        _tSureLable.textColor = TH_Gray400;
        _tSureLable.font = [UIFont hb_fontWithPingFangSCRegularSize:TH_FONT_B2_FIT];
    }
    
    return _tSureLable;
}

- (UILabel *)emotionLable {
    if(!_emotionLable) {
        _emotionLable = [[UILabel alloc] init];
        _emotionLable.font = [UIFont hb_fontWithPingFangSCRegularSize:TH_FONT_B2_FIT];
        _emotionLable.textColor = TH_Gray400;
    }
    
    return _emotionLable;
}

- (UIView *)emotionBackView {
    if(!_emotionBackView) {
        _emotionBackView = [[UIView alloc] init];
    }
    
    return _emotionBackView;
}

- (UILabel *)mateSelectionLable {
    if(!_mateSelectionLable) {
        _mateSelectionLable = [[UILabel alloc] init];
        _mateSelectionLable.font = [UIFont hb_fontWithPingFangSCRegularSize:TH_FONT_B2_FIT];
        _mateSelectionLable.textColor = TH_Gray400;
    }
    
    return _mateSelectionLable;
}

- (UIView *)mateSelectionBackView {
    if(!_mateSelectionBackView) {
        _mateSelectionBackView = [[UIView alloc] init];
    }
    
    return _mateSelectionBackView;
}

- (UIButton *)matchBtn {
    if(!_matchBtn) {
        _matchBtn = [[UIButton alloc] init];
        _matchBtn.titleLabel.font = [UIFont hb_fontWithPingFangSCMediumSize:TH_FONT_H3_FIT];
        [_matchBtn setTitleColor:TH_Black100 forState:UIControlStateNormal];
        _matchBtn.layer.cornerRadius = 24;
        _matchBtn.layer.masksToBounds = YES;
//        [_matchBtn setViewCornerRadius:24];
        [_matchBtn setBackgroundColor:TH_Yellow600];
        [_matchBtn addTarget:self action:@selector(matchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_matchBtn setTitle:@"找红娘帮忙脱单" forState:UIControlStateNormal];
    }
    
    return _matchBtn;
}

- (UIButton *)lookBtn {
    if(!_lookBtn) {
        _lookBtn = [[UIButton alloc] init];
        _lookBtn.titleLabel.font = [UIFont hb_fontWithPingFangSCRegularSize:TH_FONT_B2_FIT];
        [_lookBtn setTitleColor:TH_Black100 forState:UIControlStateNormal];
        [_lookBtn addTarget:self action:@selector(lookBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_lookBtn setTitle:@"围观其他人" forState:UIControlStateNormal];
    }
    return _lookBtn;
}

- (UIButton *)closeBtn {
    if(!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
//        [_closeBtn setImage:[UIImage chatroom_imageNamed:@"chatroom_likehall_fillinfo_close_white_btn"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeBtn;
}
     

- (UILabel *)haveHelpLable {
    if(!_haveHelpLable) {
        _haveHelpLable = [[UILabel alloc] init];
        _haveHelpLable.font = [UIFont hb_fontWithPingFangSCMediumSize:TH_FONT_H3_FIT];
    }
    return _haveHelpLable;
}

- (UIView *)contentView {
    if(!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

@end


@implementation ChatRoomLikeFillInformationTagButton

@end
