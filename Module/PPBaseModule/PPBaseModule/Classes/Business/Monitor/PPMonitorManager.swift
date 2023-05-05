//
//  PPMonitorManaget.swift
//  PPBaseModule
//
//  Created by WJK on 2022/6/9.
//

import UIKit
import HBPublic

@objc public class PPMonitorManager: NSObject {

    /// 开启日志
  public static func startDDLog() {
        XHBLogCenter.sharedInstance().startDDLog()
      #if DEBUG
        // 这句会覆盖服务器设置的日志结果
        XHBLogCenter.sharedInstance().setLogLevel(.info)
      #else
      
      #endif
        
    }

    /// 发送日志
    @objc   public static func sendLog(event: String, andContent content: String) {
        XHBLogCenter .sendLog(withEvent: PPMonitorEvent.prefix + event, andContent: content)
    }
    /// 提交日志 - 可以手动调用
    @objc   public static func uploadFileLog() -> Bool {
        return XHBLogCenter.sharedInstance().uploadFileLog()
    }
    /// 上报推送日志
    @objc  public static func sendPushLog(pushType: String, taskUid: String, pushTagCode: String ) {
        XHBLogCenter.sendPushLog(withPushType: PPMonitorEvent.prefix + pushType, andTaskUid: taskUid, andTagCode: pushTagCode)
    }
}

@objcMembers
public class PPMonitorEvent: NSObject {

    // MARK: 事件前缀
    public static let prefix = "Monitor_"

    // MARK: 登录
    // 登录失败
    public static let loginFail = "login_fail"
    // 注册失败
    public static let registerFail = "register_fail"
    // 登录项下发失败
    public static let loginTypeListReqFail = "login_type_list_req_fail"

    // MARK: tabbar
    // tab下发失败
    public static let tabbarListReqFail = "tabbar_list_req_fail"
    // tab列表写沙盒失败
//    public static let tabbarWriteSendBoxFail = "tabbar_write_sendbox_fail"

    // MARK: 分享
    // 分享图片下载失败
    public static let shareImageDownloadFail = "share_image_download_fail"

    // MARK: 推送
    // 点开推送
    public static let appFinishLaunchPush = "app-FinishLaunch-push"
    public static let appUniversalLink = "app-UniversalLink"

    // MARK: app life
    // 进入后台
    public static let appEnterBackground = "app-EnterBackground"
    // 回到前台
    public static let appEnterForeground = "app-EnterForeground"
    // 杀掉进程
    public static let appTerminate = "app-Terminate"
    // 网络切换
    public static let appNetworkChange = "app-networkChange"

    // MARK: font
    // 下载字体失败
    public static let fontDownloadFail = "font_download_fail"
    // 字体解压失败
    public static let fontUnzipFail = "font_unzip_fail"

    // MARK: 闪验
    // 闪验SDK当前版本号
    public static let shanyanVersion = "ShanYan_version"
    // 闪验SDK初始化失败
    public static let shanyanInitFail = "ShanYan_init_fail"
    // 闪验错误
    public static let shanyanError = "ShanYan_Error"
    // 获取闪验的基本信息失败
    public static let shanyanLoadInfoFail = "ShanYan_load_info_fail"
    // 获取闪验的基本信息为空
    public static let shanyanInfoNull = "ShanYan_info_null"
    // 闪验登录失败
    public static let shanyanLoginFail = "ShanYan_login_fail"

    // MARK: IM
    // 个推sdk在前台收到的私信消息
    public static let imForeground = "im_foreground"
    // 会话数量超过2200条
    public static let imPrivateMsgOptimizing = "PrivateMsg_Optimizing"
    // 尝试重新加载未读数红点数
    public static let imLoadUnreadMsgCount = "IM_LoadUnreadMessageCount"
    // 发送消息服务端返回格式错误
    public static let imResponseFormatError = "IM_SendMsg_ResponseFormatError"
    // 私信初始化到加载本地消息用时 大于0.3s
    public static let imLocalDataLoadTime = "IM_DirectMessageVC_initLocalDataAndLoad_time"
    // im重连成功
    public static let imReconnect = "IM_SocketIOManager_Reconnect"
    // im断开连接
    public static let imDisconnect = "IM_SocketIMDisconnect"

    // MARK: 七牛
    // 七牛上传失败
    public static let qiniuPostError = "Qiniu-Post-Error"

    /// IAP
    // 内购付款成功
    public static let iapPaySuccess = "iap_pay_success"
    // 内购验证失败
    public static let iapVerifyFail = "iap_verify_log"
    // 上报内购交易记录日志
    public static let iapRecordLog = "iap_record_log"

    // MARK: 动态
    // 动态广场评论失败
    public static let postCommentFail = "Post_Interact_Comment"
    // 发布动态失败
    public static let postPublishFail = "Post_Interact_Publish"
    // 动态广场关注用户失败
    public static let postFollowUserFail = "Post_Interact_FollowUser"

    // MARK: - 语音聊天 群聊

    /// 退房成功
    public static let MM_TRTC_onExitRoom = "MM_TRTC_onExitRoom"
    /// 离开房间
    public static let MM_TRTC_leaveRoom = "MM_TRTC_leaveRoom"
    /// 初始化SDk
    public static let MM_TRTC_initSDk = "MM_TRTC_initSDk"
    /// 进房成功
    public static let MM_TRTC_onEnterRoom = "MM_TRTC_onEnterRoom"
    /// 错误事件回调
    public static let MM_TRTC_onError = "MM_TRTC_onError"
    /// 切换成主播
    public static let MM_TRTC_Anchor = "MM_TRTC_Anchor"
    /// 切换成听众
    public static let MM_TRTC_audience = "MM_TRTC_audience"
    /// 禁用扬声器 true 没有声音
    public static let MM_TRTC_muteVolume = "MM_TRTC_muteVolume"
    // 闭麦开麦
    public static let MM_TRTC_muteLocalAudio = "MM_TRTC_muteLocalAudio"
    /// 开始音频采集
    public static let MM_TRTC_startAudioCapture = "MM_TRTC_startAudioCapture"
    /// 停止音频采集
    public static let MM_TRTC_stopAudioCapture = "MM_TRTC_stopAudioCapture"

}
