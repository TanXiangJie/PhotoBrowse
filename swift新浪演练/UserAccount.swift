//
//  UserAccount.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/14.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

class UserAccount: NSObject,Printable,NSCoding{
    
    /// 用于调用access_token，接口获取授权后的access token
    let access_token: String
    /// access_token的生命周期，单位是秒数
    /// 如果是开发者，有效期是5年
    /// 如果是普通用户，有效期是3天
    let expires_in: NSTimeInterval
    /// 过期日期
    let expireDate: NSDate
    /// 当前授权用户的UID
    let uid: String
    
    /// 以下两个属性，无法在初始化时获得
    /// 友好显示名称
    var name: String?
    /// 用户头像地址（大图），180×180像素
    var avatar_large: String?
    
    init(dict:[String: AnyObject]) {
        access_token = dict["access_token"]as! String
        expires_in = dict["expires_in"]as!NSTimeInterval
        expireDate = NSDate(timeIntervalSinceNow: expires_in)
        uid = dict["uid"] as! String
        
    }
    // 在 swift 中，如果类函数要访问某一个属性值，需要使用到 static
    // 归档路径 － Document，可以 iTunes 备份的，由应用程序产生的重要数据
    // 目前为止，在 swift 中，不允许定义 class 的"存储型"常量，需要使用 static
    static let accountPath = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask,true).last as!String).stringByAppendingPathComponent("Useraccount.plist")
    
    class func loadAccessToken(params:[String:String],completion:(account:UserAccount?)->()) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        NetWorkTools.requestJSON(Method.POST, URLString: urlString, parameters: params) { (JSON) -> () in
            //      如果出现错误直接返回
            if JSON == nil{
                
                completion(account: nil)
                return
                
            }
            // JSON 有可能是字典也有可能是数组
            // 字典转模型
            
            let account = UserAccount(dict:JSON as! [String : AnyObject])
            //    加载用户信息
            account.loadUserInfo(completion)
        }
        
    }
    
    //   加载用户信息
    func loadUserInfo(completion:(account:UserAccount?)->()){
        let urlString = "https://api.weibo.com/2/users/show.json"
        let params = ["access_token": access_token, "uid": uid]
        NetWorkTools.requestJSON(Method.GET, URLString: urlString, parameters: params) { (JSON) -> () in
            // 错误处理
            if JSON == nil {
                completion(account: nil)
                return
            }
            if let dict = JSON as? [String:AnyObject]{
                self.name = dict["name"]as?String
                self.avatar_large = dict["avatar_large"] as? String
                NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.accountPath)
                //    回调
                completion(account: self)
                
            }else{
                
                completion(account: nil)
                
            }
        }
    }
    
// 从本地沙盒读取用户数据（解档）
    class func loadUserAccount() -> UserAccount? {
        if let account = NSKeyedUnarchiver.unarchiveObjectWithFile(UserAccount.accountPath)as? UserAccount{

            if account.expireDate.compare(NSDate()) == NSComparisonResult.OrderedDescending{
                return account
            }
        }
    return nil
    }
    
    // 重写对象的描述信息 - 建议重要的模型类，最好添加一个，方便调试
    override var description: String {
        let properties = ["access_token", "expires_in", "uid", "expireDate", "avatar_large", "name"]
        
        return "\(dictionaryWithValuesForKeys(properties))"
    }
    // MARK: - 归档 & 解档方法
    /**
    归档器，编码器
    */
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(expireDate, forKey: "expireDate")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    
    // 提示：解档的方法，一定要加一个 required 关键字
    // 目的是表示一点遵守了 NSCoding 协议，init 的构造方法是必须实现的
    // 解码器的方法
    required init(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as! String
        // 如果编码的是基本数据类型，能够保证一定解码到结果，可以省略 !
        // 可以按照 Xcode 的智能提示操作
        expires_in = aDecoder.decodeDoubleForKey("expires_in") as NSTimeInterval
        expireDate = aDecoder.decodeObjectForKey("expireDate") as! NSDate
        uid = aDecoder.decodeObjectForKey("uid") as! String
        name = aDecoder.decodeObjectForKey("name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
    }
    
   class func chooesRootVC(window:UIWindow){
        
    let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]as!String
   let versionValue = NSNumberFormatter().numberFromString(currentVersion)!.doubleValue
        
        // 和沙盒中的版本进行比较
        let sandboxKey = "sandboxKey"
        let defaults = NSUserDefaults.standardUserDefaults()
        let sandboxVersion = defaults.doubleForKey(sandboxKey)

        if versionValue == sandboxVersion {
            
            let userVC = UserpageViewController()
            window.rootViewController = userVC
            
             }else {
//       有新版本进入新特新
        println("有新版本进入新特新")
       let NewFeatureVC = NewFeatureViewController()
        window.rootViewController = NewFeatureVC
        // 及时记录最新的版本
        defaults.setDouble(versionValue, forKey: sandboxKey)
        defaults.synchronize()
      
        }

    }
}


