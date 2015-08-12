
//
//  XJimage.swift
//  名人段子
//
//  Created by 若水三千 on 15/8/6.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

extension UIImageView {
    private struct AssociatedKeys {
        static var descriptiveNameURL = "ImageViewURLKey"
    }
    // 运行时相关设置关联对象 (关键作用)
    var descriptiveNameURL:String?
        {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.descriptiveNameURL) as? String
        }
        set {
            if let newValue = newValue {
                println(newValue)
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.descriptiveNameURL,
                    newValue as NSString?,
                    UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                )
            }
        }
    }

    ///   根据指定的 url 字符串，下载图像
    func setImageWithURLString(urlStr:String){
        
    if descriptiveNameURL == urlStr {
       println("地址一致不用重新下载")
     return
    }
        
    // 更换地址取消上次的下载
    if (descriptiveNameURL != nil ) {
       
      DownloadImageManager.sharedDownImageManager.cancelDownloadWithURLString(descriptiveNameURL!)

        }
        // 1 清空图像
        self.image = nil

        descriptiveNameURL = urlStr

    DownloadImageManager.sharedDownImageManager.downloadImageOpeartionWithURLString(urlStr, successed: { (image) -> Void in

        self.image = image
        self.sizeThatFits(CGSizeMake(image.size.width, image.size.height))

        }) { (error) -> Void in
        
        }
    }
    
}