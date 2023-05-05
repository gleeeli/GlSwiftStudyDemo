//
//  File.swift
//  MomentModule
//
//  Created by WJK on 2022/6/14.
//

import Foundation
import HBPublic
// MARK: - string chuliu
extension String {

    static let secPerMinute: TimeInterval = {
      return 60
    }()
    static let minPerHour: TimeInterval = {
        return 60
    }()
    static let hourPerDay: TimeInterval = {
        return 24
    }()
    static let oneDay: TimeInterval = {
        return TimeInterval( secPerMinute * minPerHour * hourPerDay)
    }()
    static let oneHour: TimeInterval = {
        return secPerMinute * minPerHour
    }()

        static func getSysRealTime(timeStamp: TimeInterval) -> String {
            let interval = NSTimeZone.system.secondsFromGMT()

            let originTsDate = Date(timeIntervalSince1970: timeStamp)
            let originCurDate = Date()

            let calTsDate = originTsDate.addingTimeInterval(TimeInterval(interval))
            let calCurDate = originCurDate.addingTimeInterval(TimeInterval(interval))

            let calTs = calTsDate.timeIntervalSince1970
            let calCurTs = calCurDate.timeIntervalSince1970

            let formatter = DateFormatter()

            guard calCurTs >= calTs else { // 在当前时间之后
                formatter.dateFormat = "M月d日 HH:mm"
                return  formatter.string(from: originTsDate) // "晚于当前: " +
            }

            let distance = calCurTs - calTs

            // 1分钟内
            if distance < secPerMinute {
                return "刚刚"
            }
            // 30分钟内
            if distance <= secPerMinute * 30 {
                return String(Int(distance / secPerMinute)) + "分钟前"
            }
            // 今天内
            if Calendar.current.isDateInToday(originTsDate) {
                formatter.dateFormat = "HH:mm"
                return formatter.string(from: originTsDate)
            }
            // 昨天内
            if Calendar.current.isDateInYesterday(originTsDate) {
                formatter.dateFormat = "HH:mm"
                return "昨天" + formatter.string(from: originTsDate)
            }
            // 前天内
            var comp = DateComponents()
            comp.setValue(-3, for: .day)
            if let date = Calendar.current.date(byAdding: comp, to: calCurDate),
               calTs > date.timeIntervalSince1970 {
                formatter.dateFormat = "HH:mm"
                return "前天" + formatter.string(from: originTsDate)
            }
            // 60天内
            if distance <= 60 * oneDay {
                formatter.dateFormat = "M月d日"
                return  formatter.string(from: originTsDate) // "in60days: " +
            }

            let comp1 = Calendar.current.dateComponents([.year], from: originTsDate)
            let comp2 = Calendar.current.dateComponents([.year], from: originCurDate)
            if let year1 = comp1.year,
               let year2 = comp2.year,
               year1 == year2 { // 同一年
                formatter.dateFormat = "M月d日"
                return formatter.string(from: originTsDate) // "out60days: " +
            } else { // 跨年
                formatter.dateFormat = "yyyy年M月d日"
                return  formatter.string(from: originTsDate) // "out60days: " +
            }
        }

        static func getSysRealTime2(tsString: String) -> String {
            guard let ts = TimeInterval(tsString) else {
                return ""
            }
            return getSysRealTime(timeStamp: ts)
        }

  public  func getSysRealTime2() -> String {
        guard let ts = TimeInterval(self) else {
            return ""
        }
        return String.getSysRealTime(timeStamp: ts)
    }
}

public extension String {
      func toArray() throws -> [Any] {
        guard let stringData = data(using: .utf16, allowLossyConversion: false) else { return [] }
        guard let array = try JSONSerialization.jsonObject(with: stringData, options: .mutableContainers) as? [Any] else {
             throw JSONError.notArray
        }

        return array
    }

     func toDictionary() throws -> [String: Any] {
        guard let binData = data(using: .utf16, allowLossyConversion: false) else { return [:] }
        guard let json = try JSONSerialization.jsonObject(with: binData, options: .allowFragments) as? [String: Any] else {
            throw JSONError.notNSDictionary
        }

        return json
    }

}

// MARK: -
public extension String {
    func isIncludeChineseIn() -> Bool {

        for (_, value) in self.enumerated() {

            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }

        return false
    }
    func urlEncode() -> String? {
        if self.isIncludeChineseIn() {

            return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
        return self
    }

    static func getAppVersion() -> Float {
        return ( UIDevice.current.systemVersion as NSString).floatValue
    }
}
