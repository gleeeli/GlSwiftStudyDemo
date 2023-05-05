//
//  PPBuriedPointManagerEvent+Message.swift
//  PPBaseModule
//
//  Created by liguanglei on 2022/11/9.
//

import Foundation
import XHBTool

extension PPBuriedPointManagerEvent {
    // MARK: 私信 -----------
    /// 注册页面完善资料页 - 新用户注册流程完善资料页曝光时上报
    /// 私聊页内时用户主动发消息时上报 （不包含系统tip，不包含伪消息）
    /*
     用if_success区分消息是否发送成功
     1-发送成功
     0-发送失败
     用msg_ content_type区分消息格式（普通文字消息包含emoji，并且区分消息是否带心情属性）
     用msg_type区分消息类型
     */
    
    public   static func messageSend(to_uuid: String = "",
                                     msg_type: String,
                                     msg_content_type: String,
                                     isMoon: Bool,
                                     if_success: Bool ,
                                     conversationId: String,
                                     screenplayConUuid: String,
                                     screenplayUuid: String) {
        
        var dic = [String: Any]()
        dic["to_uuid"] = to_uuid
        dic["msg_type"] = msg_type
        dic["msg_content_type"] = msg_content_type
        dic["is_moon"] = isMoon ? "1" : "0"
        dic["if_success"] = if_success ? "1" : "0"
        
        if !NSString.isEmpty(conversationId) {
            dic["conversation_id"] = conversationId
        }
        if !NSString.isEmpty(screenplayUuid) {
            dic["screenplay_uuid"] = screenplayUuid
        }
        if !NSString.isEmpty(screenplayConUuid) {
            dic["screenplay_conversation_uuid"] = screenplayConUuid
        }
        
        self.eventV3("message_send", params: dic)
    }
    
    /// 收到消息（私聊）
    @objc  public  static func messageReceive(msg_type: String,
                                              msg_content_type: String,
                                              isMoon: Bool,
                                              fromUuid: String,
                                              conversationId: String,
                                              screenplayConUuid: String,
                                              screenplayUuid: String) {
        var dic = [String: Any]()
        dic["msg_type"] = msg_type
        dic["msg_content_type"] = msg_content_type
        dic["is_moon"] = isMoon ? "1" : "0"
        dic["from_uuid"] = fromUuid
        if !NSString.isEmpty(conversationId) {
            dic["conversation_id"] = conversationId
        }
        if !NSString.isEmpty(screenplayUuid) {
            dic["screenplay_uuid"] = screenplayUuid
        }
        if !NSString.isEmpty(screenplayConUuid) {
            dic["screenplay_conversation_uuid"] = screenplayConUuid
        }
        self.eventV3("message_receive", params: dic)
    }
    
    /// 【消息】消息页面曝光
    @objc public static func messageShow( tab: ExposureTab) {
        eventV3("message_show", params: [
            "tab": tab.descText()
        ])
    }
    
    @objc public static func messageListClick(position: ClickPosition) {
        eventV3("message_messagelist_click", params: [
            "position": position.descText()
        ])
    }
    
    /// 打招呼按钮点击
    @objc public static func messageSayHelloClick(tab: ClickPosition, toUuid: String, subSource: PostTopTab, subSourceDesc: String) {
        var subText = ""
        if subSource == .recommend || subSource == .new || subSource == .follow  || subSource == .tongcheng  {
            subText = subSource.descText()
        } else {
            subText = subSourceDesc
        }
        eventV3("message_sayhello_click", params: [
            "tab": tab.descText(),
            "to_uuid": toUuid,
            "sub_tab": subText
        ])
    }
    
    // MARK: - tab
    /// 底部tab
    @objc public static func bottomTabClick(vc: UIViewController) {
        func postEvent(vcName: String) {
            if let item = PPTabBarManager.shared.getItem(vcName: vcName) {
                print("postEvent: ", vcName)
                self.eventV3("app_mainpage_bottom_click", params: ["position": item.type.descText()])
            }
        }
        if let nav = vc as? UINavigationController {
            if !nav.viewControllers.isEmpty {
                postEvent(vcName: NSStringFromClass(nav.viewControllers.first!.classForCoder))
            }
        } else {
            postEvent(vcName: NSStringFromClass(vc.classForCoder))
        }
    }
    
    /// 消息顶部卡片点击
    @objc public static func messageTopCardClick(position: String) {
        eventV3("message_topcard_click", params: [
            "position": position
        ])
    }
    
    // 进入私信详情页
    @objc public static func messageDetailShow(source: ExposureSource,
                                               touuid: String,
                                               type: PPBPChatMode,
                                               conversationId: String,
                                               screenplay_uuid: String,
                                               screenplay_conversation_uuid: String, status: CMChatStatus) {
        eventV3("message_detail_show", params: [
            "source": source.descText(),
            "to_uuid": touuid,
            "type": type.descText(isPlotRetainSame: true),
            "conversation_id": conversationId,
            "screenplay_uuid": screenplay_uuid,
            "screenplay_conversation_uuid": screenplay_conversation_uuid,
            "status": status.descText()
        ])
    }
    
    
    @objc public static func messageTimelyHintShow() {
        eventV3("message_timely_hint_window_show", params: nil)
    }

    @objc public static func messageTimelyHintClick() {
        eventV3("message_timely_hint_window_click", params: nil)
    }
    
    @objc public static func messageSquareIconShow(toUUid: String,
                                                   conversationId: String) {
        eventV3("message_square_icon_show", params: [
            "conversation_id": conversationId,
            "to_uuid": toUUid
        ])
    }
    
    @objc public static func intimacyTipShow(to_uuid: String?) {
        eventV3("intimacy_degree_tip_show", params: [
            "to_uuid": to_uuid ?? ""
        ])
    }
    
    ///根据scene上报不同的id, 如果非瞬间群, 瞬间群id就上报空字符串即可 , 其它类似
    @objc public static func messageBoxClick(scene: PPBPChatMode, btnType: PPMessageChatFuncButtonType, screenplayUuid: String?, conversationId: String?, instantUuid: String?) {
        eventV3("message_box_click", params: [
            "scene": scene.descText(isPlotRetainSame: false),
            "type": btnType.descText(),
            "screenplay_uuid": screenplayUuid ?? "",
            "conversation_id": conversationId ?? "",
            "instant_uuid": instantUuid ?? ""
        ])
    }
    
    
    
//    @objc public static func messageTimelyDisappear(conversation_id: String, to_uuid: String) {
//        eventV3("message_timely_disappear", params: [
//            "conversation_id" : conversation_id,
//            "to_uuid" : to_uuid
//        ])
//    }
    
}
