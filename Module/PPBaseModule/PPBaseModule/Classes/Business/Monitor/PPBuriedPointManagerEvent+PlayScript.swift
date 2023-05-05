//
//  PPBuriedPointManagerEvent+PlayScript.swift
//  PPBaseModule
//
//  Created by 林庆霖 on 2022/8/18.
//

import Foundation
import XHBTool

// MARK: - 剧情模式
 public extension PPBuriedPointManagerEvent {
     /// 心动对象被成功选择时上报
     @objc static func plotEnchantedPersonchooseClick(screenplay_uuid: String,
                                                      to_uuid: String,
                                                      tab: ExposureTab) {
         eventV3("plot_enchanted_personchoose_click", params: [
            "screenplay_uuid": screenplay_uuid,
            "to_uuid": to_uuid,
            "tab": tab.descText()
         ])
     }

     /// 选择心动对象页面曝光时上报
     @objc static func plotEnchantedPageShow(screenplay_uuid: String,source:plotScource) {
         eventV3("plot_enchanted_page_show", params: [
            "screenplay_uuid": screenplay_uuid,
            "source": source.getSource()
        ])
     }
     
     /// 心动对象被曝光时上报（被曝光500ms时上报，复现时重复上报）
     @objc static func plotEnchantedPersonShow(screenplay_uuid: String, to_uuid: String) {
         eventV3("plot_enchanted_person_show", params: [
            "screenplay_uuid": screenplay_uuid,
            "to_uuid": to_uuid
         ])
     }

     // 自由聊天上报进度
     @objc static func plotSchedule(screenplayUuid: String, conversationId: String, screenplayConversationUuid: String, actNum: String) {
         eventV3("plot_schedule", params: [
            "screenplay_uuid": screenplayUuid,
            "conversation_id": conversationId,
            "screenplay_conversation_uuid": screenplayConversationUuid,
            "act_num": actNum
         ])
     }
     
     /// 【剧情】选择剧本页面曝光
     @objc static func plotChooseShow(to_uuid: String,
                                              scource: plotScource) {
         eventV3("plot_chooseplay_show", params: [
             "source": scource.getSource(),
             "to_uuid": to_uuid
         ])
     }
     
     ///【剧情】选择剧本
     ///点击进入星球/开启梦境 按钮时上报
     @objc static func plotChooseClick(uuid: String, to_uuid: String,
                                              scource: plotScource) {
         eventV3("plot_chooseplay_click", params: [
             "screenplay_uuid": uuid,
             "source": scource.getSource(),
             "to_uuid": to_uuid
         ])
     }
     
     /// 退出剧情保留态
     @objc static func plotHoldQuit(conversationId: String, toUuid: String) {
         eventV3("plot_hold_quit", params: [
            "conversation_id": conversationId,
            "to_uuid": toUuid
         ])
     }
     
     // MARK: tips 卡片
     
     @objc enum plotCardTipScource: Int {
         case none
         case cardTip      // 卡片tips
         case chatTask     // 自由聊天任务提示
         case progressBar  // 进度条
         
         func getSource() -> String {
             switch self {
             case .none:
                 return "其它"
             case .cardTip:
                 return "卡片tips"
             case .chatTask:
                 return "自由聊天任务提示"
             case .progressBar:
                 return "顶部进度条"
             }
         }
     }
     
     /// 待解锁卡片曝光
     @objc static func plotCardLockShow(to_uuid: String, stage: String, screenplay_uuid: String,
                                        conversation_id: String, screenplay_conversation_uuid: String) {
         eventV3("plot_card_lock_show", params: [
            "to_uuid": to_uuid,
            "stage": stage,
            "screenplay_uuid": screenplay_uuid,
            "conversation_id": conversation_id,
            "screenplay_conversation_uuid": screenplay_conversation_uuid,
         ])
     }
     
     /// 卡片弹窗曝光
     @objc static func plotCardPopShow(to_uuid: String, stage: String, screenplay_uuid: String,
                                       conversation_id: String, screenplay_conversation_uuid: String,
                                       soure: plotCardTipScource) {
         eventV3("plot_card_pop_show", params: [
            "to_uuid": to_uuid,
            "stage": stage,
            "screenplay_uuid": screenplay_uuid,
            "conversation_id": conversation_id,
            "screenplay_conversation_uuid": screenplay_conversation_uuid,
            "soure" : soure.getSource()
         ])
     }
     
     /// 卡片tips点击
     @objc static func plotCardTipsClick(to_uuid: String, stage: String,
                                         screenplay_uuid: String, conversation_id: String,
                                         screenplay_conversation_uuid: String) {
         eventV3("plot_card_tips_click", params: [
            "to_uuid": to_uuid,
            "stage": stage,
            "screenplay_uuid": screenplay_uuid,
            "conversation_id": conversation_id,
            "screenplay_conversation_uuid": screenplay_conversation_uuid,
         ])
     }
     
     /// 卡片tips曝光
     @objc static func plotCardTipsShow(to_uuid: String, stage: String,
                                        screenplay_uuid: String, conversation_id: String,
                                        screenplay_conversation_uuid: String) {
         eventV3("plot_card_tips_show", params: [
            "to_uuid": to_uuid,
            "stage": stage,
            "screenplay_uuid": screenplay_uuid,
            "conversation_id": conversation_id,
            "screenplay_conversation_uuid": screenplay_conversation_uuid,
         ])
     }
     
     /// 自由聊天任务提示曝光
     @objc static func plotTaskTipShow(conversationId: String, toUuid: String, screenplayUuid: String, screenplayConversationUuid: String) {
         eventV3("plot_task_tip_show", params: [
             "conversation_id": conversationId,
             "to_uuid": toUuid,
             "screenplay_uuid": screenplayUuid,
             "screenplay_conversation_uuid": screenplayConversationUuid
         ])
     }
     
     /// 自由聊天任务提示点击（phase: 点击阶段. 如果是tips点击，上报0，其余点击上报当前节点数）
     @objc static func plotTaskTipClick(conversationId: String,
                                        toUuid: String,
                                        screenplayUuid: String,
                                        screenplayConversationUuid: String,
                                        phase: Int) {
         eventV3("plot_task_tip_click", params: [
             "conversation_id": conversationId,
             "to_uuid": toUuid,
             "screenplay_uuid": screenplayUuid,
             "screenplay_conversation_uuid": screenplayConversationUuid,
             "phase" : "\(phase)"
         ])
     }
     
     
     @objc enum ChangePersonPosition: Int {
         case none
         case top
         case bottom
         
         func getPosition() -> String {
             switch self {
             case .none:
                 return ""
             case .top:
                 return "top"
             case .bottom:
                 return "bottom"
             }
         }
     }
     
     /// 换一批
     @objc static func plotChangePersonClick(position: ChangePersonPosition) {
         eventV3("plot_change_person_click", params: ["position" : position.getPosition()])
     }
     
 }


