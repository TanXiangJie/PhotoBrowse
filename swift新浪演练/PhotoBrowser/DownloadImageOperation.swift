//
//  DownloadImageOperation.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/8/3.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit
class DownloadImageOperation: NSOperation{
    var urlStr:String?
    var successed:((image:UIImage)->Void)?
    class func downloadImageOpeartionWithURLString(urlString:String,successed:(image:UIImage?)->Void)->DownloadImageOperation{
        
        var op:DownloadImageOperation = DownloadImageOperation()
        op.urlStr = urlString
        println(op)
        op.successed = successed
        
        return op
    }
    
    override func main(){
        super.main()
        autoreleasepool { () -> () in
            // 1. 根据 url 下载图像
            if self.cancelled{return}
            if urlStr != nil {
                var data:NSData = NSData(contentsOfURL: NSURL(string: urlStr!)!)!
                println("开始下载")
                
                if self.cancelled{return}
                
                data.writeToFile(self.urlStr!.cacheDir(), atomically: true)
                
                println(self.urlStr!.cacheDir())
                // 3. 调用回调方法
                if (self.cancelled){return}
                
                if (self.successed != nil){
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        UIImage(contentsOfFile: self.urlStr!.cacheDir())
                        var image:UIImage = UIImage(data: data)!
                        if self.urlStr!.hasSuffix("gif"){
                            let Gif = GIFImage()
                            
                            self.successed!(image:                        Gif.animatedGIFWithData(data))
                            return
                        }
                        
                        self.successed!(image: image)
                        println("下载完毕")
                        
                    })
                }
            }
        }
        
    }
}