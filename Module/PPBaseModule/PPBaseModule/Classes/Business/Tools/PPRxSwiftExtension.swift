//
//  PPRxswiftExtsnion.swift
//  LoginModule
//
//  Created by 他趣 on 2022/3/18.
//

import Foundation
import RxSwift
import UIKit
import HBPublic

// 服务端fanhui
public protocol XHBHTTPError {
    associatedtype T
    static func parseReponseError(from response: XHBHTTPResponse?) -> T
}

// 自定义RxSwift错误
public struct HBRxError: Swift.Error {

    public let code: Int    // 错误码(网络返回的code，业务错误的返回码可能为200)
    public var reason = ""
    public var errType = ""
}

public extension HBRxError {
    static func defaultError() -> HBRxError {
        return HBRxError.init(code: -1, reason: "网络连接失败，请检查网络！")
    }
    static func createError(code: Int?, reason: String?, errType: String?) -> HBRxError {
        if let c = code, let r = reason, let e = errType {
            return HBRxError.init(code: c, reason: r, errType: e)
        } else {
            return defaultError()
        }
    }
}

public extension HBRxError {
    //
    static func parametersError() -> HBRxError {
        return createError(code: -100, reason: "参数错误", errType: "")
    }
}

extension HBRxError: XHBHTTPError {
    public typealias T = HBRxError
    public static func parseReponseError(from response: XHBHTTPResponse?) -> T {
        if let res = response {
            return createError(code: res.errorCode, reason: res.message, errType: res.responseStatus)
        } else {
            return defaultError()
        }
    }
}

public protocol HBDisposeBagProvider: AnyObject {
    var disposeBag: DisposeBag { get }
}

public protocol PPIdentifierProperty: AnyObject {
    static var identifier: String {get}
}

public protocol PPCallBackProtocol: AnyObject {
    associatedtype SignalElementType

    // 一般用于页面操作完成后，跳转回调，要调用competed事件才会回调
    var completedSignal: RxSwift.PublishSubject<SignalElementType>? {get}
}

public protocol PPBaseCollectionViewCellProperty: HBDisposeBagProvider {
}

public protocol PPBaseTableViewCellProperty: HBDisposeBagProvider {}

extension UITableViewCell: PPIdentifierProperty {
    public static var identifier: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionViewCell: PPIdentifierProperty {
    public static var identifier: String {
        return NSStringFromClass(self)
    }
}
