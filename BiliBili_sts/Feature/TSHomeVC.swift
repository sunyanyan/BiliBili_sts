//
//  TSHomeVC.swift
//  BiliBili
//
//  Created by sts on 2017/5/11.
//  Copyright © 2017年 sts. All rights reserved.
//

import UIKit
//import PageMenu

class TSHomeVC:TSViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    //MARK:- property
    lazy var controllers: [UIViewController] = {
        var vcs = [UIViewController]()
        
        let item1 = TSLiveVC()
        vcs.append(item1)
        
        let item2 = TSRecommendVC()
        vcs.append(item2)
        
        let item3 = UIViewController()
        item3.view.backgroundColor = UIColor.blue
        vcs.append(item3)
        
        return vcs
    }()

    lazy var statusBarView:UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tsScreenWidth, height: tsStatusBarHeight))
        v.backgroundColor = tsNavTintColor
        return v
    }()
    
    lazy var slideMenu: TSSlideMenuView = {
        // 1.frame
        let width:CGFloat = 150
        let height:CGFloat = tsSlideMenuViewHeight
        let x = (tsScreenWidth - width)/2
        let y = tsStatusBarHeight
        let rect = CGRect(x: x, y: y, width: width, height: height)
        
        // 2.平常的颜色
        let normalColor = TSSlideMenuView.slideMenuTitleColor(red: 230, green: 230, blue: 230)
        
        // 3.显示的颜色
        let hightLightColor = TSSlideMenuView.slideMenuTitleColor(red: 255, green: 255, blue: 255)
        
        // 4.生成slidemenu
        let menu = TSSlideMenuView(frame: rect, titles: ["直播","推荐","番剧"], padding: 15, normalColr: normalColor, hightLightColor: hightLightColor, font: 16, sliderColor: UIColor.white, onlyHorizon: false, scrollView: self.contentScrollView, autoPadding: true)
        
        return menu
    }()
    
    lazy var contentScrollView: UIScrollView = {
        
        let y :CGFloat = tsSlideMenuViewHeight+tsStatusBarHeight
        let h :CGFloat = tsScreenHeight - y - tsTabbarHeight
        let w :CGFloat = self.view.tsW
        let frame = CGRect.init(x: 0, y: y, width: w, height: h)
        let v = UIScrollView.init(frame: frame)
        v.contentSize = CGSize(width: w*3, height: h)
        v.isPagingEnabled = true
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        return v
    }()
    
    
}

// MARK: - setupUI
extension TSHomeVC{
    func setupUI(){
    
        self.view.backgroundColor = tsNavTintColor
        view.addSubview(statusBarView)
        view.addSubview(slideMenu)
        view.addSubview(contentScrollView)
        addChildVCs()
        moveToPage(index: 1)
    }
    
    func addChildVCs(){
        var index:CGFloat  = 0.0
        for vc  in controllers {
            self.addChildViewController(vc)
            contentScrollView.addSubview(vc.view)
            let x = contentScrollView.tsW * index
            let y:CGFloat = 0.0
            let w = contentScrollView.tsW
            let h  = contentScrollView.tsH
            vc.view.frame = CGRect.init(x: x, y: y, width: w, height: h)
            index = index + 1
        }
    }
}

// MARK: - event
extension TSHomeVC{
    
    /// 移到scroll 的index页数
    ///
    /// - Parameter index: <#index description#>
    func moveToPage(index:Int){
        if index > 0 && index < controllers.count {
            let x = contentScrollView.tsW * CGFloat.init(index)
            let point = CGPoint.init(x: x, y: 0)
            contentScrollView.setContentOffset(point, animated: true)
        }
    }
}

