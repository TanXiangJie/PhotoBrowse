
//  HomeVM.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/22.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

class HomeVM: NSObject {
//   原创微博的frame********************
    var originalityFrame:CGRect?
    
    var originalityTimeFrame:CGRect?
    
    /// 来源
    var originalitysourceFrame:CGRect?
    
    /// 头像 frame
    var originalityIocnFrame:CGRect?
    /// 名字 frame
    var originalitynameFrame:CGRect?
    /// VIP Frame
    var originalityVipFrame:CGRect?
    /// 内容
    var originalitytextFrame:CGRect?
    /// 配图
    var origPhotosViewFrame:CGRect?

    /// 转发微博@
    var transmit:String?
    /// VIP
    var Vipimage:UIImage?
  /// 来源
    var source:String?

    // 微博创建时间
    var created_at: String?

//   转发微博frame**********************
    
    var transmitFrame:CGRect?

    /// 转发微博昵称
    var transmitNameFrame:CGRect?
    /// 转发微博正文
    var transmitTextFrame:CGRect?
    /// 转发配图
    var transmitPhotosViewFrame:CGRect?
//   工具条的frame
    var statusToolBarFrame:CGRect?
//    cell的高度 = 最大的工具条的Y值
    var cellHeight:CGFloat?
    
    var status:StatusResult?{
        
        didSet{

    // 处理基本业务逻辑
     initial()
        
        }
    }

    
    func initial(){
        // 来源
        if  (status!.source as NSString).length>0 {
            source = "来自\(status!.source.hrefLink()!.linkText)"
        }
        //   时间处理
        created_at = NSDate.createDate(status!.created_at)!.fullDescription()

        // 原创微博的frame
        setUpOriginaity()
        
        // 得到最大的Y值
        var Y:CGFloat = CGRectGetMaxY(originalityFrame!)
        // 有没有转发微博
        if status!.retweeted_status?.user != nil {
            transmit = status!.retweeted_status?.user.name
            setUpTransmitWB()
            
            Y = CGRectGetMaxY(transmitFrame!)

        }
        
        // 工具条
        var X:CGFloat = 0;
        var H:CGFloat = 35;
        var W:CGFloat = UIScreen.mainScreen().bounds.width;
        statusToolBarFrame = CGRectMake(X, Y, W, H)
        // Cell 的高度
        cellHeight = CGRectGetMaxY(statusToolBarFrame!)+5

        
    }
   
    
    func setUpOriginaity(){
        let IconXY:CGFloat = 10;
        let IconWH:CGFloat = 35;
        originalityIocnFrame = CGRectMake(IconXY, IconXY, IconWH, IconWH)
        
        let nameX:CGFloat = IconWH+15;
        let nameY:CGFloat = 13;
        var nameSize:CGSize = (status!.user.name as NSString).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
        originalitynameFrame = CGRect(origin: CGPointMake(nameX, nameY), size: nameSize)
        
        if status!.user.Vip == true {
        var vipX = CGRectGetMaxX(originalitynameFrame!)+5
        var vipY:CGFloat = nameY
        var vipWH:CGFloat = 14
            
        originalityVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH)
       
        }
        
        var timeX:CGFloat = originalitynameFrame!.origin.x
        var timeY:CGFloat = CGRectGetMaxY(originalitynameFrame!)+5
        var timeStr:NSString = created_at! as NSString
        var timeSize:CGSize = timeStr.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(12)])
        originalityTimeFrame = CGRect(origin: CGPointMake(timeX, timeY), size:timeSize)
        
       if source != nil{
        var sourceX:CGFloat = CGRectGetMaxX(originalityTimeFrame!)+3
        var sourceY:CGFloat = timeY
        var sourceSize:CGSize = (source! as NSString).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(12)])
        originalitysourceFrame = CGRect(origin: CGPointMake(sourceX, sourceY), size:sourceSize)
        }
        
        var textW:CGFloat = UIScreen.mainScreen().bounds.size.width-10
        var attributes = [NSFontAttributeName:UIFont.systemFontOfSize(15)]
        var option = NSStringDrawingOptions.UsesLineFragmentOrigin
        var textSize: NSString = NSString(CString: status!.text.cStringUsingEncoding(NSUTF8StringEncoding)!,
            encoding: NSUTF8StringEncoding)!
        var Rect =  textSize.boundingRectWithSize(CGSizeMake(textW,(CGFloat.max)), options: option, attributes: attributes, context: nil)
           Rect.origin.x = 10
           Rect.origin.y = CGRectGetMaxY(originalityIocnFrame!)+10
         originalitytextFrame = Rect
        var originH :CGFloat = CGRectGetMaxY(originalitytextFrame!)+10
        
        
