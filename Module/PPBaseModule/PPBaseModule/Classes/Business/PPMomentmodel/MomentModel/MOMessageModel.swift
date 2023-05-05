//
//  MOMessageModel.swift
//  MomentModule
//
//  Created by WJK on 2022/6/13.
//
/// 该类较特殊 是群聊的model类 所以不修改

import UIKit
import XHBIMClient
// import XHBSwiftKit
import SwiftyJSON
// import ConfigModule
import HandyJSON

/// 隐藏资料卡
public let MomentHideenProfileView = "MomentHideenProfileView"
/// 敏感
public let sensitiveMsg = "请保持良好的社交礼仪，请勿发送违规、涉黄信息，否则将冻结账号"

public protocol MOMessageCalculationProtocol {
    func preCalculateFrame()
}
extension MOMessageCalculationProtocol {
    func preCalculateFrame() {

    }
}

public enum MOguessingType: String {
    case moment_meme_dice
    case moment_meme_fist_guessing
}

/// 群聊的消息类型 mm_msg
public let MOMentMsgType: String = "mm_msg"

@objc public class MOMentMsgType_oc: NSObject {
    @objc public static var _MOMentMsgType: String {
        return MOMentMsgType
    }
}

public enum MOMessageSubType: String {
    case unkonw // 未知
    /// ■ : 普通消息
    case normal
    /// ■ voice: 语音
    case voice
    /// ■ picture: 图片
    case picture
    /// ■ share: 瞬间群聊分享 20220708 有分享到私信的功能没有分享到群聊的功能
    case share
    /// ■ meme: 表情包
    case meme
    /// ■ apply_conn_mic: 申请连麦消息
    case apply_conn_mic
}

/// 消息状态
public enum MoMessagesendStatus: Int {
    case unKnow = 0
    case sending = 1
    case success = 2
    case failure = 3
    case warning = 4

//    getImage 在 moment 组件中
}

/**
 ■ normal: 普通消息
 ■ voice: 语音
 ■ picture: 图片
 ■ share: 瞬间群聊分享
 ■ meme: 表情包
 ■ apply_conn_mic: 申请连麦消息*/

/** "app_msg_id" = 43efd1eafc913350677933d05ee615a0;
 "at_list" = "<null>";
 "create_time" = 1652176854;
 "date_show" = 0;
 extra =     {
     "account_avatar" = "default_avatar-male-073.png";
     "img_check" = 1;
     "moment_default_tag" = "default_img_first";
     "moment_img_url" = "peipeix_android_ppx-img_800_1650634822580_3_0_18179.jpg";
     "moment_title" = "\U662f\U662f\U662f\U662f\U662f\U662f\U662f\U662f\U662f";
     "owner_uuid" = wewdeibaeab0km45;
     "push_content" = "[\U8868\U60c5\U6d88\U606f]";
     "push_image" = "peipeix_android_ppx-img_800_1650634822580_3_0_18179.jpg";
     "push_nickname" = "\U963f\U80fd26";
     "push_relaction" = "m=moment_room&a=room&id=mgedm54vt1";
     "push_title" = "\U77ac\U95f4";
 };
 "is_speak" = 1;
 "moment_uuid" = mgedm54vt1;
 "msg_id" = 1652176854608206;
 params = "{\"meme_img_url\":\"\",\"meme_id\":\"moment_meme_fist_guessing\",\"height\":130,\"width\":130,\"meme_value\":1}";
 "quote_msg" = "<null>";
 "quote_msg_type" = "";
 sender =     {
     "account_uuid" = wejfetbaeabs4bll;
     avatar = "default_avatar-male-073.png";
     name = "\U6c99\U6cb3\U7684\U594b\U6597913743";
     "sex_type" = 1;
 };
 type = meme;*/

public class MOMessageModel: XHBSocketIOMessage {
    required override init() {
        super.init()
    }
// MARK: - frame开始
//    
//    var messageFrame = MOMessageFrame()
// MARK: - frame结束

    /// 消息ID
    public  var msgId = ""
    /// 群聊UUID
    public  var momentUuid = ""
    /// 消息类型
    public  var type = ""
    public var messageSubType: MOMessageSubType = .unkonw

