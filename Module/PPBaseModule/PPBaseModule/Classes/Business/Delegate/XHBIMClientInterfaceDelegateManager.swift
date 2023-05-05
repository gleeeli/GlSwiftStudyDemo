//
//  XHBIMClientInterfaceDelegate.swift
//  PPUIKit
//
//  Created by WJK on 2022/11/30.
//

import UIKit
import XHBIMClient

public extension XHBInterface {
    var relation: String {
        return self.gwDomain+"/peipeix-relation"
    }
    var ugc: String {
        return self.gwDomain+"/peipeix-ugc"
    }
    var account: String {
        return self.gwDomain+"/peipeix-user"
    }
    var msg: String {
        return self.gwDomain+"/peipeix-msg"
    }
    var trade: String {
        return self.gwDomain+"/peipeix-trade"
    }
    var material: String {
        return self.gwDomain+"/peipeix-material"
    }
}



@objc public class XHBIMClientInterfaceDelegateManager:NSObject, XHBIMClientInterfaceDelegate{
    
    /** 发私信*/
    @objc  public func xhbIMSendMessageUrl() -> String {
        return  XHBInterface.sharedInstance()!.msg + "/v1/NewMessage/send"
    }

    /** 获取用户未读消息数*/
    public func xhbIMGetUnreadMessageCountUrl() -> String {
        return XHBInterface.sharedInstance()!.msg + "/v1/NewMessage/getOfflineMsgNum"
    }

    /** 获取用户未读消息详情*/
    public func xhbIMGetUnreadMessageListUrl() -> String {
        return XHBInterface.sharedInstance()!.msg + "/v1/NewMessage/getHistory"
    }
#warning("IM_")
    /** 获取私信聊天历史内容*/ //- 配配为使用到
//    public func xhbIMGetHistoryMessageListUrl() -> String {
//        return ""
//    }

    /** 获取最后一条消息列表*/
    public func xhbIMGetLastMessageListUrl() -> String {
        return XHBInterface.sharedInstance()!.msg +  "/v1/NewMessage/getLastOfflineMsg"
    }

   

    /** 红点回执*/ // 获取红点数量回执
    public func xhbIMRedDotReceiptUrl() -> String {
        return  XHBInterface.sharedInstance()!.msg + "/v1/NewMessage/offlineMsgNumAck"
    }

    /** 消息回执*/
    public func xhbIMMessageReceiptUrl() -> String {
       return Self.xhbIMMessageReceiptUrl()
    }

//    /** 获取好友UUID列表*/
    public func xhbIMGetFrinedUuidListUrl() -> String {
        return XHBInterface.sharedInstance()!.relation + "/v1/Friend/getUserFriendList"
    }
//
//    /** 获取好友的信息*/
    public func xhbIMGetFriendInfoUrl() -> String {
        return XHBInterface.sharedInstance()!.relation + "/v1/Friend/getUserFriendInfo"
    }

    
}

@objc public  extension  XHBIMClientInterfaceDelegateManager {
    /// 获取离线消息
    @objc static func getUnreadMsgInfo() -> String {
        return XHBInterface.sharedInstance()!.msg + "/v1/NewMessage/getOfflineMsg"
    }
    
    /// 清空会话消息
    @objc static func cleanHistoryMsg() -> String {
        return XHBInterface.sharedInstance()!.msg + "/v1/NewMessage/deleteConversationMsg"
    }
    
    @objc static func xhbIMMessageReceiptUrl() -> String {
        return XHBInterface.sharedInstance()!.msg + "/v1/NewMessage/offlineMsgAck"
    }
}
