//
//  HomeTableViewCell.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/22.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    var OriginalV:WBOriginalView?
    
    var statusToolBar:WBstatusToolBar?
    
    var retweetV:WBretweetView?
    
 override  init(style: UITableViewCellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
    // 添加所有的子控件(原创,转发,工具条)
       setUpAllChildView()
    self.userInteractionEnabled = true
  }
 
 required init(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
 }
 
    func setUpAllChildView(){
         // 原创
        OriginalV = WBOriginalView()
        
        self.contentView.addSubview(OriginalV!)
        // 转发
        statusToolBar = WBstatusToolBar(frame: CGRectZero)
        self.contentView.addSubview(statusToolBar!)
        // 工具条
        retweetV = WBretweetView()
        self.contentView.addSubview(retweetV!)
        self.userInteractionEnabled = true
    }
    
    
    var home:HomeVM?{
        didSet{
            //   设置原创微博的frame
            OriginalV?.frame = home!.originalityFrame!
            //   设置原创微博的内容
            OriginalV?.homeV = home
            
            if home?.status?.retweeted_status != nil{
                //   设置转发微薄的内容
                retweetV?.homeV = home
                //   这只转发微博的frame
                retweetV?.frame = home!.transmitFrame!
                
            }
            //   设置工具条frame
            statusToolBar?.frame = home!.statusToolBarFrame!
            //   设置工具条的内容
            statusToolBar?.homeV = home?.status
            
        }
    }
    
}