    /// 类型特定信息，按类型定义
    public var createTime = ""
    public var createTimeString = ""
    /// 客户端指定消息id:
    public var appMsgId = ""
    /// 发送者信息
    public var sender: MOSenderMode?
    /// 被at用户列表
    public var atList: [MOAtMode]?

    /// 0: 没有发过言  1:发言过
    public var isSpeak = 0
    /// 被引用消息体
    public var quoteMsg: MOMessageModel?
    /// 如果本条消息有引用 (数据类型：string)
    public  var quoteMsgType = ""
    /// 标签e 其他字段推送相关
    public var extra: [String: Any]?
    /// 类型特定信息，按类型定义
    public var params: [String: Any]?
    /// 需要展示时间 0 不展示 1展示
    public var dateShow = 0

    // MARK: - 添加自用

    public  var isChangContent = true

    public var subText = ""
    public var  sendStatus: MoMessagesendStatus = .unKnow
    public var  voiceData: Data? // 没上传 不为空,上传成功置为空 传成功标识

    // MARK: - 添加自用
   private var _messageBaseContent: MOMessageBaseContent?
    public  var messageBaseContent: MOMessageBaseContent {
        get {
            if isChangContent {
                _messageBaseContent =  MOMessageBaseContent(dic: self.params ?? [String: Any]())
            }
            isChangContent = false
            if _messageBaseContent?.isSensitive == 1 {
                self.sendStatus = .warning
            }
            return _messageBaseContent ?? MOMessageBaseContent(dic: [String: Any]())
        }
        set {
            _messageBaseContent = newValue
        }

    }

    public override static func message(withItems items: [Any]!) -> Self? {
        let message = MOMessageModel()
        message.momentUuid = items[0] as? String ?? ""
        message.type = items[1] as? String ?? ""
        message.messageSubType =  MOMessageSubType(rawValue: message.type) ?? .unkonw

        let senderJson = items[2] as? String ?? ""
        let sender = NSString.dictionary(withJsonString: senderJson) as? [String: Any] ?? [String: Any]()
        message.sender = MOSenderMode(dic: sender )

        let at_list_Json = items[3] as? String ?? ""
        if !NSString.isEmpty(at_list_Json), let data = at_list_Json.data(using: .utf8) {
            do {

                if let at_list_array = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                    message.atList = MOAtMode.cover(json: at_list_array)
                }
            } catch _ {

            }

        }

        let params_Json = items[4] as? String ?? ""
        let params =  NSString.dictionary(withJsonString: params_Json) as?  [String: Any] ?? [String: Any]()
        message.params = params

        message.createTime = items[5] as? String ?? ""
        message.msgId = items[6] as? String ?? ""
        message.appMsgId = items[7] as? String ?? ""

        let extra_Json = items[8] as? String ?? ""
        let extra =  NSString.dictionary(withJsonString: extra_Json) as?  [String: Any] ?? [String: Any]()
        message.extra = extra

        message.quoteMsgType = items[9] as? String ?? ""

        let quote_msg_Json = items[10] as? String ?? ""
        let quote_msg =  NSString.dictionary(withJsonString: quote_msg_Json) as?  [String: Any] ?? [String: Any]()
        message.quoteMsg = MOMessageModel(quote_msg)
        message.quoteMsg?.params = quote_msg // 适配安卓

        if items.count > 12 {
        let is_speak = items[11] as? String ?? ""
        var is_speakInt = 0
        if NSString.isEmpty(is_speak) {
            is_speakInt = items[11] as? Int ?? 0
        } else {
            is_speakInt = Int(is_speak) ?? 0
        }
        message.isSpeak = is_speakInt

        }

        if items.count > 13 {
            let date_Show = items[12] as? String ?? ""
            var date_ShowInt = 0

            if NSString.isEmpty(date_Show) {
                date_ShowInt = items[12] as? Int ?? 0
            } else {
                date_ShowInt = Int(date_Show) ?? 0
            }
            message.dateShow = date_ShowInt
        }

//        if let accountUuid =  message.sender?.accountUuid , let leaderUuid = MOMomentRoomManager.shared.roomModel?.accountUuid ,accountUuid == leaderUuid {
//            message.isOwer = true
//        }

