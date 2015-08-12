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
    var URLSTR:NSURL?
    var successed:((image:UIImage)->Void)?
    var failed:((error:String)->Void)?
    
    class func downloadImageOpeartionWithURLString(urlString:String,successed:(image:UIImage?)->Void,failed:(error:String)->Void)->DownloadImageOperation{
        
        var op:DownloadImageOperation = DownloadImageOperation()
        op.urlStr = urlString
        op.successed = successed
        op.failed = failed
        return op
    }
    
    override func main(){
        super.main()
        autoreleasepool { () -> () in
            // 1. 根据 url 下载图像
            if self.cancelled{return}
            if urlStr != nil && urlStr != ""{
                URLSTR = NSURL(string: urlStr!)
                var data = NSData(contentsOfURL:URLSTR!)
                
                if self.cancelled{return}
                if data == nil {
                    return
                }

                data!.writeToFile(self.urlStr!.md5!.cacheDir(), atomically: true)
                println(self.urlStr!.cacheDir())
                if self.cancelled{return}
              dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // 3. 调用回调方法
                var image = UIImage(data: data!)
                if (self.cancelled){return}
                
                if (self.successed != nil && image != nil ){
                    
                    println("下载完毕")
                    println(image)
                    
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                if self.urlStr!.hasSuffix("gif"){
//                    let Gif = GIFImage()
//                            
//                self.successed!(image:Gif.animatedGIFWithData(data))
//                            
//                return
//                }
               self.successed!(image: image!)
                        println("下载完毕")
            })

//                    self.successed!(image: image!)
                }
                if (self.failed != nil && image == nil ){
                    self.failed!(error: "下载失败")
                }

              })
                
            }
            
            
        }
    }
}