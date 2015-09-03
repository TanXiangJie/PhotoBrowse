//
//  testViewController.swift
//  webImage
//
//  Created by 若水三千 on 15/9/2.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

class testViewController: UIViewController {
    override func loadView() {
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let nextItem=UIBarButtonItem(title:"下一页",style:.Plain,target:self,action:"next")
        //  添加到到导航栏上
        self.navigationItem.rightBarButtonItem = nextItem


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Item 事件
    func next()
    {
        println("点击了下一页");
        // 定义一个控制器
        let tow_vc = BaiduFMViewController();
        //推入下一个视图
        self.navigationController!.pushViewController(tow_vc,animated:true);
    }
    deinit{
        
        println("我走了")
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
