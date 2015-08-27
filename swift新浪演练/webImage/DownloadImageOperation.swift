//
//  DownloadImageOperation.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/8/3.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit
class DownloadImageOperation: NSOperation{
    
    var imageURL:String?
    var URLSTR:NSURL?
    var successed:((image:UIImage)->Void)?
    var failed:((error:String)->Void)?
    var image:UIImage?
    class func downloadImageOpeartionWithURLString(imageUrl:String,successed:(image:UIImage?)->Void,failed:(error:String)->Void)->DownloadImageOperation{
        
        var op:DownloadImageOperation = DownloadImageOperation()
        op.imageURL = imageUrl
        op.successed = successed
        op.failed = failed
        return op
    }
    
    override func main(){
       
        super.main()
        
        autoreleasepool { () -> () in
            
            if self.cancelled{return} // 任务取消
            
            if imageURL != nil && imageURL != ""{
                
                URLSTR = NSURL(string: imageURL!)
                
                var data = NSData(contentsOfURL:URLSTR!)
                
                if self.cancelled || data == nil{return}
                // 将图片的url地址MD5保证唯一性
                if data!.length/1024 > 1 && imageURL!.hasSuffix("jpg") {
                    
                   var oldimage = UIImage(data: data!)
                   
                   data = UIImageJPEGRepresentation(oldimage,0.5)
                
                }
                data!.writeToFile(self.imageURL!.md5!.cacheDir(), atomically: true)

                if self.cancelled{return}
                 image = UIImage(data: data!)
                
                if (self.cancelled){return}
                
                // 3. 调用回调方法
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if (self.successed != nil && self.image != nil ){
                        
                        if self.imageURL!.hasSuffix("gif"){
                            let Gif = GIFImage()
                            
                            self.successed!(image:Gif.animatedGIFWithData(data)!)
                            return
                        }
                        
                        self.successed!(image: self.image!)
                        println("下载完毕")
                        
                    }
                    
                    if (self.failed != nil && self.image == nil ){
                       
                        self.failed!(error: "下载失败")
                
                    }
                    
                })
                
            }
            
            
        }
    }
}