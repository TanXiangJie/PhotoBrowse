
//
//  photosViewController.swift
//  swift新浪演练
//
//  Created by 若水三千 on 15/7/27.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//
import UIKit
private var H = UIScreen.mainScreen().bounds.size.height
private var W =  UIScreen.mainScreen().bounds.size.width

private var transition:CATransition = CATransition()
/// 大图数组由外界传入
private var imageBig:[NSURL]?
class photoBrowser: UIViewController,UIScrollViewDelegate{
    /// 记录当前被点击的图片有外界传入
    var currentPhotoIndex:Int?
    /// 记录下载地址
    var urlstring : String?
    /// 动画的type
    let imageType = ["cube","moveIn","reveal","fade","pageCurl","pageUnCurl","suckEffect" ,"rippleEffect" ,"oglFlip"]
    /// 原始图片Frame
    var originality:CGRect?
    
    /// 原始图的父视图
    var superV:AnyObject?
    
    var originalImageV = UIImageView()
    
    /// 获得新的imageV
    var truncationimageV:UIImageView = UIImageView()
    
    var number = UILabel()
    let instanceDownload = DownloadImageManager()
    
    func showPhotos(imageV:UIImageView,images:[NSURL],currentIndex:Int){
        currentPhotoIndex = currentIndex
        imageBig = images
        originalImageV = imageV
        superV = imageV.superview
        originality = imageV.frame
        truncationimageV.image = imageV.image!
//      截图后获得新图片
//        let interception = InterceptionImage()
//       truncationimageV.image interception.setSrcImageView(imageV)
        
        // 进场
        approachImageV()
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarHidden = true
        self.scrollView.contentOffset.x = CGFloat(currentPhotoIndex!)*W
        let urlstring = "\(imageBig![currentPhotoIndex!])"
        ///  根据指定的 url 字符串，下载图像
        setImageWithURLString(urlstring,Number: currentPhotoIndex!)
    
        self.view.addSubview(scrollView)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
      // 下载周围其他图片
        for var i:Int = 0; i < imageBig?.count; i++ {
            var urlstring = "\(imageBig![i])"
            if i != currentPhotoIndex{
                setImageWithURLString(urlstring, Number: i)
            }
        }
    }
    /// 懒加载用来提前准备好一段代码
    private lazy var scrollView: UIScrollView = {
        var scrollV = UIScrollView(frame:CGRectMake(0,0,W,H))
        scrollV.userInteractionEnabled = true
        scrollV.pagingEnabled = true
        scrollV.delegate = self
        scrollV.showsHorizontalScrollIndicator = false
        let tapGesture = UITapGestureRecognizer(target: self, action: "didClick:")
        scrollV.addGestureRecognizer(tapGesture)
        scrollV.backgroundColor = UIColor.blackColor()
        return scrollV
        }()
    
    /// 选中照片索引 setter方法
    private var selectedIndex: Int?{
        didSet {
            
            if imageBig!.count>1{
                
                var countStr:NSString = NSString(format: "\(selectedIndex!)\\\(imageBig!.count)")
                
                number.frame = CGRect(x: (W-50)/2, y:20,width: 50,height: 25)
                number.backgroundColor = UIColor.whiteColor()
                number.layer.cornerRadius = 5
                number.clipsToBounds = true
                number.font = UIFont.systemFontOfSize(20)
                number.textAlignment = NSTextAlignment.Center
                number.tintColor = UIColor.whiteColor()
                number.text = countStr as String
                self.view.addSubview(number)
            }
        }
    }
    
    
    ///   根据指定的 url 字符串，下载图像
    func setImageWithURLString(urlStr:String,Number:Int){
        println(urlStr)
        
        if urlstring == urlStr {
            println("地址一致，等待下载结束")
            return
            
        }
        //            if (urlstring != nil) {
        //             do.cancelDownloadWithURLString(urlstring!)
        //
        //                }
        //
        urlstring = urlStr
        // 3.1 清空图像
        //self.image = nil
        
        instanceDownload.downloadImageOpeartionWithURLString(urlStr, successed: { (image) -> Void in
            var imageV:UIImageView = UIImageView()
            imageV.image = image
            imageV.userInteractionEnabled = true
            if imageV.image?.size != nil{
                
                self.truncationimageV.hidden = true
                var imageW:CGFloat = imageV.image!.size.width
                var imageH:CGFloat = imageV.image!.size.height
                var imageX = CGFloat(Number)*W
                // 如果图片的宽度大于屏幕的宽度
                if imageW > W {
                    imageH = imageH * W / imageW // 按比例缩放
                    imageW = W
                }else{
                    
                    imageX += (W - imageW)/2
                }
                var imageY = imageH > H ? 0 : (H - imageH)/2
                
                imageV.frame = CGRectMake(imageX,imageY,imageW ,imageH)
                var h = imageH > H ? imageH:0
                self.scrollView.contentSize = CGSizeMake(CGFloat(imageBig!.count)*W,h)
                // 临时存放图片对象
                self.scrollView.addSubview(imageV)
            }
            
        })
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var Index:Int = Int((scrollView.contentOffset.x + 0.5 * scrollView.frame.size.width)/scrollView.frame.size.width)
        selectedIndex = Index+1
        
        if currentPhotoIndex != selectedIndex{
            scrollView.backgroundColor = UIColor(red: rndColor(), green: rndColor(), blue: rndColor(), alpha: 1.0)
        }
        
        currentPhotoIndex = selectedIndex
    }
    
