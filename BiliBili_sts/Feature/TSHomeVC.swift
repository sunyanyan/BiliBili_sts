//
//  TSHomeVC.swift
//  BiliBili
//
//  Created by sts on 2017/5/11.
//  Copyright © 2017年 sts. All rights reserved.
//

import UIKit
import PageMenu

class TSHomeVC:UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(statusBarView)
        view.addSubview(pageMenu.view)
        
    }
    
    //MARK:- property
    lazy var controllers: [UIViewController] = {
        var vcs = [UIViewController]()
        
        let item1 = UIViewController()
        item1.view.backgroundColor = UIColor.red
        item1.title = "直播"
        vcs.append(item1)
        
        let item2 = TSRecommendVC()
        item2.view.backgroundColor = UIColor.blue
        item2.title = "推荐"
        vcs.append(item2)
        
        let item3 = UIViewController()
        item3.view.backgroundColor = UIColor.green
        item3.title = "番剧"
        vcs.append(item3)
        
        return vcs
    }()
    
    //MARK: - UI
    
    lazy var statusBarView:UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tsScreenWidth, height: tsStatusBarHeight))    
        v.backgroundColor = tsNavTintColor
        return v
    }()
    
    lazy var pageMenu:CAPSPageMenu = {
        let h = tsScreenHeight - tsTabbarHeight - tsStatusBarHeight
        let params:[CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(tsNavTintColor),
            .menuItemWidth(40),
            .centerMenuItems(true),
            .menuHeight(tsPageMenuHeight),
            
        ]
        let rect = CGRect.init(x: 0, y: tsStatusBarHeight, width: tsScreenWidth, height: h)
        let pm:CAPSPageMenu = CAPSPageMenu.init(viewControllers: self.controllers, frame: rect, pageMenuOptions: params)
        pm.moveToPage(1)
        return pm
    }()
    
    
}
