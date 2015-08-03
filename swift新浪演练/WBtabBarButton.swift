
//
//  WBtabBarButton.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/12.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit
class WBtabBarButton: UIButton {
    var itmes:UITabBarItem?
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setImage(itmes!.image, forState:UIControlState.Normal)
        self.setImage(itmes!.selectedImage, forState: UIControlState.Selected)
        self.setTitle(itmes!.title, forState: UIControlState.Normal)
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Selected)
        self.adjustsImageWhenHighlighted = false;
        self.highlighted = false
        
        //  图片的frame
        var imageX : CGFloat = 23;
        var imageH : CGFloat = self.frame.size.height*0.6
        var imageW : CGFloat = self.frame.size.height*0.6
        self.imageView!.frame = CGRectMake(imageX, 0, imageW, imageH);


        // 文字的frame
        let titleX : CGFloat = 0
        let titleY : CGFloat = self.frame.size.height*0.65
        let titleW : CGFloat = self.frame.size.width;
        let titleH : CGFloat = self.frame.size.height*0.3;

        self.titleLabel!.frame = CGRectMake(titleX, titleY, titleW, titleH)
        self.titleLabel?.textAlignment = NSTextAlignment.Center

        self.titleLabel?.font = UIFont.systemFontOfSize(13)
    }
    

}
