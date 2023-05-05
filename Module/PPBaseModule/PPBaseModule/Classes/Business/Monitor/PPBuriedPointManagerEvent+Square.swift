//
//  PPBuriedPointManagerEvent+Square.swift
//  PPBaseModule
//
//  Created by liguanglei on 2022/11/9.
//

import Foundation
import XHBTool

extension PPBuriedPointManagerEvent {
    // MARK: 动态广场
    /// 动态广场页面曝光
    @objc public static func postHomeShow(tabName: PostTopTab, watchTime: Int64, ifRegular: Bool, ifTouch: Bool) {
        eventV3("post_home_show", params: [
            "tab_name": tabName.descText(),
            "watch_time": "\(watchTime)",
            "if_regular": ifRegular ? "1":"0",
            "if_touch": ifTouch ? "1":"0"
        ])
    }
    
    /// 话题内容页面曝光
    @objc public static func postTopicShow(style: PostStyle, tabName: PostTopTab, otherTabName: String?, watchTime: Int64, source: ExposureSource) {
        var newSource: ExposureSource =  source
        if source == .topicSquare || source == .followTopicPage || source == .homePageTopRecommend || source == .browsingRecommend {
            DDLogInfo("正常源")
        }else {
            DDLogInfo("warn：不需要的soure源")
            newSource = .other
        }
        let newTabName = getRelTableName(tabName: tabName, otherTabName: otherTabName)
        eventV3("post_topic_show", params: [
            "style": style.descText(),
            "tab_name": newTabName,
            "watch_time": "\(watchTime)",
            "source": newSource.descText()
        ])
    }
    
    /// 关注话题按钮点击
    @objc public static func topicFocusClick(topicTitle: String, isFocus: Bool) {
        eventV3("topic_focus_click", params: [
            "topic_title": topicTitle,
            "is_focus": isFocus ? "1":"0"
        ])
    }
    
    /// 参与话题按钮点击
    @objc public static func topicSendClick(topicTitle: String) {
        eventV3("topic_send_click", params: [
            "topic_title": topicTitle
        ])
    }
    
    /// 关注话题页曝光
    @objc public static func topicFocusShow(topicTitles: [String], topicNum: String) {
        eventV3("topic_focus_show", params: [
            "topic_title": topicTitles,
            "topic_num":topicNum
        ])
    }
    
    /// 话题广场曝光
    @objc public static func topicSquareShow(tabName: String, topicTitle: [String], source: ExposureSource) {
        eventV3("topic_square_show", params: [
            "tab_name": tabName,
            "source":source.descText(),
            "topic_title":topicTitle
        ])
    }
    
    /// 关注话题页 话题点击
    @objc public static func topicFocusTopicClick(topicTitle: String) {
        eventV3("topic_focus_topic_click", params: [
            "topic_title": topicTitle
        ])
    }
    
    /// 话题广场 话题点击
    @objc public static func topicSquareTopicClick(topicTitle: String) {
        eventV3("topic_square_topic_click", params: [
            "topic_title": topicTitle
        ])
    }
    
    
    static func getLabelWithTags(tags: Any?) -> String {
        var labels = ""
        if let tags = tags as? [[AnyHashable: Any]] {
            for item in tags {
                let name = item["name"] as? String ?? ""
                if labels == "" {
                    labels = "\(name)"
                } else {
                    labels = ",\(name)"
                }
            }
        }
        return labels
    }
    
    /// 帖子曝光 index如果>=0：里面统一加1
    @objc public static func postShow(tab: PostTab, tabName: PostTopTab, otherTabName: String?, postUuid: String, postAccountUuid: String, isTopic: String, isPic: String, isVideo: String, postCreateTime: String, index: Int, province: String?, cityName: String?, tags: Any?, isTop: Bool) {
        let labels = self.getLabelWithTags(tags: tags)
        var index = index
        if index >= 0 {
            index += 1
        }
        let newTabName = getRelTableName(tabName: tabName, otherTabName: otherTabName)
        eventV3("post_show", params: [
            "tab": tab.descText(),
            "tab_name": newTabName,
            "post_uuid": postUuid,
            "post_account_uuid": postAccountUuid,
            "is_topic": isTopic,
            "is_pic": isPic,
            "is_video": isVideo,
            "index": index,
            "province": province ?? "",
            "city": cityName ?? "",
            "label": labels,
            "is_top" : isTop ? "1" : "0"
            //            "post_create_time": postCreateTime
        ])
    }
    
    /// 帖子下拉刷新时上报 用户动态广场页下拉刷新完成后上报一个下拉刷新的事件
    @objc public static func pullRefresh(tabName: PostTopTab) {
        eventV3("common_pull_refresh", params: [
            "tab": tabName.descText()
        ])
    }
    
