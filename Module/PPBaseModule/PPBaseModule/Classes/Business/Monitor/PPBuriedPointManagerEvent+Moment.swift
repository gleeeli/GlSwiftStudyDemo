//
//  File.swift
//  PPBaseModule
//
//  Created by WJK on 2022/8/17.
//

import Foundation
// MARK: - 贴贴
 public extension PPBuriedPointManagerEvent {

     // 【瞬间】进入瞬间群
     static  func tietieJoin(instant_uuid: String, source: ExposureSource) {
         eventV3("instant_join", params: [
             "source": source.descText(),
             "instant_uuid": instant_uuid
         ])
     }

     // 【瞬间】瞬间首页面曝光
     static  func showJoin( source: ExposureSource) {
         eventV3("instant_join", params: [
             "source": source.descText()
         ])
     }

     // 【瞬间】瞬间群发送消息 // 用户于瞬间群内成功发言时上报
     static  func speak(momentUuid: String) {
         eventV3("instant_speak", params: [
             "instant_uuid": momentUuid
         ])
     }

     // 【瞬间】【瞬间】瞬间群个人资料卡曝光 其他用户个人资料卡曝光时上报
     static  func showUserCard(momentUuid: String, to_uuid: String) {
         eventV3("instant_personal_infocard_show", params: [
             "instant_uuid": momentUuid,
             "to_uuid": to_uuid
         ])
     }
     
     // 发布瞬间群页面曝光
     static func createPageShow() {
         eventV3("instant_create_page_show", params: nil)
     }
     
     // 发布瞬间群发布按钮点击
     static func createPublishClick() {
         eventV3("instant_create_publish_click", params: nil)
     }
     
}
