//
//  DateExtension.swift
//  ComicChatSwift
//
//  Created by luo luo on 2020/4/20.
//  Copyright © 2020 GL. All rights reserved.
//

import Foundation
public typealias DateExtension = Date
extension DateExtension{
    func date(withFormat format: String?) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
