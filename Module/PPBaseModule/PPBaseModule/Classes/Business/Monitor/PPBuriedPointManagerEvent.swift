//
//  PPBuriedPointManagerEvent.swift
//  AdModule
//
//  Created by WJK on 2022/5/10.
//

import UIKit
import XHBTool
import XHBTrackerKit

@objc public enum OpenLoginShowSource: Int {

    case OpenLoginShowSourceOneClickLoginPage = 1
    case OpenLoginShowSourceGeneralLandingPage = 2

    func string() -> String {
        switch self {
        case .OpenLoginShowSourceOneClickLoginPage:
            return "一键登录页"
        case .OpenLoginShowSourceGeneralLandingPage:
            return "常规登录页"
        }
    }
}

@objc public enum LogInPosition: Int {

    case onkey = 2 // 一键登录（闪验）
    case phone = 0 //  手机号登陆
    case weChat = 3// 微信登陆
    case QQ = 4// QQ登录
    case apple = 6// Apple登录
    case more = 100 // 更多登陆方式
    func string() -> String {
        switch self {
        case .more:
            return "更多登陆方式"
        case .phone:
            return "手机号登陆"
        case .weChat:
            return "微信登陆"
        case .QQ:
            return "QQ登录"
        case .apple:
            return "Apple登录"
        case .onkey:
            return "一键登录"
        }
    }

}

// 如果是新注册用户，if_new_register = 1，完成注册流程后上报；
// 如果是已注册用户，if_new_register = 0，登陆成功后上报
@objc public enum NewRegisterType: Int {
    case new = 1 // 新账号
    case old = 2 // 旧账号

    func string() -> String {
        switch self {
        case .new:
            return "1"
        case .old:
            return "0"
        }
    }
}

/// 完善资料 tab_id：完善资料页细分页面
@objc public enum ImproveInfo: Int {
    case sex = 1 // 性别
    case nickName = 2 // 昵称
    case gravitation = 3 // 引力贴
    case birthday = 4 // 生日

    func string() -> String {
        switch self {
        case .sex:
            return "性别"
        case .nickName:
            return "昵称"
        case .gravitation:
            return "引力贴"
        case .birthday:
            return "生日"
        }
    }
}

@objc public enum ExposureTab: Int {
    case moment
    case fishing
    case constellationMatch
    case discovery
    case message
    case contact
    case momentGroup
    case invite
    case mine
    case pickPartner
    case friendPage
    case other

    func descText() -> String {
        switch self {
        case .moment:
            return "贴贴"
        case .fishing:
            return "钓鱼"
        case .constellationMatch:
            return "星座速配"
        case .discovery:
            return "配配"
        case .message:
            return "消息"
        case .contact:
            return "通讯录"
        case .momentGroup:
            return "瞬间群"
        case .invite:
            return "邀请首页"
        case .mine:
            return "个人主页"
        case .pickPartner:
            return "选择心动对象页面"
        case .friendPage:
            return "好友页面"
        case .other:
            return "其他"
        }
    }
}

@objc public enum PostTopTab: Int {
    case notExist
    case follow
    case recommend
    case new
    case school
    case topic
    case location
    case tongcheng
//    case personHomePage

    func descText() -> String {
        switch self {
        case .notExist:
            return ""
        case .follow:
            return "关注"
        case .recommend:
            return "热门"
        case .new:
            return "最新"
        case .school:
            return "学校"
        case .topic:
            return "话题"
        case .location:
            return "位置"
        case .tongcheng:
            return "同城"
//        case .personHomePage:
//            return "个人主页"
        }
    }
    
    public static func getSourceType(param: Any) -> PostTopTab {
        if let source = param as? PostTopTab {
            return source
        } else if let source = param as? Int {
            return PostTopTab(rawValue: source) ?? .notExist
        }
        return .notExist
    }

}

@objc public enum PostPosition: Int {
    case notExist
    case post
    case reply

    func descText() -> String {
        switch self {
        case .notExist:
            return ""
        case .post:
            return "帖子"
        case .reply:
            return "评论"
        }
    }
}

@objc public enum PostReplyLevel: Int {// 帖子评论等级
    case notExist
    case first
    case second

    func descText() -> String {
        switch self {
        case .notExist:
            return ""
        case .first:
            return "1"
        case .second:
            return "2"
        }
    }
}

