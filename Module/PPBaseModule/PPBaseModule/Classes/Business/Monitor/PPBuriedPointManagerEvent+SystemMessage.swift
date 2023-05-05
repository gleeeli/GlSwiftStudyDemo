//
//  PPBuriedPointManagerEvent+SystemMessage.swift
//  PPBaseModule
//
//  Created by liguanglei on 2022/11/9.
//

import Foundation
import XHBTool

// MARK: - 系统消息相关 - 小皮 \ 活动通知
 @objc extension PPBuriedPointManagerEvent {
     /// 客户端数据，消息到达用户时上报 - 官方消息推送到达
     public static func receiveSystemMsg(type: String, message_type: String, push_id: String, msg_id: String, title: String, content: String) {
         let  pushTitle = getPushTitle(title: title, content: content)

         eventV3("internal_message_arrive", params: [
             "type": type,
             "message_type": message_type,
             "title": pushTitle,
             "push_id": push_id ,
             "msg_id": msg_id

         ])
     }

     /// 官方消息消息列表点击 - 消息于消息列表中被点击时上报
     public static func messageListSystemMsgClick(type: String, message_type: String, push_id: String, msg_id: String, title: String, content: String) {
         let  pushTitle = getPushTitle(title: title, content: content)
         eventV3("internal_message_list_click", params: [
             "type": type,
             "message_type": message_type,
             "title": pushTitle,
             "push_id": push_id ,
             "msg_id": msg_id
         ])

     }

     /// 官方消息内容曝光消息于消息详情中曝光时上报。 仅页面创建时曝光一次
     public static func systemMsgShow(type: String, message_type: String, push_id: String, msg_id: String, title: String, content: String) {
         let  pushTitle = getPushTitle(title: title, content: content)
         eventV3("internal_message_show", params: [
             "type": type,
             "message_type": message_type,
             "title": pushTitle,
             "push_id": push_id ,
             "msg_id": msg_id
         ])
     }

     /// 官方消息点击 消息点击时上报，点击一次上报一次
     public static func systemMsgClick(type: String, message_type: String, push_id: String, msg_id: String, title: String, is_im: Bool, content: String) {
         let  pushTitle = getPushTitle(title: title, content: content)
         eventV3("internal_message_click", params: [
             "type": type,
             "message_type": message_type,
             "is_im": is_im ? "是" : "否",
             "title": pushTitle,
             "push_id": push_id ,
             "msg_id": msg_id
         ])
     }

     public static func getPushTitle(title: String, content: String ) -> String {
         var titleString = title
         if NSString.isEmpty(title) {
             titleString = ""
             if !NSString.isEmpty(content) {
                 if content.count > 10 {
                     titleString = String(content.prefix(9))
                 } else {
                     titleString = content
                 }

             }
         }

         return titleString
     }
     
}
