//
//  AppDelegate.swift
//  swift新浪微博
//
//  Created by 若水三千 on 15/7/12.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//
//
import UIKit
/// 全局变量定义，放在 class 的外面
var sharedUserAccount = UserAccount.loadUserAccount()
/// 切换根视图控制器的通知
let HMSwitchRootViewControllerNotification = "HMSwitchRootViewControllerNotification"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let wbOAuthVC = OAuthViewController()
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // 设置窗口的Frame
        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        if (sharedUserAccount != nil){
            //  选择根控制器
            UserAccount.chooesRootVC(self.window!)
        }else{
            // 判断有没有授权Autho
            self.window?.rootViewController = wbOAuthVC
            
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didClickStartBtn:"), name: "swichRootVC", object: nil)
        // 显示窗口
        window?.makeKeyAndVisible()

        return true
        
    }

    func didClickStartBtn(n:NSDictionary){
        
        UserAccount.chooesRootVC(self.window!)

    }
   
    deinit{
        
    NSNotificationCenter.defaultCenter().removeObserver(self)
   
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