@objc public enum DirectMessageType: Int {

    case normal
    case screenplay
}

@objc public enum  CMChatMode: Int {// 私信模式---业务用的
    case comm // 普通模式
    case polt // 剧情模式
    case poltRetain // 剧情保留态
    
    public func toPPBuriedPointType() -> PPBPChatMode {
       return PPBPChatMode.convertFromMCMode(mcmode: self)
    }
}

@objc public enum  PPBPChatMode: Int {// 私信模式 --埋点专用
    case comm // 普通模式
    case polt // 剧情模式
    case poltRetain // 剧情保留态
    case unknow
    case chatGroup //- 瞬间群
    
    /// 描述
    /// - Parameter isPlotRetainSame: 是否剧情模式和剧情保留态传一样的字段
    public  func descText(isPlotRetainSame: Bool) -> String {
        switch self {
        case .comm:
            return "普通私信模式"
        case .polt:
            return "剧情模式"
        case .poltRetain:
            if isPlotRetainSame {
                return "剧情模式"
            }
            return "剧情保留态"
        case .chatGroup:
            return "瞬间群"
        default :
            return "其它"
        }
    }
    
    static func convertFromMCMode(mcmode: CMChatMode) -> PPBPChatMode {
        switch mcmode {
        case .comm:
            return .comm
        case .polt:
            return .polt
        case .poltRetain:
            return .poltRetain
        default:
            return .unknow
        }
    }
}



@objc public enum  CMChatStatus: Int {// 私信模式
    case comm // 普通模式
    case polt // 剧情模式
    case poltRetain // 剧情保留态
    public  func descText() -> String {
        switch self {
        case .comm:
            return "普通态"
        case .polt:
            return ""
        case .poltRetain:
            return "剧情保留态"
        }
    }

    public static func getFromCMChatMode(mode: CMChatMode) -> CMChatStatus {
        var status = CMChatStatus.comm
        switch mode {
        case .comm:
            status = .comm
        case .polt:
            status = .polt
        case .poltRetain:
            status = .poltRetain
        }
        
        return status
    }
}

@objc public enum PPMessageChatFuncButtonType: Int {
    case unknow
    case grazingWheat
    case expression
    case voice
    case picture
    case textInput
    case mood
    case startAnAdventure

    func descText() -> String {
        switch self {
        case .grazingWheat:
            return "上麦"
        case .expression:
            return "表情"
        case .voice:
            return "语音"
        case .picture:
            return "图片"
        case .textInput:
            return "消息框"
        case .mood:
            return "心情消息"
        case .startAnAdventure:
            return "开启奇遇"
        default:
            return "其它"
        }
    }
}

@objc public enum PostTab: Int {
    case notExist
    case square
    case topic
    case detail
    case peipei
    case person
    case squareEmptyDefault // 广场缺省页
    case squareScanner // 广场浏览过程
    case squareListBottom // 广场列表底部
    case mine // 我的页面
    case found // 发现页
    case goFishAlert // 钓鱼弹窗
    case foudShangQiang // 发现页上墙
    case foundTopBar // 发现页顶部条
    case fishIntroduce // 钓鱼
    case college // 学校
    case location // 地点
    case other // 其它

    func descText() -> String {
        switch self {
        case .notExist:
            return ""
        case .square:
            return "广场"
        case .topic:
            return "话题"
        case .detail:
            return "详情"
        case .peipei:
            return "配配"
        case .person:
            return "个人主页"
        case .squareEmptyDefault:
            return "广场缺省页"
        case .squareScanner:
            return "广场浏览过程"
        case .squareListBottom:
            return "广场列表底部"
        case .mine:
            return "我的"
        case .found:
            return "发现页"
        case .goFishAlert:
            return "钓鱼弹窗"
        case .foudShangQiang:
            return "发现页上墙"
        case .foundTopBar:
            return "发现页顶部"
        case .fishIntroduce:
            return "钓鱼弹窗_动态&介绍"
        case .college:
            return "学校"
        case .location:
            return "地点"
        case .other:
            return "其他"
        }
    }
}

@objc public enum PostStyle: Int {
    case notExist
    case school
    case topic
    case location

    func descText() -> String {
        switch self {
        case .notExist:
            return ""
        case .school:
            return "学校"
        case .topic:
            return "话题"
        case .location:
            return "位置"
        }
    }
}

