//
//  UserModel.swift
//  ComicChatSwift
//
//  Created by luo luo on 2020/4/21.
//  Copyright © 2020 GL. All rights reserved.
//

import UIKit


class UserExt: BaseModel {
    var id = 0
    var expirationTime: String?
    //0ed0fb05102a 无@
    var sessionKey: String?
    var openid: String?
}

class UserModel: BaseModel {
    var id = 0
    var createTime: String?
    var headUrl: String?
    var username: String?
    //性别 1-男 2-女
    var sex = 0
    var userExt: UserExt?
}

class UserHttpModel: BaseModel {
var sessionKey: String?
var userInfo: UserModel?
var userid = 0
}



