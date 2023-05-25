//
//  StatusModel.swift
//  ComicChatSwift
//
//  Created by luo luo on 2020/4/21.
//  Copyright © 2020 GL. All rights reserved.
//

import UIKit
import HandyJSON
class StatusModel<T:HandyJSON>: BaseModel {
    var code:Int32?
    var data:T?
    var message:String?
}