@objc public enum PPAdStyle: Int {
    case notExist
    case tiepian // 贴片广告
    case alert  // 弹窗广告
    case floor  // 悬浮轮播广告
    case carousel  // 固定轮播广告

    func descText() -> String {
        switch self {
        case .notExist:
            return ""
        case .tiepian:
            return "贴片广告"
        case .alert:
            return "弹窗广告"
        case .floor:
            return "悬浮轮播广告"
        case .carousel:
            return "固定轮播广告"
        }
    }
}

@objc public enum PostClickPopTab: Int {
    case other
    case headOrName
    case word
    case wordOpen
    case topicLink
    case picture
    case video
    
    func descText() -> String {
        switch self {
        case .headOrName:
            return "头像&名称"
        case .word:
            return "文字"
        case .wordOpen:
            return "文字展开"
        case .topicLink:
            return "话题页链接"
        case .picture:
            return "图片"
        case .video:
            return "视频"
        case .other:
            return "其他"
        }
    }
}

@objc public enum ExposureSource: Int {
    case unknown
    case message // 0
    case tabbar
    case next
    case moment
    case inviteMessage // 4
    case mine
    case personHomePage // 6
    case other
    case discovery
    case square // 9
    case dynamicSquare
    case dynamicDetail
    case topic
    case squareReply
    case squareClick
    case interactLike
    case interactReply
    case officalJoinBtn
    case publishTopicBtn
    case publishSchoolBtn
    case publishSquareBtn
    case publishPersonInfoBtn
    case tietieHome  // - 贴贴首页
    case tietieGroup
    case privateChat // 私聊界面
    case privateChatPage // 私信聊天页面
    case focusMe // 关注我页面
    case contact
    case guidSquareEmpty // 引导_广场缺省页
    case guidSquareScaner // 引导_广场浏览过程
    case guidSquareListBottom // 广场
    case guidMine // 引导_我的页面
    case guidFound // 引导_发现
    case guidGoFishAlert // 引导_钓鱼弹窗
    case publishLocationBtn // 发布按钮_话题页_位置
    case fishingMessage // 消息页面-伪消息提醒
    case fishingPoint // 消息页面-红点提醒
    case fishing // 消息页面-无提醒
    case foundShangqiang // 引导_发现页上墙
    case foundTopBar // 引导_发现页顶部

    case invateMsg // - 邀请消息
    case minePgeTietie// - 个人主页-已创建的瞬间群
    case msgCenterTietie // - 消息页-已加入的瞬间群
    case  messageCenter // 消息页面
    case tabSelect // - 底部tab

    case postAvatar
    case momentProfileCardAvatar
    case privateMsgAvatar
    case discoveryAvatar
    case commentAvatar
    case postDetailAvatar
    case pickPartnerAvatar
    case fishIntroduce // 钓鱼
    case mineIntroduce // 我的_个人介绍
    case stationMessage // - 站内消息弹窗
    case messageListAvatar// 消息列表头像
    case newUserScreenplayAlert // 新用户剧情弹框
    case messageListHead //消息列表头像
    case topicDetailContent //话题内容页
    case homePageTopRecommend // 首页顶部推荐
    case topicSquare // 话题广场
    case followTopicPage // - 关注话题页
    case browsingRecommend //浏览中推荐位
    case topicTongcheng //同城
    case findPage // 发现页
    case friendPage
    case followMePage //关注我页面
    case groupEndAlert //群聊结束界面
    case discoveryProfile //发现页面
    case personCenterProfile //个人中心页面
    case barrageCard // 弹幕个人资料卡
    case blackList//  黑名单列表点击
    case contactList//  通讯录列表头像
    case friend //  好友页面头像
    case followMine//  关注我页面头像
    case groupChatClose//  解散群聊弹窗头像
    case dazhaohu//  打招呼弹窗头像
    case messageList//  互动消息列表头像
    case discoverIntroduce//  发现页介绍
    case search//  搜索页面头像
    case topicDetail // 话题详情页头像
    case addressPage // 地址页头像
    case school     // 学校页头像
    case storySquare// 故事广场 暂时加的，可改

