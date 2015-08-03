
//
//  String+Extension.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/26.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import Foundation
extension String{

    func hrefLink()->(href: String!, linkText: String!)?{
    //<a href=\"http://weibo.com/\" rel=\"nofollow\">微博 weibo.com</a>
    //<a href=\"http://app.weibo.com/t/feed/6SFgyO\" rel=\"nofollow\">华为Ascend手机</a>
    
        // 1. 匹配方案
        let pattern = "<a.*?href=\"(.*?)\".*?>(.*?)</a>"
        // 2. 实例化表达式
        let regex = NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.DotMatchesLineSeparators, error: nil)
        // 3. 匹配
        if let result = regex?.firstMatchInString(self, options: NSMatchingOptions(0), range: NSMakeRange(0, count(self))) {
            
            // href
            let range1 = result.rangeAtIndex(1)
            // link text
            let range2 = result.rangeAtIndex(2)
            
            let href = (self as NSString).substringWithRange(range1)
            let linkText = (self as NSString).substringWithRange(range2)
            
            return (href, linkText)
        }
        return nil

    }



}