    /// 帖子点击
    /// 当source 为发现\个人主页时tab_name为空
    /// tabName: 推荐  ,关注, '学校_'+'学校名称' '      话题_'+'话题名称'
    @objc public static func postClick(source: ExposureSource, tabName: PostTopTab, otherTabName: String?, postUuid: String, postAccountUuid: String, isTopic: String, isPic: String, isVideo: String, postCreateTime: String, index: Int, province: String?, cityName: String?, tags: Any?) {
        let newTabName = getRelTableName(tabName: tabName, otherTabName: otherTabName)
        let labels = self.getLabelWithTags(tags: tags)
        var index = index
        if index >= 0 {
            index += 1
        }
        eventV3("post_click", params: [
            "tab_name": newTabName,
            "post_uuid": postUuid,
            "post_account_uuid": postAccountUuid, // 发帖人UUID
            "is_topic": isTopic,
            "is_pic": isPic,
            "is_video": isVideo,
            "source": source.descText(),
            "index": index,
            "province": province ?? "",
            "city": cityName ?? "",
            "label": labels
            //            "post_create_time": postCreateTime
        ])
    }
    
    @objc public static func postItems(source: ExposureSource, tabName: PostTopTab, otherTabName: String?, postUuid: String, postAccountUuid: String, isTopic: String, isPic: String, isVideo: String, postCreateTime: String, clickpopTab: PostClickPopTab) {
        let newTabName = getRelTableName(tabName: tabName, otherTabName: otherTabName)
        
        eventV3("post_items", params: [
            "tab_name": newTabName,
            "post_uuid": postUuid,
            "post_account_uuid": postAccountUuid, // 发帖人UUID
            "is_topic": isTopic,
            "is_pic": isPic,
            "is_video": isVideo,
            "source": source.descText(),
            "click_pop_tab": clickpopTab.descText()
            //            "post_create_time": postCreateTime
        ])
    }
    
    static func getRelTableName(tabName: PostTopTab, otherTabName: String?) -> String {
        var newTabName = ""
        if tabName != .notExist {// 为空
            newTabName = tabName.descText()
        }
        
        if otherTabName != nil && otherTabName != "" {
            let otherTabName = otherTabName ?? ""
            if newTabName != "" {
                newTabName = "\(newTabName)_\(otherTabName)"// 拼接
            } else {
                newTabName = otherTabName
            }
        }
        return newTabName
    }
    
    /// 帖子详情页曝光
    @objc public static func postPostDetailShow(source: ExposureSource, postUuid: String, postAccountUuid: String, postCreateTime: String) {
        eventV3("post_postdetail_show", params: [
            "post_uuid": postUuid,
            "post_account_uuid": postAccountUuid, // 发帖人UUID
            "source": source.descText()
            //            "post_create_time": postCreateTime
        ])
    }
    
    /// 帖子点赞 /// 帖子取消点赞postUnlikeClick
    /// position：帖子 , 评论
    @objc public static func postLikeClick(isHeat: Bool, tab: PostTab, tabName: PostTopTab, otherTabName: String?, position: PostPosition, postAccountUuid: String, postUuid: String, postCreateTime: String) {
        var eventName = "post_like_click"
        if !isHeat {
            eventName = "post_unlike_click"
        }
        let newTabName = getRelTableName(tabName: tabName, otherTabName: otherTabName)
        eventV3(eventName, params: [
            "tab": tab.descText(),
            "tab_name": newTabName,
            "position": position.descText(),
            "post_uuid": postUuid,
            "post_account_uuid": postAccountUuid // 发帖人UUID
            //            "post_create_time": postCreateTime
        ])
    }
    
    /// 帖子取消点赞
    /// position：帖子 , 评论
    @objc public static func postPostreplyClick(tab: PostTab, tabName: PostTopTab, otherTabName: String?, postAccountUuid: String, postUuid: String, postCreateTime: String) {
        let newTabName = getRelTableName(tabName: tabName, otherTabName: otherTabName)
        eventV3("post_postreply_click", params: [
            "tab": tab.descText(),
            "tab_name": newTabName,
            "post_uuid": postUuid,
            "post_account_uuid": postAccountUuid // 发帖人UUID
            //            "post_create_time": postCreateTime
        ])
    }
    
    /// 帖子评论发布按钮点击
    /// position：帖子 , 评论
    @objc public static func postPostreplyPublishClick( postUuid: String, postAccountUuid: String, replyLevel: PostReplyLevel, isAddress: Bool) {
        eventV3("post_postreply_publish_click", params: [
            "post_uuid": postUuid,
            "post_account_uuid": postAccountUuid, // 发帖人UUID
            "reply_level": replyLevel.descText(),
            "is_address": isAddress ? "1": "0"
        ])
    }
    
    /// 帖子发布编辑页曝光
    /// position：帖子 , 评论
    @objc public static func postPostpublishShow( source: ExposureSource) {
        eventV3("post_postpublish_show", params: [
            "source": source.descText()
        ])
    }
    
    /// 帖子发布
    /// position：帖子 , 评论
    @objc public static func postPostpublishClick(isTopic: String, isPic: String, isVideo: String, isAddress: Bool) {
        eventV3("post_postpublish_click", params: [
            "is_topic": isTopic,
            "is_pic": isPic,
            "is_video": isVideo,
            "is_address": isAddress ? "1": "0"
        ])
    }
}