    func rndColor() -> CGFloat {
        return CGFloat(arc4random_uniform(256)) / 255
    }
    
    // 关闭按钮
    lazy var closeBtn: UIButton = {
        return self.createButton("关闭")
        }()
    
    // 保存按钮
    lazy var saveBtn: UIButton = {
        return self.createButton("保存")
        }()
    
    /// 创建按钮
    private func createButton(title: String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.brownColor()
        view.addSubview(btn)
        
        btn.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        return btn
    }
    
    
    func rndtype() -> Int{
        return Int(arc4random_uniform(9))
    }
    
    /// 设置按钮的布局
    func saveImaegeBtnAndCancelImageBtn(){
        closeBtn.addTarget(self, action: "cancleImage:", forControlEvents: UIControlEvents.TouchUpInside)
        saveBtn.addTarget(self, action: "saveImage:", forControlEvents: UIControlEvents.TouchUpInside)
        var cons = [AnyObject]()
        
        // 将生成的约束数组追加到临时数组中
        //设置按钮的间距
        var width:CGFloat = (W-(20*2+80*2))
        var interval = ["interval":width]
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[closeBtn(80)]-interval-[saveBtn(80)]", options: NSLayoutFormatOptions(0), metrics: interval, views: ["closeBtn": closeBtn, "saveBtn": saveBtn])
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:[closeBtn]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["closeBtn": closeBtn])
        
        
        cons.append(NSLayoutConstraint(item: saveBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: closeBtn, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
        
        view.addConstraints(cons)
        
    }
    
    //  异步将图片保存到相册
    func saveImage(btn:UIButton){
        // 成功
        SVProgressHUD.show()
        dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
            var image:AnyObject? = self.instanceDownload.imagesCache.objectForKey(self.urlstring!)
            if  image != nil {
                //            从缓存中读取并保存
                println("从缓存中读取并保存")
                println(self.urlstring!.cacheDir())
                
                UIImageWriteToSavedPhotosAlbum(image as!UIImage, self, Selector("image:didFinishSavingWithError:contextInfo:"), nil)
            }else {
                // 存内存中读取保存
                println("存内存中读取保存")
                image = UIImage(contentsOfFile: self.urlstring!.cacheDir())
                UIImageWriteToSavedPhotosAlbum(image as!UIImage, self, Selector("image:didFinishSavingWithError:contextInfo:"), nil)
            }
            
        })
        
    }
    
    func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
//        SVProgressHUD.dismiss()

        if didFinishSavingWithError != nil {
            println("错误")
            SVProgressHUD.showErrorWithStatus("保存失败")
            return
        }
        SVProgressHUD.showInfoWithStatus("保存成功")
    }
    
    //  点击关闭按钮让浏览器消失
    func cancleImage(btn:UIButton){
        removeImageV()
    }
    
    // 点击图片或SCR让浏览器消失
    func didClick(tap:UIGestureRecognizer){
        removeImageV()
        
    }
    // 出场
    func removeImageV(){
        self.view.backgroundColor = UIColor.clearColor()
        self.truncationimageV.hidden = false
        self.scrollView.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor.clearColor()
        self.scrollView.removeFromSuperview()
        self.saveBtn.removeFromSuperview()
        self.closeBtn.removeFromSuperview()
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            self.truncationimageV.frame = CGRect(origin:self.originalImageV.center, size:CGSizeMake(0, 0))
            self.truncationimageV.transform = CGAffineTransformMakeTranslation(0,0)
            self.superV!.addSubview(self.truncationimageV)
            }) { (_) -> Void in
                self.truncationimageV.removeFromSuperview()
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
                
        }
        
    }
    // 进场
    func approachImageV(){
        var Windows:UIWindow = UIApplication.sharedApplication().keyWindow!
        transition.type = imageType[rndtype()]
        transition.subtype  = kCATransitionFromLeft;
        transition.duration = 0.5;
        Windows.layer.addAnimation(transition, forKey: nil)
        
        UIView.animateWithDuration(2.0, delay: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.TransitionCurlUp, animations: {
            self.truncationimageV.frame = self.view.frame
            self.truncationimageV.contentMode = UIViewContentMode.ScaleAspectFit
            self.truncationimageV.userInteractionEnabled = false
            self.truncationimageV.backgroundColor = UIColor.clearColor()
            self.view.addSubview(self.truncationimageV)
            Windows.addSubview(self.view)
            
            }) { _ in
                
        self.selectedIndex = self.currentPhotoIndex!+1
        Windows.rootViewController?.addChildViewController(self)
        self.saveImaegeBtnAndCancelImageBtn()
                
        }
    }
    
    
    /// 清理内存缓存
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
        instanceDownload.clearMemory()
    }
}




