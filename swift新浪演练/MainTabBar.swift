//
//  MainTabBar.swift
//  swift新浪微博
//
//  Created by 若水三千 on 15/7/12.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit
class MainTabBar: UITabBarController,WBtabBarDelegate{
    var items = NSMutableArray()
    var tabBar1 :WBtabBar?
    var ComposeV:ComposeVeiw?
    var Nav:MainNavController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加子视图控制器
        addChildViewControllers()
        setUpTabBar()
        

    }

    // 设置tabBar的子控制器
    private  func addChildViewControllers(){
        // 首页
        let homeVC = HomeViewController()
        addChildViewController("tabbar_home", "首页", "tabbar_home_selected",homeVC)
        // 消息
        let msgVC = msgViewController()
        addChildViewController("tabbar_message_center", "消息", "tabbar_message_center_selected",msgVC)
        //  发现
        let DiscoerVC = DiscoverViewController()
        addChildViewController("tabbar_discover", "发现", "tabbar_discover_selected",DiscoerVC)
        //  我
        let MeVC = MeViewController()
        addChildViewController("tabbar_profile", "我", "tabbar_profile_selected",MeVC)
    }
    
    //  设置每一个子控制器
    private func addChildViewController(wbName:String,_ title:String,_ image:String,_ vc:UIViewController){
        vc.title = title
        vc.tabBarItem.image = UIImage(named: wbName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: image)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        Nav = MainNavController(rootViewController: vc)
        //   添加对象到数组
        self.items.addObject(vc.tabBarItem)
        addChildViewController(Nav!)
    }
    //  设置tabar
    func setUpTabBar(){
        tabBar1 = WBtabBar(frame:self.tabBar.bounds)
        tabBar1?.delegate = self
        self.tabBar.addSubview(tabBar1!)
        tabBar1!.itmes = self.items
        
    }
    
    override func  viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let tab = UIView()
        
        for tab in self.tabBar.subviews{
            if tab.isKindOfClass(NSClassFromString("UITabBarButton")){
                tab.removeFromSuperview()
            }
        }
        
    }
    
    func didClickBtn(tabBar: WBtabBar, index: NSInteger) {
        if index == 0 && self.selectedIndex == index{
            //       刷新
        }
        self.selectedIndex = index;
        
        if index == 5{
            ComposeV = ComposeVeiw()
            Nav = MainNavController(rootViewController: ComposeV!)
            presentViewController(Nav!, animated: true, completion: nil)
            
        }
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
