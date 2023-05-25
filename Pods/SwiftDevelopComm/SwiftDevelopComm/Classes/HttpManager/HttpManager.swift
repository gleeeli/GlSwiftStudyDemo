//
//  HttpManager.swift
//  ComicChatSwift
//
//  Created by luo luo on 2020/4/20.
//  Copyright © 2020 GL. All rights reserved.
//

import Foundation
import Moya

enum HttpEnviroment {
    case product
    case develop1
    case develop2
}
let TGhttpEnviroment:HttpEnviroment = HttpEnviroment.develop1;

func TGGetHttpBaseUrl() -> String {
    switch TGhttpEnviroment {
    case .product:
        return "http://120.79.79.211:80/"
    case .develop1:
        return "http://127.0.0.1:8888/Comic/"
    case.develop2:
        return "http://192.168.1.102:8888/Comic/"
    
    }
    
}

func TGGetWebSocketBaseUrl() -> String {
    switch TGhttpEnviroment {
    case .product:
        return "ws://120.79.79.211:80/websocket/"
    case .develop1:
        return "ws://127.0.0.1:8888/Comic/websocket/"
    case.develop2:
        return "ws://192.168.1.102:8888/Comic/websocket/"
   
    }
    
}

enum HttpAPIManager{
    case AddVisitor(Dictionary<String, Any>) // 添加游客
    case GetHomeDetail(Int)  // 获取详情页
}

extension HttpAPIManager: TargetType {

    var headers: [String : String]? {
        return nil
    }
    
    /// The target's base `URL`.
    var baseURL: URL {
        return URL.init(string: TGGetHttpBaseUrl())!
    }
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .AddVisitor( _): // 不带参数的请求
            return "user/visitor/add.do"
        case .GetHomeDetail(let id):  // 带参数的请求
            return "4/theme/\(id)"
        }
    }
// 区分get 和 post
    var method: Moya.Method {
        return .post
    }

    /// The parameters to be incoded in the request.
//    var parameters: [String: Any]? {
//
//
//    }
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    /// Provides stub data for use in testing.
    var sampleData: Data {
        switch self {
        case .AddVisitor(_):
            return "[{\"userId\": \"1\", \"Title\": \"Title String\", \"Body\": \"Body String\"}]".data(using: String.Encoding.utf8)!
        case .GetHomeDetail(_):
            return "Create post successfully".data(using: String.Encoding.utf8)!
        }
    }
    /// The type of HTTP task to be performed.
    var task: Task {
        switch self {
         case .AddVisitor(let dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
         case .GetHomeDetail( _):
              return .requestPlain
         }
       
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}