        return message as? Self
    }

    public  convenience  init(_ dic: [String: Any]) {
        self.init()
        let json = JSON(dic)

        self.msgId = json["msg_id"].stringValue
        self.momentUuid = json["moment_uuid"].stringValue
        self.type = json["type"].stringValue
        self.messageSubType =  MOMessageSubType(rawValue: self.type) ?? .unkonw
        self.createTime = json["create_time"].stringValue
        self.appMsgId = json["app_msg_id"].stringValue

        let senderDic =  json["sender"].dictionaryValue
        self.sender = MOSenderMode(dic: senderDic)

        let tmpatList = json["at_list"].arrayObject as? [[String: Any]]  ?? [[String: Any]]()
        self.atList =  MOAtMode.cover(json: tmpatList)

        self.isSpeak = json["is_speak"].intValue

        let quoteMsgString = json["quote_msg"].stringValue
        if  !NSString.isEmpty(quoteMsgString) {
            let quoteMsgDic =  NSString.dictionary(withJsonString: quoteMsgString) as?  [String: Any] ?? [String: Any]()
            self.quoteMsg =  MOMessageModel(quoteMsgDic)
            self.quoteMsg?.params = quoteMsgDic  // 适配安卓
        }

        self.quoteMsgType = json["quote_msg_type"].stringValue
        self.extra = json["extra"].dictionaryValue
        let params_json = json["params"].stringValue
        let paramsString =  NSString.dictionary(withJsonString: params_json) as?  [String: Any] ?? [String: Any]()
        self.params = paramsString

        self.dateShow = json["date_show"].intValue

    }

    public static func cover(json: [[String: Any]]) -> [MOMessageModel] {
        var models = [MOMessageModel]()
        for (_, value) in json.enumerated() {
            let model = MOMessageModel(value)
            models.append(model)
        }
        return models
    }

    /// 是不是竞猜的msg
    public  func getGuessingMes() -> Bool {
        if self.type == MOMessageSubType.meme.rawValue && ( self.messageBaseContent.memeId == MOguessingType.moment_meme_dice.rawValue ||  self.messageBaseContent.memeId == MOguessingType.moment_meme_fist_guessing.rawValue ) {
             return true
        }
        return false
    }

    /// 是不是自己发的消息
    public func isMyMsg() -> Bool {
        if  let account = self.sender?.accountUuid, !NSString.isEmpty(account) {
            return account == XHBConfigure.accountUuid()
        }
        return false
    }
    /// 语音消息
    public  func isVoiceMsg() -> Bool {
        return   self.type == MOMessageSubType.voice.rawValue
    }

    /// 语音消息
    public  func isReplyMsg() -> Bool {
        if self.type == MOMessageSubType.normal.rawValue {
           return self.messageBaseContent.isQuote == 1
        }
        return false
    }
    /// 邀请上麦
    public  func isApplyMeUpMic() -> Bool {

        return  self.type == MOMessageSubType.apply_conn_mic.rawValue
    }

    public  func toDictionary() -> [String: Any] {
        var contentDic = [String: Any]()
        contentDic.setObjectSafe(any: self.msgId, key: "msg_id")
        contentDic.setObjectSafe(any: self.momentUuid, key: "moment_uuid")
        contentDic.setObjectSafe(any: self.type, key: "type")
        contentDic.setObjectSafe(any: self.createTime, key: "create_time")
        contentDic.setObjectSafe(any: self.appMsgId, key: "app_msg_id")
        contentDic.setObjectSafe(any: self.isSpeak, key: "is_speak")

//        contentDic.setObjectSafe(any: self.extra!, key: "extra")
        _  =  convertDictionaryToJSONString(dict: self.params!)
//        contentDic.setObjectSafe(any:paramStr, key: "params")

//        let atListJson = self.atList?.toJSONString() ?? ""
//        contentDic.setObjectSafe(any: atListJson, key: "at_list")

        let sendDtr =  self.sender?.toDictionary()

        contentDic.setObjectSafe(any: sendDtr, key: "sender")

        for (_, value) in self.params!.enumerated() {
            contentDic.setObjectSafe(any: value.value, key: value.key)
        }
        return contentDic

    }

    public  func convertDictionaryToJSONString(dict: [String: Any]?) -> String {
        var TmpDic = dict

        if  TmpDic == nil {
            TmpDic = [String: String]()
        }

        let data = try? JSONSerialization.data(withJSONObject: TmpDic!, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        let jsonStr = String(data: data!, encoding: .utf8) ?? ""
        return jsonStr
    }

}

