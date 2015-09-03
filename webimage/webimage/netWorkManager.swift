//
//  netWorkManager.swift
//  河北人民广播电台
//
//  Created by 若水三千 on 15/7/14.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit
enum Method:String{
    
    case GET = "GET"
    case POST = "POST"
    
}
class netWorkManager: AFHTTPRequestOperationManager {
    private static let instance: netWorkManager = {
        var Manager = netWorkManager()
        
        // 指定响应的数据解析格式
        var types = NSMutableSet(set:Manager.responseSerializer.acceptableContentTypes)
        types.addObject("text/html")
        types.addObject("text/plain")
        Manager.responseSerializer.acceptableContentTypes = types as Set<NSObject>
        return Manager
        
        }()
    
    class func sharedManager() -> netWorkManager {
        return instance
}
    /**
    *  请求 JSON
    *
    *  @param method        HTTP 请求方法
    *  @param URLString     URL字符串
    *  @param parameters    参数字典
    :  @param: completion   完成回调，JSON是参数
    */
    class func requestJSON(method: Method, URLString: String, parameters: [String: AnyObject]? = nil, completion:(JSON: AnyObject?)->()) {
        if method == Method.GET{
            sharedManager().GET(URLString, parameters: parameters, success: { (_,JSON) -> Void in
                
                completion(JSON: JSON)
                
                }, failure: { (_, error) -> Void in
                    
                    // 开发调试使用的
                    println("ERROR error: \(error)")
                    completion(JSON: nil)
                    
            })
            
        }else{
            sharedManager().POST(URLString, parameters: parameters, success: { (_, JSON) -> Void in
                
                completion(JSON: JSON)
                
                }, failure: { (_, error) -> Void in
                    // 开发调试使用的
                    println("ERROR error: \(error)")
                    
                    completion(JSON: nil)
                    
            })
            
        }
    }
    
}
