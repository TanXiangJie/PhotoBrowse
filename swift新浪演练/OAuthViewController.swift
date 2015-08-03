//
//  OAuthViewController.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/14.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit


class OAuthViewController: UIViewController,UIWebViewDelegate {
    let WB_Client_Id = "2997329615"
    let WB_Redirect_Uri = "http://www.baidu.com"
    let WB_Client_Secret = "07263aac64b7c8b02d71c4f19695b63d"

    var webView :UIWebView?
    override func viewDidLoad() {
        super.viewDidLoad()
    let navBar = UINavigationBar()
    let NavItem = UINavigationItem()
        NavItem.title = "授权界面"
        navBar.items = [NavItem]
        navBar.frame = CGRectMake(0, 0, self.view.frame.size.width,64)
        navBar.barTintColor = UIColor.whiteColor()
        self.view.addSubview(navBar)

    webView = UIWebView(frame:CGRectMake(0,64 , self.view.frame.width, self.view.frame.size.height-64))
        
//  加载授权界面
    loadWebView()
    self.view.addSubview(webView!)
     webView!.delegate = self
    
    }
    
    func loadWebView(){
    let urlString = "https://api.weibo.com/oauth2/authorize?client_id=" + WB_Client_Id + "&redirect_uri=" + WB_Redirect_Uri
        
    let url = NSURL(string: urlString)
    webView!.loadRequest(NSURLRequest(URL: url!))

    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
      
//  获取完成的字符串
     let urlString = request.URL!.absoluteString!
//  如果是新浪的页面继续加载
        if urlString.hasPrefix("https://api.weibo.com/"){
            return true
        }
        //  如果是回调的页面停止
        if !urlString.hasPrefix(WB_Redirect_Uri){
            
        return false
            
        }
        // 3. 代码执行到这里，就一定是回调的地址
        // query 可以过滤掉协议头和主机地址，所有的参数部分取出
        println("------" + request.URL!.query!)
       let codeStr = "code="
       let query = request.URL!.query!
        
        if query.hasPrefix(codeStr){
//   获取请求码
            let code = (query as NSString).substringFromIndex(codeStr.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
            println(code)
            
          loadAccessToken(code)
            
        }else{
//        取消授权
            
        }
        
        return false
    }
    
    private func loadAccessToken(code: String) {
        let params = ["client_id": WB_Client_Id,
            "client_secret": WB_Client_Secret,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": WB_Redirect_Uri,]
    UserAccount.loadAccessToken(params, completion: { (account) -> () in
        if account != nil{
            println("账户信息 ---> \(account)")
          
            sharedUserAccount = account
            NSNotificationCenter.defaultCenter().postNotificationName("swichRootVC", object: nil)
            
        }
    })
    
    }
    // 开始加载页面
    func webViewDidStartLoad(webView: UIWebView) {
       SVProgressHUD.show()
    }
    
    // 页面加载完成
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
 
}