public class MOAtMode: NSObject, HandyJSON {
    required public override init() {
        super.init()
    }
    /// 账号UUID
    public var accountUuid = ""
    ///
    public var nickname = ""
    /// 账号性别
    public var sexType = ""
    public init(dic: [String: Any]) {

        let json = JSON(dic)
        self.accountUuid = json["account_uuid"].stringValue
        self.nickname = json["nickname"].stringValue
        self.sexType = json["sex_type"].stringValue

    }

    public  static func cover(json: [[String: Any]]) -> [MOAtMode] {
        var atList = [MOAtMode]()

        for (_, value) in json.enumerated() {
            let model = MOAtMode(dic: value)
            atList.append(model)
        }
        return atList
    }
}

@objc public  class MOSenderMode: NSObject, HandyJSON {
    required public override init() {
        super.init()
    }
    /// 账号头像
    @objc   public     var avatar = ""
    /// 账号UUID
    @objc  public  var accountUuid = ""
    ///
    @objc public  var name = ""
    /// 账号性别
    @objc  public  var sexType = ""
    
    @objc public var avatarBoxImg = ""

    public var isLeader = false

    public   init(dic: [String: Any]) {

        let json = JSON(dic)
        self.accountUuid = json["account_uuid"].stringValue
        self.name = json["name"].stringValue
        self.sexType = json["sex_type"].stringValue
        let avater = json["avatar"].stringValue
        self.avatarBoxImg = json["avatar_box_img"].stringValue
        self.avatar = XHBConfigure.append(with: .hostTypeAvatar, urlPath: avater)

    }

    public func toDictionary() -> [String: Any] {
        var contentDic = [String: Any]()
        contentDic.setObjectSafe(any: accountUuid, key: "account_uuid")
        contentDic.setObjectSafe(any: name, key: "name")
        contentDic.setObjectSafe(any: sexType, key: "sex_type")
        contentDic.setObjectSafe(any: avatar, key: "avatar")

     return contentDic
    }
}

public class MOMessageBaseContent: NSObject {
    // MARK: - 普通消息 normal
    public var message = ""
    public var isQuote = 0
    public var moodBgType = ""
    public var moodEmojiType = ""
    public var moodEmojiBgType = ""
    // MARK: - 语音
    public var voiceUrl = ""
    public var voiceDuration = ""
    /// 本条消息是否敏感; 0:不敏感；1：敏感
    public var isSensitive = 0

    // MARK: - 图片

    public var pictureUrl = ""
    public var height: CGFloat = 0
    public var width: CGFloat = 0
    // MARK: - share
    public var momentImgUrl = ""
    public var momentUuid = ""
    public var title = ""
    // MARK: - meme
    public var memeImgUrl = ""
    public var memeId = ""
    //    var height :CGFloat = 0
    //    var width: CGFloat = 0
    /// 0~N : 整型：表示 如骰子的结果图
    public var memeValue = 0

    // MARK: - 邀请
    //    var message = ""
    public var btnStatus: MOMessageApplyConnMic = .unKnow

