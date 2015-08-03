//
//  DownloadImageManager.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/8/3.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit
class DownloadImageManager :NSObject {
    var success:((image:UIImage)->Void)?
    /// 下载操作缓冲池
    var operationsCache = NSMutableDictionary()
    ///   图像缓存池 － 因为可以从磁盘再次加载，因此可以用 NSCache 替代
    var imagesCache = NSCache()
    
    // 下载指定的URL的图像
    func  downloadImageOpeartionWithURLString(urlString:String,successed:(image:UIImage?)->Void){
        
        // 判断内存中是否有图像
        var image:AnyObject? = self.imagesCache.objectForKey(urlString)
        println(self.imagesCache.objectForKey(urlString))
        if (image != nil) {
            println("从内存加载图像")
            // 直接回调，不再继续
            successed(image:image as? UIImage)
            return
        }else{
            
            // 判断沙盒中是否有图像
            var image1 = UIImage(contentsOfFile: urlString.cacheDir())
            if (image1 != nil)  {
                println("从磁盘加载")
                
                var  cost:intmax_t = intmax_t( image1!.size.width * image1!.size.height)
                
                self.imagesCache.setObject(image1!, forKey: urlString, cost: cost)
                if urlString.hasSuffix("gif"){
                    var data:NSData = NSData(contentsOfURL: NSURL(string: urlString)!)!
                    let Gif = GIFImage()
                    successed(image:Gif.animatedGIFWithData(data))
                    
                }else{
                    
                    successed(image: image1)
                }
                return
                
            }
            
            
        }
        // 0. 判断是否已经下载，如果已经下载
        if (self.operationsCache.objectForKey(urlString) != nil) {
            println("正在玩命下载中...稍安勿躁 \(self.operationsCache)")
            
            return
        }
        var downLoadOP = DownloadImageOperation.downloadImageOpeartionWithURLString(urlString, successed: { (image) -> Void in
            
            if (image != nil){
                var cost:intmax_t = intmax_t( image!.size.width * image!.size.height)
                self.imagesCache.totalCostLimit = 4 * 10
                
                self.imagesCache.setObject(image!, forKey: urlString, cost: cost)
                println(self.imagesCache.objectForKey(urlString))
            }
            // 下载完成之后，删除操作缓存
            self.operationsCache.removeObjectForKey(urlString)
            
            
            successed(image: image)
            
        })
        
        
        // 2. 将操作添加到操作缓存
        self.operationsCache.setValue(downLoadOP, forKey: urlString)
        println(self.operationsCache.objectForKey(urlString))
        // 3. 将下载操作添加到队列
        self.opQueue.addOperation(downLoadOP)
        
        
    }
    /// 全局队列，管理所有的下载操作(懒加载事先准备好)
    lazy var opQueue : NSOperationQueue = {
        var opQ = NSOperationQueue()
        opQ.maxConcurrentOperationCount = 2
        return opQ
        }()
    
    //取消指定URL的图像下载
    func cancelDownloadWithURLString(urlString:String){
            var op: AnyObject? = operationsCache.objectForKey(urlString)
    
            // 取消下载操作
            op!.cancel()
            // 3. 从缓冲池中删除操作
            self.operationsCache.removeObjectForKey(urlString)
        }
    
    // 内存清理工作
    func clearMemory(){
        self.operationsCache.removeAllObjects()
        self.imagesCache.removeAllObjects()
        self.opQueue.cancelAllOperations()
    }
    
}