    public func descText() -> String {
        switch self {
        case .unknown:
            return "未知"
        case .foundTopBar:
            return "引导_发现页顶部"
        case .foundShangqiang:
            return "引导_发现页上墙"
        case .publishLocationBtn:
            return "发布按钮_话题页_位置"
        case .guidGoFishAlert:
            return "引导_钓鱼弹窗"
        case .guidFound:
            return "引导_发现页"
        case .guidSquareEmpty:
            return "引导_广场缺省页"
        case .guidSquareScaner:
            return "引导_广场浏览过程"
        case .guidSquareListBottom:
            return "引导_广场列表底部"
        case .guidMine:
            return "引导_我的"
        case .contact:
            return "通讯录页面"
        case .dynamicDetail:
            return "动态详情页"
        case .focusMe:
            return "关注我页面"
        case .privateChatPage:
            return "私信聊天界面"
        case .privateChat:
            return "私聊界面"
        case .tietieGroup:
            return "贴贴群内"
        case .tietieHome:
            return "贴贴首页"
        case .publishPersonInfoBtn:
            return "发布按钮_我的"
        case .publishSquareBtn:
            return "发布按钮_广场页"
        case .publishSchoolBtn:
            return "发布按钮_话题页_学校"
        case .publishTopicBtn:
            return "发布按钮_话题页_话题"
        case .officalJoinBtn:
            return "官方账号_立即参与活动"
        case .interactLike:
            return "互动消息_点赞"
        case .interactReply:
            return "互动消息_评论"
        case .squareReply:
            return "广场_评论"
        case .squareClick:
            return "广场_点击"
        case .topic:
            return "话题"
        case .square:
            return "广场"
        case .dynamicSquare:
            return "动态广场"
        case .discovery:
            return "配配"
        case .message:
            return "消息页面"
        case .tabbar:
            return "底部tab"
        case .next:
            return "下一个"
        case .moment:
            return "贴贴"
        case .inviteMessage:
            return "邀请消息"
        case .mine:
            return "我的"
        case .personHomePage:
            return "个人主页"
        case .fishing:
            return "消息页面-无提醒"
        case .fishingPoint:
            return "消息页面-红点提醒"
        case .fishingMessage:
            return "消息页面-伪消息提醒"
        case .invateMsg: return "邀请消息"
        case .minePgeTietie: return"个人主页-已创建的瞬间群"
        case .msgCenterTietie: return "消息页-已加入的瞬间群"
        case .messageCenter: return "消息页面"
        case .tabSelect: return "底部tab"
        case .postAvatar: return "帖子头像"
        case .momentProfileCardAvatar: return "瞬间群个人资料卡头像"
        case .privateMsgAvatar: return "私信详情头像"
        case .discoveryAvatar: return "发现页头像"
        case .commentAvatar: return "评论头像"
        case .postDetailAvatar: return "动态详情头像"
        case .pickPartnerAvatar: return "剧本心动对象头像"
        case .stationMessage: return "站内消息弹窗"
        case .fishIntroduce : return "引导_钓鱼弹窗_动态&介绍"
        case .mineIntroduce : return "我的_个人介绍"
        case .messageListAvatar : return "消息列表头像"
        case .newUserScreenplayAlert: return "新用户剧情弹窗"
        case .messageListHead: return "消息列表头像"
        case .topicDetailContent: return "话题内容页"
        case .homePageTopRecommend: return "顶部推荐"
        case .topicSquare: return "话题广场"
        case .followTopicPage: return "关注话题页"
        case .browsingRecommend: return "浏览中推荐位"
        case .topicTongcheng: return "同城tab"
        case .findPage: return "发现页"
        case .friendPage: return "好友页面"
        case .groupEndAlert: return "群聊结束弹窗"
        case .followMePage: return "关注我页面"
        case .discoveryProfile: return "发现"
        case .personCenterProfile: return "个人主页弹幕个人资料卡"
        case .barrageCard: return "弹幕个人资料卡"
        case .blackList: return "黑名单列表点击"
        case .contactList: return "通讯录列表头像"
        case .friend: return "好友页面头像"
        case .followMine: return "关注我页面头像"
        case .groupChatClose: return "群聊结束弹窗"
        case .dazhaohu: return "打招呼弹窗头像"
        case .messageList: return "互动消息列表头像"
        case .discoverIntroduce: return "发现页介绍"
        case .search: return "搜索页面头像"
        case .topicDetail: return "话题详情页头像"
        case .addressPage: return "地址页头像"
        case .school: return "学校页头像"
        case .storySquare: return "故事广场"

        case .other:
            return "其他"
        }
    }
    
