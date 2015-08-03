//
//  NewFeatureViewController.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/16.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
var page : UIPageControl?
let curPage : Int = 4;
class NewFeatureViewController: UICollectionViewController,UIScrollViewDelegate {


    init(){
        var FlowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        FlowLayout.minimumInteritemSpacing = 0
        FlowLayout.minimumLineSpacing = 0
        FlowLayout.itemSize = UIScreen.mainScreen().bounds.size
        FlowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        FlowLayout.sectionInset = UIEdgeInsetsZero
    
        super.init(collectionViewLayout: FlowLayout)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(animated: Bool) {
     super.viewWillAppear(animated)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.pagingEnabled = true
        self.collectionView!.bounces = false
        self.collectionView?.showsHorizontalScrollIndicator = false
        
        page =  UIPageControl()
        page?.frame = CGRectMake((self.view.frame.width-60)/2, self.view.frame.height*0.98, 60, 15)
        page!.currentPageIndicatorTintColor = UIColor.redColor()
        page!.pageIndicatorTintColor = UIColor.grayColor()
        self.view.addSubview(page!)
        page!.numberOfPages = curPage;
        
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var pages: CGFloat?
      pages = (scrollView.contentOffset.x + 0.5 * scrollView.frame.size.width)/scrollView.frame.size.width;
        
      page!.currentPage = Int(pages!);
  
    }
    // MARK: UICollectionViewDataSource
    /// 图片总数
    let imageCount = 4

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewFeatureCell
    
      cell.imageIndex = indexPath.item
        return cell
    }
    

    class NewFeatureCell:UICollectionViewCell {
        
        var iconImage: UIImageView?
        var startButton:UIButton?
        // 设置图像
        let inch3_5 :CGFloat = UIScreen.mainScreen().bounds.size.height

        var imageIndex: Int = 0 {
            didSet {
               if inch3_5 != 480{
                    iconImage!.image = UIImage(named: "new_feature_\(imageIndex+1)-568h")
                }else{

                iconImage!.image = UIImage(named: "new_feature_\(imageIndex + 1)")
               }
                
                if page?.currentPage == 2{
                    startButton!.hidden = false

                }else{
                // 隐藏启动按钮
                startButton!.hidden = true
                }
            }
        }

        override init(frame: CGRect) {
            super.init(frame:frame)
            iconImage = UIImageView()
            iconImage!.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)
            startButton = UIButton()
            
            startButton!.frame = CGRectMake((self.frame.width-100)/2, self.frame.height*0.67, 100, 35)
            startButton?.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted);
            startButton?.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal);

            startButton?.setTitle("开始分享", forState: UIControlState.Normal)
            startButton?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            startButton?.addTarget(self, action: Selector("didClickStartBtn:"), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(iconImage!)
            self.addSubview(startButton!)

        }
   
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func didClickStartBtn(btn:UIButton){
    NSNotificationCenter.defaultCenter().postNotificationName("swichRootVC", object: nil)
            
        }
  
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
