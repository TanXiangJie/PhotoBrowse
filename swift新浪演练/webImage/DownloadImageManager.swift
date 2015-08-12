//
//  DownloadImageManager.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/8/3.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit
class DownloadImageManager :NSObject {
    
    // GCD 单例模式
    class var sharedDownImageManager: DownloadImageManager {
        dispatch_once(&Inner.token)
            {
                Inner.instance = DownloadImageManager()
        }
        
        return Inner.instance!
    }
    private struct Inner {
        
        static var instance: DownloadImageManager?
        static var token: dispatch_once_t = 0
    }
    
    /// 下载操作缓冲池
    var operationsCache = NSMutableDictionary()
    ///   图像缓存池 － 因为可以从磁盘再次加载，因此可以用 NSCache 替代
    var imagesCache = NSCache()
    /// 全局队列，管理所有的下载操作(懒加载事先准备好)
    lazy var opQueue : NSOperationQueue = {
        var opQ = NSOperationQueue()
        opQ.maxConcurrentOperationCount = 3
        return opQ
        }()
    let Gif = GIFImage()
    // 下载指定的URL的图像
    func  downloadImageOpeartionWithURLString(imageURL:String,successed:(image:UIImage)->Void,failed:(error:String)->Void){
        
        // 判断内存中是否有图像
        var image = self.imagesCache.objectForKey(imageURL) as! UIImage?
        if image != nil  {
            
            if imageURL.hasSuffix("gif"){
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    var data = NSData(contentsOfFile: imageURL.md5.cacheDir())
                    successed(image:self.Gif.animatedGIFWithData(data))
                    return
                    
                })
            }
            println("从内存加载图像")
            // 直接回调，不再继续
            successed(image: image!)
            return
        }
        // 判断沙盒中是否有图像
        var imageCacheDir = UIImage(contentsOfFile: imageURL.md5.cacheDir()) as UIImage?
        
        if (imageCacheDir != nil)  {
            println("从磁盘加载")
            
            var cost = intmax_t(imageCacheDir!.size.width * imageCacheDir!.size.width)
            if imageURL.hasSuffix("gif"){
                /// 一定要异步在主线程更新不然等着卡爆吧
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    var data = NSData(contentsOfFile: imageURL.md5.cacheDir())
                    successed(image:self.Gif.animatedGIFWithData(data))
                    return
                    
                })
            }
            
            self.imagesCache.setObject(imageCacheDir!, forKey: imageURL, cost: cost)
            
            successed(image: imageCacheDir!)
            return
        }
        // 0. 判断是否已经下载，如果已经下载
        if (self.operationsCache.objectForKey(imageURL) != nil) {
            println("正在玩命下载中...稍安勿躁 \(self.operationsCache)")
            return
        }
        var downLoadOP = DownloadImageOperation.downloadImageOpeartionWithURLString(imageURL, successed: { (image) -> Void in
            
            if (image != nil){
                var cost:intmax_t = intmax_t( image!.size.width * image!.size.height)
                self.imagesCache.totalCostLimit = 4 * 10
                
                self.imagesCache.setObject(image!, forKey: imageURL, cost: cost)
            }
            // 下载完成之后，删除操作缓存
            self.operationsCache.removeObjectForKey(imageURL)
            
            println(image!)
            successed(image: image!)
            
            }, failed: failed)
        
        // 2. 将操作添加到操作缓存
        self.operationsCache.setValue(downLoadOP, forKey: imageURL)
        // 3. 将下载操作添加到队列
        self.opQueue.addOperation(downLoadOP)
        
        
    }
    
    //  取消指定URL的图像下载
    func cancelDownloadWithURLString(urlString:String){
        
        var op:DownloadImageOperation? = self.operationsCache.objectForKey(urlString)as? DownloadImageOperation
        if op == nil {
            return
        }
        // 取消下载操作
        op!.cancel()
        // 3. 从缓冲池中删除操作
        self.operationsCache.removeObjectForKey(urlString)
        println("取消下载操作")
    }
    // 需手动内存清理工作
    func clearMemory(){
        self.operationsCache.removeAllObjects()
        self.imagesCache.removeAllObjects()
        self.opQueue.cancelAllOperations()
    }
    
}