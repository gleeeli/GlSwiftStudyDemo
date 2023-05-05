//
//  PPBuriedPointManagerEvent+Mine.swift
//  PPBaseModule
//
//  Created by liguanglei on 2022/11/9.
//

import Foundation
import XHBTool

extension PPBuriedPointManagerEvent {
    // MARK: - 我的
    /// 【我的】我的页面曝光
    @objc public static func meShow(source: ExposureSource) {
        eventV3("me_show", params: [
            "source": source.descText()
        ])
    }
    
    /// 其他用户个人主页曝光时上报
    @objc public static func personalHomePageShow(to_uuid: String, source: ExposureSource) {
        eventV3("personal_homepage_show", params: [
            "to_uuid": to_uuid,
            "source": source.descText()
        ])
    }
    
    /// 邀请首页曝光时上报
    @objc public static func inviteHomeShow(source: ExposureSource) {
        eventV3("invite_home_show", params: [
            "source": source.descText()
        ])
    }
    
    /// 点击邀请首页上的按钮时上报
    @objc public static func inviteHomeClick(position: ClickPosition) {
        eventV3("invite_home_click", params: [
            "position": position.descText()
        ])
    }
    
    /// 分享弹窗曝光时上报
    @objc public static func inviteSharewindowShow(tab: ExposureTab) {
        eventV3("invite_sharewindow_show", params: [
            "tab": tab.descText()
        ])
    }
    
    /// 点击弹窗分享按钮时上报
    @objc public static func inviteSharewindowClick(tab: ExposureTab, position: ClickPosition) {
        eventV3("invite_sharewindow_click", params: [
            "tab": tab.descText(),
            "position": position.descText()
        ])
    }
    
    /// 【帖子】个人介绍发布编辑页曝光
    public static func introduceShow(source: ExposureSource) {
        eventV3("post_introduce_show", params: [
            "source": source.descText()
        ])
    }
    
    /// 个人信息面板 曝光
    @objc public static func personalInformationWindowShow() {
        eventV3("personal_information_window_show", params: [:])
    }
    
    /// 个人信息面板 点击
    @objc public static func personalInformationWindowClick(position: PPPersionInfoClickType, subType: PPPersionInfoClickPositionSubType) {
        eventV3("personal_information_window_click", params: ["type":position.desc(), "sub_type":subType.desc()])
    }
    
    /// 完善资料弹窗曝光
    public static func detailWindowShow(source: ExposureSource) {
        eventV3("personal_detail_window_show", params: nil)
    }
    
    /// 完善资料弹窗点击      type - {按钮文案:标题}
    public static func detailWindowClick(type: String) {
        eventV3("personal_detail_window_click", params: [
            "type": type
        ])
    }
    
}
