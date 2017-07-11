//
//  TSPlayerExtraInfoView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/7.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
import PageMenu

class TSPlayerExtraInfoView: UIView  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        addSubview(pageMenu.view)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pageMenu.view.frame = self.bounds
    }
    //MARK: property
    lazy var pageMenu:CAPSPageMenu = {
        let params:[CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(tsNavTintColor),
            .menuItemWidth(tsScreenWidth * 0.5),
            .centerMenuItems(true),
            .menuHeight(20),
            
            ]
        let pm:CAPSPageMenu = CAPSPageMenu.init(viewControllers: self.controllers, frame: self.bounds, pageMenuOptions: params)
        pm.moveToPage(1)
        return pm
    }()
    lazy var controllers: [UIViewController] = {
        var vcs = [UIViewController]()
        
        let item1 = TSPlayerIntroductionViewController()
        item1.view.backgroundColor = UIColor.white
        item1.title = "简介"
        vcs.append(item1)
        
        let item2 = TSPlayerCommentViewController()
        item2.view.backgroundColor = UIColor.blue
        item2.title = "评论"
        vcs.append(item2)

        
        return vcs
    }()
}



