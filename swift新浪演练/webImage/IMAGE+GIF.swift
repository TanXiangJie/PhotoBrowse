
//
//  IMAGE+GIF.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/8/3.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//
//////////// GIF 图片处理/////////////////////

import UIKit
import ImageIO
class GIFImage : NSObject {
    
    func animatedGIFWithData(imageData:NSData?)->UIImage{
        var animatedImage = UIImage()
        
        if (imageData != nil) {
            
            var imageSource = CGImageSourceCreateWithData(imageData, nil)
            let Count: size_t = CGImageSourceGetCount(imageSource)
            
            if Count <= 1 {
                animatedImage = UIImage(data: imageData!)!
            } else {
                var images = NSMutableArray()
                var duration:NSTimeInterval = 0.00
                
                for var i:size_t = 0; i < Count; i++ {
                    var image = CGImageSourceCreateImageAtIndex(imageSource, i, nil)
                    duration +=  frameDurationAtIndex(i, source: imageSource)
                    images.addObject(UIImage(CGImage: image, scale: UIScreen.mainScreen().scale, orientation: UIImageOrientation.Up)!)
                    
                }
                if (duration <= 0.0) {
                    duration = 0.10 * Double(Count)
                }
                animatedImage = UIImage.animatedImageWithImages(images as [AnyObject], duration: duration)
            
            }
        
        }
        return animatedImage
        
    }
 ///GIF 时间处理
 private func frameDurationAtIndex(index:Int,source:CGImageSourceRef)->Double{
        var duration:Double = 0.1
        var imageProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as NSDictionary
        
        var GIFProperties: NSDictionary? = imageProperties[String(kCGImagePropertyGIFDictionary)] as? NSDictionary
        
        
        if let properties = GIFProperties {
            var delayTimeUnclampedProp = properties[String(kCGImagePropertyGIFUnclampedDelayTime)] as! Double
            
            if delayTimeUnclampedProp <= 0.000 {
                duration = properties[String(kCGImagePropertyGIFUnclampedDelayTime)] as! Double
            }else{
                duration = properties[String(kCGImagePropertyGIFDelayTime)] as! Double
                
            }
            let threshold = 0.02 - Double(FLT_EPSILON)
            
            if duration > 0 && duration < threshold {
                duration = 0.1
            }
        }
        return duration
 }
    /////////////////////////// 这里没有使用过截图/////////////可以移除

    private func capture(view:UIView)->UIImage{
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0);
        view.layer.renderInContext(UIGraphicsGetCurrentContext())
        var img:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img;
    }
    /// 获得截图图片
    func setSrcImageView(srcImageView:UIImageView)->UIImage
    {
       return capture(srcImageView)
    
    }
    
}
