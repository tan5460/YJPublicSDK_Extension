//
//  Date+YJExtension.swift
//  YJPublicSDK_Extension
//
//  Created by YJ on 2025/9/4.
//

import Foundation

public extension Date {
    
    ///年
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    ///月
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    ///日
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    ///小时
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    ///分钟
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    ///秒
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    ///
    func adding(years: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: years, to: self)!
    }
    
    func adding(months: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: months, to: self)!
    }
    
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
    
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    func adding(seconds: Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: seconds, to: self)!
    }
    
    ///日期转字符串
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    ///字符串转日期 format默认： yyyy-MM-dd HH:mm:ss
    static func fromString(timeString: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: timeString)
    }
    
    ///是否是今天
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    ///是否是昨天
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    ///是否是明天
    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    ///是否同一天
    func isSameDay(as date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
}
