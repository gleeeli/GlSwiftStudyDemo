//
//  DateViewController.swift
//  SwiftFrameworkDemo
//
//  Created by gleeeli on 2020/8/17.
//  Copyright © 2020 GL. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let date = Date()
//        print(date)
//        print("当前日期:\(date)")

        getTimeZone()
        
//        let time = getNowTimeInterval()
//        let date = getDateFromTimeInterval(time: time)
//        let dateStr = getDateStrFromDate(date: date, format: "yyyy-MM-dd HH:mm:ss")
//        print("转字符串：\(dateStr)")
//        let date2:Date = getDateFromDateStr(dateStr: "2020-08-18 00:14:14", format: "yyyy-MM-dd HH:mm:ss")
//        let day2 = getDay(date: date2)
//        print("获取date里得日期：\(day2)日")
//        let dateStr2 = getDateStrFromDate(date: date2, format: "yyyy-MM-dd HH:mm:ss")
//
//        print("date转字符串:\(dateStr)")
//
//        print("dateStr2:\(dateStr2)")
//
        testExample()
    }
    
    func testExample() {
        
        let startdate = getTodayStartDate(date: Date())// 2022-05-28 16:00:00 +0000
        // 标准Date转本地时区字符串
        let dateStr = getDateStrFromDate(date: startdate, format: "yyyy-MM-dd HH:mm:ss")
        print("今天北京开始时间转字符串：\(dateStr)")// 2022-05-29 00:00:00
    }
    
    //获某天的起始时间也就是：如：2022-05-29 00:00:00
    func getTodayStartDate(date: Date) -> Date {
        //开始时间
        var calendar = NSCalendar.current
        calendar.timeZone = NSTimeZone.local
        let dateAtMidnight:Date = calendar.startOfDay(for: date)
        print(dateAtMidnight)
        print("当天开始时间：\(dateAtMidnight)")
        return dateAtMidnight
    }
    

    //获取当前时间戳
    func getNowTimeInterval() -> TimeInterval {
        let today = Date()// 获取格林威治时间（GMT）/ 标准时间
        print("today = \(today)")// 打印出的时间是GTM时间，比北京时间早了8个小时
        return Date().timeIntervalSince1970
    }
    
    //时间戳转Date
    func getDateFromTimeInterval(time:TimeInterval) -> Date {
        return Date(timeIntervalSince1970: time)
    }
    
    //Date转字符串 yyyy-MM-dd HH:mm:ss,将ugc日期转本地时区
    func getDateStrFromDate(date:Date,format:String) -> String {
        let dateformatter = DateFormatter()//自定义日期格式
        dateformatter.dateFormat = format
        return dateformatter.string(from: date)
        
    }
    
    //字符串格式转Date yyyy-MM-dd HH:mm:ss
    func getDateFromDateStr(dateStr:String,format:String) -> Date {
        let dateformatter = DateFormatter()//自定义日期格式
        //字符串是北京时间则，强转北京时区
        //dateformatter.locale = Locale(identifier: "zh_CN")
        //字符串是本地时间则，转本地时区
        dateformatter.locale = Locale.current
        dateformatter.dateStyle = DateFormatter.Style.medium
        dateformatter.timeStyle = DateFormatter.Style.medium
        dateformatter.dateFormat = format
        let date = dateformatter.date(from: dateStr)
        return date!
        
    }
    
    //获取当前属于那一天
    func getDay(date:Date) -> Int {
        //将Date转中国
        //let day = Calendar.init(identifier: .republicOfChina).component(.day, from: date)
        //将date转当前时区
        let day = Calendar.current.component(.day, from: date)
        return day
    }
    
    //获取当前系统时区
    func getTimeZone() -> TimeZone {
        let zone = NSTimeZone.system
        print("zone = \(zone)")
        return zone
    }

}
