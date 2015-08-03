//
//  AddFriendsViewController.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/16.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

let reuseIdentifier1 = "Cell1"

class AddFriendsViewController: UICollectionViewController {
   
    init(){
        var FlowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        FlowLayout.minimumInteritemSpacing = 0
        FlowLayout.minimumLineSpacing = 0
        FlowLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 80)
        FlowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        super.init(collectionViewLayout: FlowLayout)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.groupTableViewBackgroundColor()

        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 10
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var lable : UILabel?
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier1, forIndexPath:indexPath) as! UICollectionViewCell
        if indexPath.row == 0{
            lable = UILabel()
            cell.bounds.size.height = 30.0
            lable?.bounds = cell.bounds
            cell.addSubview(lable!)
        }else{
            cell.bounds.size.height = 129.0

        }
        cell.backgroundColor = UIColor.whiteColor()

        return cell
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
