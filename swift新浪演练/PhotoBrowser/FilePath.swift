//
//  filePath.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/8/3.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit
extension String{
    func cacheDir()->String{
        let cacheDirPath = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask,true).last as!String)
        
        return cacheDirPath.stringByAppendingPathComponent(self.lastPathComponent)
    }
    
    func docDir()->String{
        let doc = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last as! String
        return doc.stringByAppendingPathComponent(self.lastPathComponent)
    }
    
    func tmpDir()->String{
        
        return NSTemporaryDirectory().stringByAppendingPathComponent(self.lastPathComponent)
    }
    
}