    public static func getSourceType(type: Any) -> ExposureSource {
        if let source = type as? ExposureSource {
            return source
            
        } else if let source = type as? Int {
            return ExposureSource(rawValue: source) ?? .other
        }
        
        return .other
    }
}

@objc public enum ClickPosition: Int {
    case privateMessage
    case momentGroup
    case systemMessage
    case barrageEnter
    case personalCenter
    case discovery
    case momentPersonAlert
    case goFishing
    case inviteFriend
    case friendPage
    case wechat
    case pyq
    case qq
    case qzone
    case link
    case siteActivity // 站内活动号
    case dynamicList
    case dynamicDetail
    case disconveryProfile
    case personCenterProfile
    case topicDetail
    case school
    case address
    case other

    public func descText() -> String {
        switch self {
        case .privateMessage:
            return "私聊消息"
        case .momentGroup:
            return "瞬间群"
        case .systemMessage:
            return "小秘书"
        case .barrageEnter:
            return "弹幕入口"
        case .personalCenter:
            return "个人主页"
        case .discovery:
            return "发现"
        case .momentPersonAlert:
            return "瞬间群内个人弹窗"
        case .goFishing:
            return "钓鱼提醒策略"
        case .inviteFriend:
            return "邀请好友"
        case .friendPage:
            return "好友页面"
        case .wechat:
            return "微信"
        case .pyq:
            return "朋友圈"
        case .qq:
            return "qq"
        case .qzone:
            return "qq空间"
        case .link:
            return "复制链接"
        case .siteActivity:
            return "站内活动号"
        case .dynamicList:
            return "动态广场"
        case .dynamicDetail:
            return "动态详情"
        case .disconveryProfile:
            return "发现页弹幕个人资料卡"
        case .personCenterProfile:
            return "个人主页弹幕个人资料卡"
        case .topicDetail:
            return "话题详情页"
        case .school:
            return "学校页"
        case .address:
            return "地址页"
        case .other:
            return "其他"
        }
    }
    
    public static func getSourceType(param: Any) -> ClickPosition {
        if let source = param as? ClickPosition {
            return source
        } else if let source = param as? Int {
            return ClickPosition(rawValue: source) ?? .other
        }
        return .other
    }
}

public extension GenderType {
    func descText() -> String {
        switch self {
        case .none:
            return "不限"
        case .male:
            return "男"
        case .female:
            return "女"
        }
    }
}

public extension PPTabBarType {
    func descText() -> String {
        switch self {
        case .discovery:
            return "配配"
        case .square:
            return "广场"
        case .message:
            return "消息"
        case .mine:
            return "我的"
        case .moment:
            return "贴贴"
        case .script:
            return "剧情模式"
        case .story:
            return "故事"
        }
    }
}

@objc public enum PPPersionInfoClickType: Int {
    case nickName
    case birthday
    case school
    case location
    
    func desc() -> String {
        switch self {
        case .nickName:
            return "昵称"
        case .birthday:
            return "生日"
        case .school:
            return "学校"
        case .location:
            return "所在地"
        default:
            return ""
        }
    }
}

@objc public enum PPPersionInfoClickPositionSubType: Int {
    case none
    case clear
    case reGet
    
    func desc() -> String {
        switch self {
        case .clear:
            return "清除"
        case .reGet:
            return "重新获取"
        default:
            return ""
        }
    }
}


public enum PPBuriedPointManagerEventType: String {
    case postClick = "post_click"
    case postShow = "post_show"
}

@objc public class PPBuriedPointManagerEvent: NSObject {

    @objc  public  static func startTrackTimer() {
        XHBStatisticsManager.sharedInstance().startTrackTimer()
    }

    @objc public  static func eventV3(_ event: String, params: [String: Any]?) {
        DDLogInfo("埋点======event:\(event) params:\(String(describing: params))")
        if params == nil {
            XHBStatisticsManager.track(event)
        } else {
            XHBStatisticsManager.track(event, withVariable: params!)
        }
    }

// MARK: app启动时上报---------
    /// app启动时上报
    @objc public static func appStartup() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.eventV3("app_startup", params: nil)
        }
    }

    /// app前后台切换  aciton：切换行为 切换前台 切换后台
    /// - Parameter isBack: 切换行为 切换前台 切换后台 true 是后台 fals 前天
    @objc public static func appChangeBackup(isBack: Bool) {
        var dic = [String: Any]()
        var action = "切换前台"
        if isBack {
            action = "切换后台"
        }
        dic["aciton"] = action
        self.eventV3("app_change_backup", params: dic)
    }

    /*
    @objc public static func appFront() {
        eventV3("app_front", params: nil)
    }*/

