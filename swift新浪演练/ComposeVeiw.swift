//
//  ComposeVeiw.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/13.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

class ComposeVeiw: UIViewController {
    var nav = MainTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        
       self.navigationItem.leftBarButtonItem = nav.addLeftOrRightBtn("取消", Leftimage: nil, targer: self, action:Selector("disMissVC"))
        
       self.navigationItem.rightBarButtonItem = nav.addLeftOrRightBtn("发送", Leftimage: nil, targer: nil, action:nil)
    }
    
    func disMissVC (){
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func backVC () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    



}
