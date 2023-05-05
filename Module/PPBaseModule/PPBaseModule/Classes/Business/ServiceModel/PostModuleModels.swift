//
//  PostServiceModels.swift
//  AdModule
//
//  Created by liguanglei on 2022/10/26.
//

import UIKit
import SwiftyJSON

@objcMembers
public class PSTopicInfoModel: NSObject {
    public var type: String =  PSTopicInfoModel.topicType// 类型： 话题：topic， 学校：school，位置：location
    
    public var topicInfo: PSTopicTopicModel?
    public var addressInfo: PSTopicAdressModel?
    public var schoolInfo: PSTopicSchoolModel?
    
    
    public static let topicType = "topic"
    public static let schoolType = "school"
    public static let locationType = "location"
    
    public static let followType = "follow"
    public static let recommendType = "recommend"
    public static let newType = "new"
}

@objcMembers
public class PSTopicTopicModel: NSObject {
    public var topicId: String = ""
    public var topicContent: String = "" //话题名
//    public var topicBtnText: String? = "" //话题名
    public var introduction: String? = "" //话题介绍
    public override init() {
        
    }
}

@objcMembers
public class PSTopicAdressModel: NSObject {
    public var addressName: String = ""
    public var cityCode: String = ""
    public var cityName: String = ""
    
    public override init() {
        
    }
}

@objcMembers
public class PSTopicSchoolModel: NSObject {
    public var collegeId: String = ""
    public var collegeName: String = ""
    
    public override init() {
        
    }
}


/*
 topic_uuid: 话题uuid,
 topic_content: 话题名称,
 img: 话题图片,
 img_bucket: 话题图片bucket,
 tag_uuid: 话题分类uuid,
 introduction: 话题介绍,
 corner: 角标图片,
 corner_bucket: 角标图片bucket,
 border_color: 边框颜色
 */
@objcMembers public class PPTopicInfoModel: NSObject {
    public var topic_uuid: String = ""  // 话题uuid
    public var topic_content: String = ""  // 话题名称
    public var img: String = ""  // 话题图片
    public var img_bucket: String = ""  // 话题图片bucket
    public var tag_uuid: String = ""  // 话题分类uuid
    public var introduction: String = ""  // 话题介绍
    public var corner: String = ""  // 角标图片
    public var corner_bucket: String = ""  // 角标图片bucket
    public var border_color: String = ""  // 边框颜色
    
    public static func coverToList(list: [[String: Any]]) -> [PPTopicInfoModel] {
        if list.count == 0 {
            return [PPTopicInfoModel]()
        }
        return list.map { tmpDic in
            let model = PPTopicInfoModel(dic: tmpDic)
            return model
        }
    }
    public override required init() {}
    
    public convenience init(dic: [String: Any]) {
        self.init()
        
        let json = JSON(dic)
        self.topic_uuid = json["topic_uuid"].stringValue
        self.topic_content = json["topic_content"].stringValue
        self.img = json["img"].stringValue
        self.img_bucket = json["img_bucket"].stringValue
        self.tag_uuid = json["tag_uuid"].stringValue
        self.introduction = json["introduction"].stringValue
        self.corner = json["corner"].stringValue
        self.corner_bucket = json["corner_bucket"].stringValue
        self.border_color = json["border_color"].stringValue
    }
}