// MARK: 登录/注册流程 ---------
    /// 登陆页面曝光 登陆页面曝光时上报，包含首次登陆注册与非首次登陆。
    /// source ：登录页面 1.一键登录页 2.常规登录页
    public  static func openLoginShow(source: OpenLoginShowSource) {
        var dic = [String: Any]()
        dic["source"] = source.string()

       self.eventV3("open_login_show", params: dic)
    }

    /*登陆页按钮点击*/
    /// 登陆页面曝光 登陆页面曝光时上报，包含首次登陆注册与非首次登陆。
    /// source ：登录页面 1.一键登录页 2.常规登录页
    public  static func loginClick(source: OpenLoginShowSource, position: LogInPosition) {
        var dic = [String: Any]()
        dic["source"] = source.string()
        dic["position"] = position.string()
       self.eventV3("login_click", params: dic)
    }

    ///
    /*登陆成功*/
    /// 登陆成功（如新用户，包含注册成功）后上报
   /// 用if_new_register区分是否新注册用户

    @objc public  static func loginSuccess(position: LogInPosition, newRegister: NewRegisterType) {
        var dic = [String: Any]()
        dic["if_new_register"] = newRegister.string()
        dic["position"] = position.string()
       self.eventV3("login_success", params: dic)
    }

    /// 注册页面完善资料页 - 新用户注册流程完善资料页曝光时上报
    public  static func registerilloutShow(position: LogInPosition) {
        var dic = [String: Any]()
        dic["position"] = position.string()
       self.eventV3("register_fillout_show", params: dic)
    }

    /// 注册页面完善资料页 - 新用户注册流程完善资料页曝光时上报
    public   static func registerFilloutSuccess(position: LogInPosition, tabId: ImproveInfo) {
        var dic = [String: Any]()
        dic["position"] = position.string()
        dic["tab_id"] = tabId.string()
       self.eventV3("register_fillout_success", params: dic)
    }

// MARK: - 钓鱼 & 星座速配
    /// 【钓鱼】钓鱼页面曝光
    @objc public static func fishingShow(source: ExposureSource) {
        eventV3("fishing_show", params: [
            "source": source.descText()
        ])
    }

    /// 【钓鱼】开始钓鱼
    @objc public static func startFishing(content: String?,
                                          is_fish_sign: Bool,
                                          target_gender: GenderType,
                                          target_label: String?,

                                          if_success: Bool,
                                          is_free: Bool) {
        eventV3("fishing_start_click", params: [
            "fish_content": content ?? "",
            "is_fish_sign": is_fish_sign ? 1 : 0,
            "target_gender": target_gender.rawValue,
            "target_label": target_label ?? "",
            "if_success": if_success ? 1 : 0,
            "is_free": is_free ? 1 : 0
        ])
    }

    /// 【星座速配】星座速配页面曝光
    @objc public static func constellationShow(source: ExposureSource) {
        eventV3("constellation_show", params: [
            "source": source.descText()
        ])
    }