extension PPBuriedPointManagerEvent {
    // MARK: - 剧本

    @objc public enum plotScource: Int {
        case none
        case messagePage
        case privateMessage
        case tabBar
        case reelect
        case firstEnter
        case launchedApp
        case newUserScreenplayAlert // 新用户剧情弹框

        func getSource() -> String {
            switch self {
            case .privateMessage:
                return "私信详情页"
            case .messagePage:
                return "消息页面"
            case .tabBar:
                return "底部tab"
            case .reelect:
                return "重选场景"
            case .firstEnter:
                return "首次触发"
            case .launchedApp:
                return "app 启动"
            case .newUserScreenplayAlert:
                return "新用户剧情弹窗"
            case .none:
                return ""
            }
        }

        func getEnterClick() -> String {
            switch self {
            case .privateMessage:
                return "私信详情页"
            case .messagePage:
                return "消息页面"
            case .tabBar:
                return "底部tab"
            default:
                return ""
            }
        }

        func getEnterSource() -> String {

            switch self {
            case .messagePage:
                return "消息页面"
            case .privateMessage:
                return "私信详情页"
            case .tabBar:
                return "底部tab"

            default:
                return "私信详情页"
            }
        }

        func getVerifyUpgradedSource() -> String {
            switch self {
            case .messagePage:
                return "消息页面"
            case .privateMessage:
                return "剧本选择_私信"
            case .launchedApp :
                return "app启动"
            case .newUserScreenplayAlert:
                return "新用户剧情弹窗"
            default:
                return "剧本选择_匹配"
            }
        }
    }

    @objc public static func plotDonwloadStart(uuid: String, scource: plotScource) {
        eventV3("plot_download_start", params: [
            "screenplay_uuid": uuid,
            "tab": scource.getVerifyUpgradedSource()
        ])
    }

    @objc public static func plotSownloadFinish(uuid: String, scource: plotScource, isSilent: Bool) {
        eventV3("plot_download_finish", params: [
            "screenplay_uuid": uuid,
            "tab": scource.getVerifyUpgradedSource(),
            "station_yes_no": isSilent ? "静默状态" : "非静默状态"
        ])
    }


    @objc public static func plotEnterClick(scource: plotScource) {
        if !scource.getEnterClick().isEmpty {
            eventV3("plot_enter_click", params: [
                "tab": scource.getEnterClick()
            ])
        }
    }
    
    /// 剧本"精彩瞬间"按钮点击
    @objc public static func plotWonderfulMomentButtonClick() {
        eventV3("plot_wonderful_moment_button_click", params: [:])
    }
    
    /// 剧本"精彩瞬间"弹窗曝光
    @objc public static func plotWonderfulMomentWindowShow() {
        eventV3("plot_wonderful_moment_window_show", params: [:])
    }
    
    /// 剧情"任务浮窗"按钮曝光
    @objc public static func plotTaskFloatButtonShow(toUuid: String, screenplayUuid: String, moduleId: String) {
        eventV3("plot_task_float_button_show", params: [
            "to_uuid": toUuid,
            "screenplay_uuid": screenplayUuid,
            "module_id": moduleId
        ])
    }
    
    /// 剧情"任务浮窗"按钮点击
    @objc public static func plotTaskFloatButtonClick(toUuid: String, screenplayUuid: String, moduleId: String) {
        eventV3("plot_task_float_button_click", params: [
            "to_uuid": toUuid,
            "screenplay_uuid": screenplayUuid,
            "module_id": moduleId
        ])
    }
    
    /// 剧情"任务浮窗"曝光
    @objc public static func plotTaskFloatWindowShow(toUuid: String, screenplayUuid: String, moduleId: String) {
        eventV3("plot_task_float_window_show", params: [
            "to_uuid": toUuid,
            "screenplay_uuid": screenplayUuid,
            "module_id": moduleId
        ])
    }
    
    /// 剧情"任务浮窗"点击
    @objc public static func plotTaskFloatWindowconfirmClick(type: String, toUuid: String, screenplayUuid: String, moduleId: String) {
        eventV3("plot_task_float_window_confirm_click", params: [
            "type": type,
            "to_uuid": toUuid,
            "screenplay_uuid": screenplayUuid,
            "module_id": moduleId
        ])
    }
    
    
}