//      有没有配图
        if status!.pic_urls.count > 0 {
            var photoX:CGFloat = 10
            var photoY:CGFloat = CGRectGetMaxY(originalitytextFrame!)+10
            var photoSize:CGSize = photoSizeWithCount(status!.pic_urls.count)
            origPhotosViewFrame = CGRect(origin: CGPointMake(photoX, photoY), size: photoSize)
            originH = CGRectGetMaxY(origPhotosViewFrame!)+5
        }
    
        // 7.计算原创微博
        let originX:CGFloat = 0
        let originY:CGFloat = 10
        var originW:CGFloat = UIScreen.mainScreen().bounds.size.width
        
        originalityFrame = CGRectMake(originX, originX, originW, originH)
    }
    
    /**
    *  转发微博的frame
    */
    
   func setUpTransmitWB(){
    // 昵称
    var nameX:CGFloat = 10;
    var nameY:CGFloat = 0;
    // 昵称的大小由他的字体大小决定
    var nameSize:CGSize = transmit!.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
    transmitNameFrame = CGRect(origin: CGPointMake(nameX, nameY), size: nameSize)
    //     正文
    var textW:CGFloat = UIScreen.mainScreen().bounds.size.width-10
    var attributes = [NSFontAttributeName:UIFont.systemFontOfSize(15)]
    var option = NSStringDrawingOptions.UsesLineFragmentOrigin
    var textSize: NSString = NSString(CString: status!.retweeted_status!.text.cStringUsingEncoding(NSUTF8StringEncoding)!,
        encoding: NSUTF8StringEncoding)!
    var Rect =  textSize.boundingRectWithSize(CGSizeMake(textW,(CGFloat.max)), options: option, attributes: attributes, context: nil)
    Rect.origin.x = 10
    Rect.origin.y = CGRectGetMaxY(transmitNameFrame!)+5
    transmitTextFrame = Rect
    
    var transimtH:CGFloat = CGRectGetMaxY(transmitTextFrame!) + 10
    
    if status?.retweeted_status?.pic_urls.count > 0 {
   
    // 配图
    var photoX:CGFloat  = 10
    var photoY:CGFloat = CGRectGetMaxY(transmitTextFrame!)+10
    var photoSize:CGSize  =  photoSizeWithCount(status!.retweeted_status!.pic_urls.count)
    transmitPhotosViewFrame = CGRect(origin: CGPointMake(photoX, photoY), size: photoSize)
    transimtH = CGRectGetMaxY(transmitPhotosViewFrame!) + 5
    
    }
    
    
    // 7.计算转发微博
    var transimtX:CGFloat = 0
    var transimtY:CGFloat = originalityFrame!.size.height
    var transimtW:CGFloat = UIScreen.mainScreen().bounds.size.width
    transmitFrame = CGRectMake(transimtX, transimtY, transimtW, transimtH);
    
    }
    
    func photoSizeWithCount(count:NSInteger) ->CGSize{
        
        //  总列数
        var cols:NSInteger = count == 4 ? 2 : 3
        //   总行数
        var row:NSInteger = (count - 1)/cols+1
        
        var PhotoW:CGFloat = CGFloat(cols * 100 + (cols - 1) * 5)
        var PhotoH:CGFloat = CGFloat(row * 100 + (row - 1) * 5)
        return CGSizeMake(PhotoW, PhotoH)
    }
    

}
