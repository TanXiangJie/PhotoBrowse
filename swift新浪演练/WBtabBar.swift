
//
//  WBtabBar.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/12.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit
// 所有继承自 NSObject 的对象，都可以实现协议方法
// protocol WBtabBarDelegate <NSObject>
protocol WBtabBarDelegate: NSObjectProtocol {

    func didClickBtn(tabBar:WBtabBar,index:NSInteger)
}

class WBtabBar: UIView {
    var itmes = NSMutableArray()
    var selectedBtn = UIButton()
    var Btns = NSMutableArray()
    // 定义代理（weak）
    weak var delegate: WBtabBarDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()
// 移除之前添加所有的按钮不重复
        for V in self.subviews{
        V.removeFromSuperview()
            
        }
        
        var  i : NSInteger = 0
        // 按钮的总数
        let btnCount = itmes.count+1
        
        let w = self.bounds.size.width / CGFloat(btnCount)
        let h = self.bounds.size.height
        

// 添加所有的按钮
        for itme in itmes{
            var tabBar = UITabBarItem()
            tabBar = itme as! UITabBarItem
            var btn = WBtabBarButton()
            btn.itmes = itme as? UITabBarItem
            btn.tag = Btns.count

            if i == 2 {
                i=3
            }

            btn.frame = CGRectMake(CGFloat(i) * w,0,w,h)
            i++

            self.addSubview(btn)
            
            btn.addTarget(self,action: "clickTabBarBtn:", forControlEvents: UIControlEvents.TouchUpInside)
            if btn.tag == 0 {
            clickTabBarBtn(btn)
            }
//    保存到数组中
            Btns.addObject(btn)
        }
        
        // 指定数组中的类型都是 UIView，在 OC 中，所有的控件都继承自 UIView

        // 每个按钮的大小固定
        let frame = CGRectMake(0, 0, w, h)
        var index = 0
        for v in subviews as! [UIView] {
            // 只需要修改 UITabBarButton 的位置
            // 判断 v 的类型，在 OC 中是使用 isKindOfClass
            // UIControl 可以 addTarget，主动的添加监听方法，可以接受用户的点击或者触摸事件
    
            if v is UIControl && !(v is UIButton) {
                v.frame = CGRectOffset(frame, CGFloat(index) * w, 0)
                
                // 三目
                index += (index == 1) ? 2 : 1
            }
        }
        
        // 指定撰写按钮的位置
        self.composedButton.frame = CGRectOffset(frame, 2 * w, 0)
        self.addSubview(composedButton)
    }
    
    lazy var composedButton: UIButton = {
        // OC 中使用 [[UIButton alloc] init] 实例化出来的 button 就是 custom 的
        // let btn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton

        let btn = UIButton()
       btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Selected)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Selected)
        btn.addTarget(self,action: "clickTabBarBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        btn.tag = 5;
        // 懒加载的代码是闭包，是提前准备好的代码，在需要的时候执行，闭包中就需要使用 self.
//        self.addSubview(btn)
        
        return btn
       
        }()

    // 按钮的点击事件
    func clickTabBarBtn(sender:UIButton){
        if sender.tag != 5{
        //  取消上次按钮选中
        selectedBtn.selected = false
        //  选中点击的按钮
        sender.selected = true
        selectedBtn = sender
        }
//  通知代理做事点击哪个Btn
   delegate!.didClickBtn(self, index: sender.tag)
    }
    
}
