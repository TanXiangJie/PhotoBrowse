//
//  WBstatusToolBar.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/23.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

class WBstatusToolBar: UIImageView {

    var retweetBtn:UIButton?
    var commentBtn:UIButton?
    var unlikeBtn:UIButton?
    var title: String?

    override init(frame: CGRect) {
      super.init(frame: frame)
        // 1.添加所有的子控件
        setUpAllChildView()
        self.image = UIImage(named: "timeline_card_bottom_background")!
     self.userInteractionEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpAllChildView(){
        retweetBtn = UIButton()
        retweetBtn = self.setUpOneChildViewWithImage(UIImage(named: "timeline_icon_retweet")!, title: "转发")
        commentBtn = UIButton()
        commentBtn = self.setUpOneChildViewWithImage(UIImage(named: "timeline_icon_comment")!, title: "评论")
        unlikeBtn = UIButton()
        unlikeBtn = self.setUpOneChildViewWithImage(UIImage(named: "timeline_icon_unlike")!, title: "赞")
        self.userInteractionEnabled = true

    }
    
    func setUpOneChildViewWithImage(image:UIImage,title:String)->UIButton{
        var btn:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        btn.setTitle(title, forState: UIControlState.Normal)

        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.setImage(image, forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(12)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        self.addSubview(btn)
       return btn
    }
    
        var homeV:StatusResult?{
        
        didSet{
            setUpBtnTitle(retweetBtn!, count:homeV!.reposts_count)
            setUpBtnTitle(commentBtn!, count:homeV!.comments_count)
            setUpBtnTitle(unlikeBtn!, count:homeV!.attitudes_count)

        }
    }

    func setUpBtnTitle(btn:UIButton,count:Int){
        if count >= 0 {
            if count<10000{
                title = String(format: "%d",count)

            }

            if (count > 10000) { // 处理
                var floatCount:CGFloat = CGFloat(count/10000)
               title = NSString(format: "%0.1f w" ,floatCount) as String
                title = title!.stringByReplacingOccurrencesOfString(".0", withString: "")
                
            }
            
            btn.setTitle(title, forState: UIControlState.Normal)
        }

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // 获取按钮的个数
        var count:NSInteger = self.subviews.count
        var x:CGFloat = 0
        var y:CGFloat = 0
        var h:CGFloat = self.frame.height
        var w:CGFloat = self.frame.width/CGFloat(count)

        for (var i:Int = 0; i < count; ++i) {
            var btn:UIButton = self.subviews[i] as! UIButton;
            x = (CGFloat)(i) * w
            btn.frame = CGRectMake(x, y, w, h)
        }

    }
}