    init(dic: [String: Any]) {
       let json = JSON(dic)

        self.message = json["message"].stringValue
        self.isQuote = json["is_quote"].intValue
        self.moodBgType = json["mood_bg_type"].stringValue
        self.moodEmojiType = json["mood_emoji_type"].stringValue
        self.moodEmojiBgType = json["mood_emoji_bg_type"].stringValue

        self.voiceUrl = json["voice_url"].stringValue
        self.voiceDuration = json["voice_duration"].stringValue
        self.isSensitive = json["is_sensitive"].intValue

        self.pictureUrl = json["picture_url"].stringValue
        self.height = CGFloat(json["height"].floatValue)
        self.width = CGFloat(json["width"].floatValue)

        self.momentImgUrl = json["moment_img_url"].stringValue
        self.momentUuid  = json["moment_uuid"].stringValue
        self.title = json["title"].stringValue
        // MARK: - meme
        self.memeImgUrl = json["meme_img_url"].stringValue
        self.memeId = json["meme_id"].stringValue
    //    var height :CGFloat = 0
    //    var width: CGFloat = 0
        /// 0~N : 整型：表示 如骰子的结果图
        self.memeValue = json["meme_value"].intValue

        // MARK: - 邀请
    //    var message = ""

      let btn_Status =  json["btn_status"].stringValue
        self.btnStatus = MOMessageApplyConnMic(rawValue: btn_Status) ?? .unKnow

    }

    public func toDictionary() -> [String: Any] {
        var contentDic = [String: Any]()
        contentDic["message"] =  self.message

        contentDic["is_quote"] = self.isQuote
        contentDic["mood_bg_type"] = self.moodBgType
        contentDic["mood_emoji_type"] = self.moodEmojiType
        contentDic["mood_emoji_bg_type"] = self.moodEmojiBgType

        contentDic["voice_url"] =  self.voiceUrl
        contentDic["voice_duration"] =  self.voiceDuration
        contentDic["is_sensitive"] =  self.isSensitive
        contentDic["picture_url"] =  self.pictureUrl
        contentDic["width"] =  self.width
        contentDic["height"] =  self.height

        contentDic["meme_img_url"] =  self.memeImgUrl
        contentDic["meme_id"] =  self.memeId

        return contentDic
    }
}
// MARK: 具体消息体- 后期可根据具体消息类型分开成具体的类型
/// 普通消息 normal
public class MOMessageNormalContent: NSObject {
// MARK: - 普通消息 normal
    public  var message = ""
    public var isQuote = ""
    public var moodBgType = ""
    public var moodEmojiType = ""
    public var moodEmojiBgType = ""
// MARK: - 语音
    public var voiceUrl = ""
    public var voiceDuration = ""
    /// 本条消息是否敏感; 0:不敏感；1：敏感
    public  var isSensitive = 0

    // MARK: - 图片

    public var pictureUrl = ""
    public  var height: CGFloat = 0
    public var width: CGFloat = 0
// MARK: - share
    public  var momentImgUrl = ""
    public  var momentUuid = ""
    public var title = ""
    // MARK: - meme
    public var memeImgUrl = ""
    public var memeId = ""
//    var height :CGFloat = 0
//    var width: CGFloat = 0
    /// 0~N : 整型：表示 如骰子的结果图
    public var memeValue = 0

    // MARK: - 邀请
//    var message = ""
    public var btnStatus: MOMessageApplyConnMic = .unKnow
}

///// 语音消息 normal
// class MOMessageVoiceContent: NSObject {
//
//    var voiceUrl = ""
//    var voiceDuration = ""
//    ///本条消息是否敏感; 0:不敏感；1：敏感
//    var isSensitive = 0
//
// }
//
///// picture消息 normal
// class MOMessagePictureContent: NSObject {
//
//    var pictureUrl = ""
//    var height :CGFloat = 0
//    var width: CGFloat = 0
//
// }
//
///// share消息 normal
// class MOMessageShareContent: NSObject {
//
//    var momentImgUrl = ""
//    var momentUuid˚ = ""
//    var title = ""
//
// }
//
///// share消息 normal
// class MOMessageMemeContent: NSObject {
//
//    var memeImgUrl = ""
//    var memeId = ""
//    var height :CGFloat = 0
//    var width: CGFloat = 0
//    ///0~N : 整型：表示 如骰子的结果图
//    var memeValue = 0
//
// }

/// 上麦邀请状态
public enum MOMessageApplyConnMic: String {
    case unKnow // 未知的
    case accept //: 接受 |
    case failure //: 失效 |
    case invited//: 已邀请"

}
///// share消息 normal
// class MOMessageApplyConnMicContent: NSObject {
//
//    var message = ""
//    var btnStatus :MOMessageApplyConnMic = .accept
//
//
// }
