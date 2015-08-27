//
//  WBretweetView.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/23.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

class WBretweetView: UIView {
    var nameView:UILabel?
    var textView:UILabel?
    var photosV:photosView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 1.添加所有的子控件
        setUpAllChildView()
        self.userInteractionEnabled = true

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setUpAllChildView(){
        
        
        nameView = UILabel()
        nameView!.font = UIFont.systemFontOfSize(14)
        self.addSubview(nameView!)
        
        textView = UILabel()
        textView?.font = UIFont.systemFontOfSize(15)
        textView?.numberOfLines = 0
        textView?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.addSubview(textView!)
        
        photosV = photosView(frame:CGRectZero)
        self.addSubview(photosV!)
        
    }
    
    var homeV:HomeVM?{
        didSet{

            var homeStatus:StatusResult = homeV!.status!.retweeted_status!
            if homeV?.transmitNameFrame != nil {
                nameView?.frame = homeV!.transmitNameFrame!
                nameView?.text = "@" + homeStatus.user.name!
                textView?.text = homeStatus.text
                textView?.frame = homeV!.transmitTextFrame!

            }
            
            if homeStatus.pic_urls.count>0{
                photosV?.hidden = false
                photosV?.pic_urls = homeStatus.pic_urls
                photosV?.frame = homeV!.transmitPhotosViewFrame!
                
            }else{
                
                photosV?.hidden = true
                
            }
            
            
        }
    }

}
