//
//  HomeViewController.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/12.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit
/// 加载首页的 URL 地址
private let WB_HOME_LINE_URL = "https://api.weibo.com/2/statuses/friends_timeline.json"
/// 加载未读数量 URL 地址
private let WB_LOAD_UNREAD_URL = "https://rm.api.weibo.com/2/remind/unread_count.json"
var array1 = NSMutableArray()
private let identifier = "reuseIdentifier"

class HomeViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(HomeTableViewCell.self, forCellReuseIdentifier:identifier)
        self.view.backgroundColor = UIColor.whiteColor()
        let tabBar = MainTabBar()
        self.navigationItem.leftBarButtonItem = tabBar.addLeftOrRightBtn(nil, Leftimage:"navigationbar_friendsearch", targer: self, action: Selector("puchVC"))
            loadData()
        
    
    }
    
    func loadData(){
        
        var parames = ["access_token":sharedUserAccount!.access_token,"since_id":"0","page":"1","count":"50"]
        
        NetWorkTools.requestJSON(Method.GET, URLString: WB_HOME_LINE_URL, parameters: parames) { (JSON) -> () in
            
            if JSON != nil {
                //        取出statuses key 对应的数组
                if (JSON!.objectForKey("statuses") != nil){
                    // 实例化一个可变的数组
                    var array = NSMutableArray()
                    for dict in JSON!.objectForKey("statuses") as! [AnyObject]{
                        //  将字典转换成模型
                        var status:StatusResult =  StatusResult.objectWithKeyValues(dict as! NSDictionary)
                        //   MVVV模式设计 将视图模型存放起来
                        var homeVC = HomeVM()
                        homeVC.status = status
                        array.addObject(homeVC)
                        
                    }
                    array1.addObjectsFromArray(array as [AnyObject])
                    self.tableView.reloadData()
                    
                }
            }
            
        }

    
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array1.count
    }
    
    //  cellHeight
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var homeV:HomeVM = array1[indexPath.row] as! HomeVM

        return homeV.cellHeight!
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
         var cell: HomeTableViewCell?  = HomeTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier)
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        cell!.backgroundColor = UIColor.groupTableViewBackgroundColor()
        cell!.home = array1[indexPath.row] as? HomeVM
        return cell!
    }
    
    func puchVC(){
        let addFrends = AddFriendsViewController()
        self.navigationController?.pushViewController(addFrends, animated: true)
        
    }
}
 