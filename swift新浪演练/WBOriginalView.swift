//
//  WBOriginalView.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/23.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

class WBOriginalView: UIView {
    
    var iconView:UIImageView?
    var nameView:UILabel?
    var vipView:UIImageView?
    var timeView:UILabel?
    var sourceView:UILabel?
    var textView:UILabel?
    var photosV:photosView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 1.添加所有的子控件
        setUpAllChildView()
        self.backgroundColor = UIColor.whiteColor()
        self.userInteractionEnabled = true
    
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpAllChildView(){
    
        iconView = UIImageView()
        self.addSubview(iconView!)
        
        nameView = UILabel()
        nameView!.font = UIFont.systemFontOfSize(14)
        self.addSubview(nameView!)
       
        vipView = UIImageView()
        self.addSubview(vipView!)
        
        timeView = UILabel()
        timeView?.textColor = UIColor.orangeColor()
        timeView?.font = UIFont.systemFontOfSize(12)
        self.addSubview(timeView!)
    
        sourceView = UILabel()
        sourceView?.textColor = UIColor.lightGrayColor()
        sourceView?.font = UIFont.systemFontOfSize(12)
        self.addSubview(sourceView!)
        
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
            
        var homeStatus:StatusResult = homeV!.status!
            
        iconView?.frame = homeV!.originalityIocnFrame!
//        iconView?.sd_setImageWithURL(NSURL(string: homeStatus.user.profile_image_url), placeholderImage: UIImage(named: "timeline_image_placeholder"))
            println(homeStatus.user.profile_image_url)
         iconView?.setImageWithURLString(homeStatus.user.profile_image_url)
        nameView?.frame = homeV!.originalitynameFrame!
        nameView?.text = homeStatus.user.name
        
        if homeStatus.user.mbtype?.toInt() > 2 {

                var imageName:String = "common_icon_membership_\(homeStatus.user.mbrank!.toInt()!)"
            
                vipView?.image = UIImage(named: imageName)
                vipView?.frame = homeV!.originalityVipFrame!
                nameView?.textColor = UIColor.redColor()
            }
            
           if homeV!.source != nil{
        sourceView?.text = homeV!.source!
        sourceView?.frame = homeV!.originalitysourceFrame!
          
            }
            
         timeView?.text = NSDate.createDate(homeStatus.created_at)!.fullDescription()
         timeView?.frame = homeV!.originalityTimeFrame!
          
         textView?.text = homeStatus.text
         textView?.frame = homeV!.originalitytextFrame!
        
        if homeStatus.pic_urls.count>0{
            
            photosV?.hidden = false
            photosV?.pic_urls = homeStatus.pic_urls
            photosV?.frame = homeV!.origPhotosViewFrame!

            }else{
            
            photosV?.hidden = true

            }
            
            
        }
     }
}
