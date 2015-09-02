//
//  mainTabBarViewController.swift
//  河北人民广播电台
//
//  Created by 若水三千 on 15/8/8.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

class mainTabBarViewController: UITabBarController {
    var Nav:MainNavViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加子视图控制器
        addChildViewControllers()
    }
    // 设置tabBar的子控制器
    private  func addChildViewControllers(){
        // FM
        let BaiduFM = BaiduFMViewController()
        addChildViewController( "百度FM",BaiduFM)
        
    }
    //  设置每一个子控制器
    private func addChildViewController(title:String,_ vc:UIViewController){
        vc.title = title
        vc.tabBarItem.title = title
        vc.tabBarItem.titleTextAttributesForState(UIControlState.Normal)
        Nav = MainNavViewController(rootViewController: vc)
        //添加对象到数组
        addChildViewController(Nav!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addLeftOrRightBtn(name:String?,Leftimage:String?,targer:AnyObject?, action:Selector?)->UIBarButtonItem{
        
        let button = UIButton()
        button.frame = CGRectMake(0, 0,60, 30)
        if name != nil{
            button.setTitle(name!, forState: UIControlState.Normal)
        }
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        if Leftimage != nil{
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
            var imageV = UIImageView (image:UIImage(named: Leftimage!))
            imageV.userInteractionEnabled = false
            imageV.frame = CGRectMake(-5, 3, 25, 25)
            button.addSubview(imageV)
        }
        if action != nil{
            button.addTarget(targer, action: action!, forControlEvents: UIControlEvents.TouchUpInside)
        }
        return UIBarButtonItem(customView: button)
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
