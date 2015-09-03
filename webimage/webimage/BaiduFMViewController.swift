//
//  BaiduFMViewController.swift
//  河北人民广播电台
//
//  Created by 若水三千 on 15/8/11.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//
//
import UIKit
class BaiduFMViewController: UICollectionViewController {
        private let reuseIdentifier = "Cell"
        var listArray = [AnyObject]()
        let FlowLayout = UICollectionViewFlowLayout()
        
        init(){
            FlowLayout.minimumInteritemSpacing = 5
            FlowLayout.minimumLineSpacing = 5
            FlowLayout.itemSize = CGSizeMake((UIScreen.mainScreen().bounds.size.width-20)/3, 150)
            FlowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
            FlowLayout.sectionInset = UIEdgeInsetsMake(0,5, 5, 5)
            super.init(collectionViewLayout: FlowLayout)
        }
    
    required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //
        override func viewDidLoad() {
            super.viewDidLoad()
            self.collectionView!.registerClass(BaiduFMcontrollerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            self.collectionView?.backgroundColor = UIColor.purpleColor()
            
            self.title = "百度FM"
            getSongList()
        }

    //获取歌曲分类列表
    func getSongList(){
      netWorkManager.requestJSON(Method.POST, URLString: http_channel_list_url, parameters: nil) { (JSON) -> () in
            for dict in JSON!.objectForKey("content") as! [AnyObject]{
            self.listArray.append(BaiduFMmodel.objectWithKeyValues(dict as! [String : AnyObject]))
            }
        
            self.collectionView?.reloadData()
            
        }
        
}
    
        // MARK: UICollectionViewDataSource
    
        override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
            
            return 1
        }
        
        
        override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            //#warning Incomplete method implementation -- Return the number of items in the section
            return listArray.count ?? 0
        }
        
        override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BaiduFMcontrollerCell
            cell.backgroundColor = UIColor.whiteColor()
            let model = listArray[indexPath.item] as! BaiduFMmodel
            cell.model = model
            return cell
        }
    override func didReceiveMemoryWarning() {
            
            super.didReceiveMemoryWarning()
            DownloadImageManager.sharedDownImageManager.clearMemory()
        }
    
    deinit{
        
        println("我走了")
     }
    
   
}

class BaiduFMcontrollerCell: UICollectionViewCell {
    
    var channelName:UILabel?
    var pic:UIImageView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        channelName = UILabel(frame: CGRectMake(0, self.contentView.frame.height-35, self.contentView.frame.width, 35))
        channelName?.font = UIFont.systemFontOfSize(13)
        channelName?.textColor = UIColor.orangeColor()
        channelName?.numberOfLines = 0
        channelName?.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(channelName!)
        pic = UIImageView(frame: CGRectMake(0, 0, self.contentView.frame.width, self.contentView.frame.height*0.8))
        self.contentView.addSubview(pic!)
    }

    var model:BaiduFMmodel?{
        didSet{
        // 类目
       channelName?.text = model?.title
       pic!.setImageWithURLString(model!.pic_w300!)
        }
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}