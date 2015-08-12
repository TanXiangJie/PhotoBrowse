



//
//  photosView.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/26.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

class photosView: UIView {
    
    var photoX:CGFloat = 0
    var photoY:CGFloat = 0
    var col:Int = 0
    var row:Int = 0
    var pic_urlsBig = NSArray()
//   缩略图
    var imageURLs:[NSURL]?
//    大图
    var largeURLs:[NSURL]?
    override init(frame: CGRect) {
       
        super.init(frame:frame)
        setUpAllChildView()
        
        self.userInteractionEnabled = true

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpAllChildView(){
           for(var i: Int = 0; i < 9; i++ ){
            var imageV = UIImageView()
            imageV.userInteractionEnabled = true
            imageV.tag = self.subviews.count
            var tapGesture = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
            imageV.addGestureRecognizer(tapGesture)
            self.addSubview(imageV)
        }
    }
    var pic_urls = NSArray(){
        
        didSet{
            imageURLs = [NSURL]()
            largeURLs = [NSURL]()

            for dict in pic_urls {
                
                if let urlString:AnyObject = dict["thumbnail_pic"] {
                    // 计算出大图的地址，需要替换字符串
                    let largeString = (urlString as! NSString).stringByReplacingOccurrencesOfString("thumbnail", withString: "large")
                    imageURLs?.append(NSURL(string: urlString as! String)!)
                    largeURLs?.append(NSURL(string: largeString as String)!)
                    
                }
            }

            
            
            var count:Int = pic_urls.count
            var cols:Int = count == 4 ? 2 : 3
            
            // 遍历模型数组,取出对应UIImageView,计算位置
            for(var i: Int = 0; i < count; i++ ){
                col = i % cols
                row = i / cols
                photoX = CGFloat(col * (100 + 5))
                photoY = CGFloat(row * (100 + 5))
                var imageV:UIImageView = self.subviews[i] as! UIImageView
               if i < imageURLs?.count{
                var imageURL:String = "\(imageURLs![i])"
               // imageV.sd_setImageWithURL(imageURLs![i])
                imageV.setImageWithURLString("\(imageURLs![i])")
                imageV.contentMode = UIViewContentMode.ScaleAspectFit
                imageV.backgroundColor = UIColor.groupTableViewBackgroundColor()
                imageV.frame = CGRectMake(photoX, photoY, 100,100)
                //  gifv
                var GIFimage = UIImageView()
                GIFimage.image = UIImage(named: "timeline_image_gif")
                imageV.addSubview(GIFimage)
                GIFimage.frame = CGRect(origin: CGPointMake(83,87),size: CGSizeMake(17, 13))
                if imageURL.hasSuffix("gif"){
                    GIFimage.hidden = false
                }else{
                    GIFimage.hidden = true
                }

                imageV.hidden = false
                    
                }else{
                imageV.hidden = true
                }
            }
    
        }
        
    }
    
    func handleTapGesture(sender: UITapGestureRecognizer){
        var imageV:UIImageView = sender.view as! UIImageView

        if largeURLs!.count>imageV.tag{

        println(largeURLs![imageV.tag])
//     弹出图片浏览器
        var pic = photoBrowser()
            pic.showPhotos(imageV, images: largeURLs!, currentIndex: imageV.tag)
        }
    }
}