// MARK: - 发现
    /// 【发现】发现页面曝光
    @objc public static func exploreShow(source: ExposureSource, to_uuid: String) {
        eventV3("explore_show", params: [
            "source": source.descText(),
            "to_uuid": to_uuid
        ])
    }

    /// 上报：点击发弹幕, 弹出发弹幕
    @objc public static func clickSendBarrage(to_uuid: String) {
        eventV3("bullet_chat_publish_click", params: [
            "to_uuid": to_uuid
        ])
    }

    /// 上报：发送弹幕时
    @objc public static func sendBarrage(to_uuid: String, content: String) {
        eventV3("bullet_chat_publish", params: [
            "to_uuid": to_uuid,
            "bullet_content": content
        ])
    }

    /// 广告点击
    /// position：帖子 , 评论
    @objc public static func adClick(ad_id: String, source: ExposureSource, adtype: PPAdStyle) {
        eventV3("ad_click", params: [
            "ad_id": ad_id,
            "source": source.descText(),
            "type": adtype.descText()
        ])
    }

    // 关注取消关注
    /*
     ///关注
     case actionFollow = 1
     ///取消关注
     case actionCancleFollow = 2
     ///邀请关注
     case actionInvateFollow = 3
     ///回粉
     case actionBackFollow = 4
     */
    @objc public static func userFocusOrUnFocusClick(source: ExposureSource, followStatus: String, touuid: String) {

        var eventType = "user_unfocus_click"
        if followStatus == "2" || followStatus == "0" {
            eventType = "user_focus_click"
        }
        eventV3(eventType, params: [
            "source": source.descText(),
            "to_uuid": touuid
        ])
    }

    // 弹窗或引导链接曝光时上报
    @objc public static func postGuidShow(tab: PostTab) {
        eventV3("post_guide_show", params: [
            "tab": tab.descText()
        ])
    }

    @objc public static func adEventShow(ad_id: String) {
        eventV3("ad_show", params: [
            "ad_id": ad_id
        ])
    }

    /*
     to_uuid：对象uuid
     play_seq：用户开始的第几次剧本
     screenplay_uuid：剧情ID
     module_id: 模块ID
     page_id: 页数, 当前模块第几页
     conversation_id：会话ID
     screenplay_conversation_uuid：剧情会话ID
     */
    @objc public static func screenplaySkip(to_uuid: String,
                                            screenplay_uuid: String,
                                            module_id: String,
                                            page_id: Int,
                                            conversation_id: String,
                                            screenplay_conversation_uuid: String) {
        eventV3("screenplay_skip_click", params: [
            "to_uuid": to_uuid,
            "screenplay_uuid": screenplay_uuid,
            "module_id": module_id,
            "page_id": page_id,
            "conversation_id": conversation_id,
            "screenplay_conversation_uuid": screenplay_conversation_uuid
        ])
    }

    @objc public enum popWindowType: Int {
        case none
        case system
        case guide
        case explain
        case remind
        case activity

        func getTypeDescription() -> String {
            switch self {
            case .system:
                return "系统弹窗"
            case .guide :
                return "引导弹窗"
            case .explain:
                return "说明弹窗"
            case .remind:
                return "提醒弹窗"
            case .activity:
                return "活动弹窗"
            default:
                return ""
            }
        }
    }

    @objc public static func popShow(type: popWindowType, pop_content: String) {
        eventV3("pop_show", params: [
            "type": type.getTypeDescription(),
            "pop_content": pop_content
        ])
    }

    
    @objc public enum TopicSourceType: Int {
        case none
        case person
        case square
        case detail
        
        func getTypeDescription() -> String {
            switch self {
            case .person:
                return "个人主页"
                
            case .square:
                return "动态广场"
                
            case .detail:
                return "动态详情页"
                
            default:
                return ""
            }
        }
    }
    
    @objc public static func postTopClick(source: TopicSourceType, ifTop: Bool) {
        eventV3("post_top_click", params: [
            "source": source.getTypeDescription(),
            "if_top": ifTop ? 1 : 0
        ])
    }
    
    
    @objc public static func topicIncreaseClick() {
        eventV3("topic_increase_click", params: nil)
    }
    
    
    @objc public static func topicSearchShow() {
        eventV3("topic_search_show", params: [
            "source": "发布动态",
        ])
    }
    
    @objc public static func topicSearchTopicClick(title: String) {
        eventV3("topic_search_topic_click", params: [
            "topic_title": title,
        ])
    }
    
    @objc public static func topicSearchNullShow(title: String) {
        eventV3("topic_search_null_show", params: [
            "keyword": title,
        ])
    }
    
    @objc public static func moreViewClick(uuid: String,type: String, stage: Int, screenplayUuid: String, conversationId: String, screenplayConversationUuid:String) {
        eventV3("message_more_click", params: [
            "to_uuid": uuid,
            "type": type,
            "stage": stage,
            "screenplay_uuid": screenplayUuid,
            "conversation_id": conversationId,
            "screenplay_conversation_uuid": screenplayConversationUuid
        ])
    }
    
    @objc public enum PPMessageQuestionSettleType: Int {
        case changeBatch
        case confirm
        case defaultProblem
        
        func descText() -> String {
            switch self {
            case .changeBatch:
                return "换一批"
                
            case .confirm:
                return "确定"
                
            case .defaultProblem:
                return "预设问题"
                
            default:
                return ""
            }
        }
    }
    
    /// 设定问题弹窗点击
    @objc public static func messageQuestionSettleClick(type: PPMessageQuestionSettleType, sub_type: String) {
        eventV3("message_question_settle_window_click", params: [
            "type": type.descText(),
            "sub_type": sub_type,
        ])
    }
    
    @objc public enum PPMessageQuestionShowType: Int {
        case person
        case dazhaohu
        
        func descText() -> String {
            switch self {
            case .person:
                return "个人主页"
                
            case .dazhaohu:
                return "打招呼按钮"
                
            default:
                return ""
            }
        }
    }
    
    ///点击弹幕
    @objc public static func clickBarrageView(source: ClickPosition, toUuid: String) {
        var text = source.descText()
        if text == "发现" {
            text = "发现页"
        }
        eventV3("bullet_click", params: [
            "page": text,
            "to_uuid": toUuid,
        ])
    }
    
    ///弹幕个人资料卡展示
    @objc public static func barrageViewPersonalInfoCardShow(source: ClickPosition, toUuid: String) {
        var text = source.descText()
        if text == "发现" {
            text = "发现页"
        }
        eventV3("bullet_personal_infocard_show", params: [
            "page": text,
            "to_uuid": toUuid,
        ])
    }
    
    /// 设定问题弹窗曝光
    @objc public static func messageQuestionSettleShow(source: PPMessageQuestionShowType) {
        eventV3("message_question_settle_window_show", params: [
            "source": source.descText(),
        ])
    }
    
    @objc public enum PPMessageSayhelloWindowType: Int {
        case normal
        case gift
        case problem
        
        func descText() -> String {
            switch self {
            case .normal:
                return "普通"
            case .gift:
                return "礼物"
            case .problem:
                return "问题"
                
            default:
                return ""
            }
        }
    }
    
    @objc public enum PPMessageSayhelloTabType: Int {
        case notExit
        case person
        case discovery
        case moment
        case dynamicList
        case dynamicDetail
        case disconveryProfile
        case personCenterProfile
        case topicDetail
        case shcool
        case address
        
        func descText() -> String {
            switch self {
            case .person:
                return "个人主页"
            case .discovery:
                return "发现"
            case .moment:
                return "瞬间群内个人弹窗"
            case .dynamicList:
                return "动态广场"
            case .dynamicDetail:
                return "动态详情"
            case .disconveryProfile:
                return "发现页弹幕个人资料卡"
            case .personCenterProfile:
                return "个人主页弹幕个人资料卡"
            case .topicDetail:
                return "话题详情页"
            case .shcool:
                return "学校页"
            case .address:
                return "地址页"
            default:
                return ""
            }
        }
    }
    
    /// "打招呼"弹窗曝光
    @objc public static func messageSayhelloWindowShow(type: PPMessageSayhelloWindowType, tab: PPMessageSayhelloTabType, toUuid: String, subSource: PostTopTab , subSourceDesc: String) {
        var subText = ""
        if subSource == .recommend || subSource == .new || subSource == .follow  || subSource == .tongcheng  {
            subText = subSource.descText()
        } else {
            subText = subSourceDesc
        }
        eventV3("message_sayhello_window_show", params: [
            "type": type.descText(),
            "tab": tab.descText(),
            "to_uuid": toUuid,
            "sub_tab": subText
        ])
    }
    
    
    @objc public enum PPMessageQuestionReply: Int {
        case person
        case directMessages
        
        func descText() -> String {
            switch self {
            case .person:
                return "个人主页"
            case .directMessages:
                return "私信详情页"
                
            default:
                return ""
            }
        }
    }
    
    @objc public static func messageQuestionWindowReplyClick(source: PPMessageQuestionReply, toUuid: String) {
        eventV3("message_question_window_reply_click", params: [
            "source": source.descText(),
            "to_uuid": toUuid,
        ])
    }
    
    @objc public static func messageQuestionWindowShow(source: PPMessageQuestionReply, toUuid: String) {
        eventV3("message_question_window_show", params: [
            "source": source.descText(),
            "to_uuid": toUuid,
        ])
    }
    
}
