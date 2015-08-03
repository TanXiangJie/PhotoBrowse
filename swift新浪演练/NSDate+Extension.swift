//
//  NSDate+Extension.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/22.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import Foundation

extension NSDate {
    
    /// 使用新浪微博的日期字符串创建 NSDate
    class func createDate(fullDateString: String!) -> NSDate? {
        // dateFormatter
        // 1. 实例化
        let df = NSDateFormatter()
        // 2. 要指定日期的地区，Xcode 6.3 beta 还不需要，地区需要指定英语
        // 注意：在真机调试的时候，一定要指定区域，否则以前版本同样无法转换
        df.locale = NSLocale(localeIdentifier: "en")
        
        // 3. 设置日期格式
        df.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        
        // 4. 生成日期
        return df.dateFromString(fullDateString)
    }
    
    /**
    返回日期的完整描述信息
    
    刚刚(一分钟内)
    X分钟前(一小时内)
    X小时前(当天)
    ------
    昨天 HH:mm(昨天)
    MM-dd HH:mm(当年)
    yyyy-MM-dd HH:mm(更早期)
    
    NSCalendar: 提供了非常非常非常丰富的日期处理函数
    */
    func fullDescription() -> String {
        
        // 取出当前的日期
        let calendar = NSCalendar.currentCalendar()
        
        if calendar.isDateInToday(self) {
            // 1. 取出日期与当前系统日期的时间`秒`差值
            let delta = Int(NSDate().timeIntervalSinceDate(self))
            
            if delta < 60 {
                return "刚刚"
            } else if delta < 3600 {
                // 一小时内容
                return "\(delta / 60) 分钟前"
            } else {
                // 几小时前
                return "\(delta / 3600) 小时前"
            }
        }
        
        // 日期格式字符串
        let formatterString: String
        
        if calendar.isDateInYesterday(self) {
            formatterString = "昨天 HH:mm"
        } else {
            // 使用 components 能够取出非常详细的日期信息
            // let coms = calendar.components(NSCalendarUnit.CalendarUnitYear, fromDate: self)
            
            // 计算两个指定时间单位的差值
            // 计算年度差值
            let coms = calendar.components(NSCalendarUnit.CalendarUnitYear, fromDate: NSDate(), toDate: self, options: NSCalendarOptions(0))
            
            if coms.year == 0 {
                // 当前
                formatterString = "MM-dd HH:mm"
            } else {
                // 往年
                formatterString = "yyyy-MM-dd HH:mm"
            }
        }
        
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = formatterString
        
        return df.stringFromDate(self)
    }
}