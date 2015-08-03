//
//  UserpageViewController.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/15.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

class UserpageViewController: UIViewController {
    var welcomeLabel:UILabel?
    var group:CAAnimationGroup?
    var iconImage:UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let BJimage = UIImageView(frame: self.view.bounds)
        
        BJimage.image = UIImage(named: "ad_background")
        
        self.view.addSubview(BJimage)
        
        iconImage = UIImageView(frame:  CGRectMake((self.view.frame.size.width-80)/2, 150, 80, 80))
        
        let image = UIImage(named: "avatar_default_big")
        
        iconImage!.layer.cornerRadius = 40
        iconImage!.clipsToBounds = true
        self.view.addSubview(iconImage!)
        
        welcomeLabel = UILabel()
        
        welcomeLabel?.frame = CGRectMake((self.view.frame.size.width-80)/2,160,70, 25)
        welcomeLabel?.text = "欢迎回来"
        welcomeLabel?.font = UIFont(name:"Thonburi",size:16)
        welcomeLabel?.tintColor = UIColor.blackColor()
        welcomeLabel?.textAlignment = NSTextAlignment.Center
        welcomeLabel?.alpha = 0
        self.view.addSubview(welcomeLabel!)

        let urlString = sharedUserAccount?.avatar_large
        if  urlString != nil{

        iconImage!.sd_setImageWithURL(NSURL(string: urlString!), placeholderImage: image)
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
  
        UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            var basketTopFrame = self.iconImage!.frame
            basketTopFrame.origin.y -= basketTopFrame.size.height
            
            self.iconImage!.frame = basketTopFrame

            }) { _ in
                
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    self.welcomeLabel!.alpha = 1.0
                    
                    }, completion: { (_) in
                        
                        // 创建tabBar根控制器
                        let RootController = MainTabBar()
                        // 成为窗口的根控制器
                       UIApplication.sharedApplication().keyWindow!.rootViewController = RootController
                })
                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
