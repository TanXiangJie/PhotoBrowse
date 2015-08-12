//
//  interceptionImage.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/8/3.
//  Copyright (c) 2015年 若水三千. All rights reserved.
// 截图在这个框架中没使用到不想要的可以移除

import UIKit
class InterceptionImage : NSObject {
var Newimage = UIImage()
/// 截图
private func capture(view:UIView)->UIImage{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0);
    view.layer.renderInContext(UIGraphicsGetCurrentContext())
    var img:UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img;
}
/// 获得截图图片
func setSrcImageView(srcImageView:UIImageView)->UIImage
{       Newimage = capture(srcImageView)
   return  Newimage
}

}