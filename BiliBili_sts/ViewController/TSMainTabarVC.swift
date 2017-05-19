//
//  TSMainTabarVC.swift
//  BiliBili
//
//  Created by sts on 2017/5/11.
//  Copyright © 2017年 sts. All rights reserved.
//

import UIKit

class TSMainTabbarVC: UITabBarController,UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.white
        
        for (index,vc) in controllers.enumerated() {
            let item = tabbarItems[index]
            vc.tabBarItem.image = item.image.withRenderingMode(.alwaysOriginal)
            vc.tabBarItem.selectedImage = item.selectedImage.withRenderingMode(.alwaysOriginal)
            vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
            self.addChildViewController(vc)
        }
    }
    
    //MARK:- property
    lazy var controllers: [UIViewController] = {
        var vcs = [UIViewController]()
        
        let item1 = TSHomeVC()
        vcs.append(item1)
        
        let item2 = UINavigationController(rootViewController: UIViewController())
        vcs.append(item2)
        
        let item3 = UINavigationController(rootViewController: UIViewController())
        vcs.append(item3)
        
        let item4 = UINavigationController(rootViewController: UIViewController())
        vcs.append(item4)
        
        let item5 = UINavigationController(rootViewController: UIViewController())
        vcs.append(item5)
        
        return vcs
    }()
    
    lazy var tabbarItems :[tabbarItem] = {
        var items = [tabbarItem]()
        
        let item_home = tabbarItem(title:"首页", image:#imageLiteral(resourceName: "home_tab"), selectedImage:#imageLiteral(resourceName: "home_tab_s"))
        let item_category = tabbarItem(title:"分区", image:#imageLiteral(resourceName: "category_tab"), selectedImage:#imageLiteral(resourceName: "category_tab_s"))
        let item_pegasus_attention = tabbarItem(title:"动态", image:#imageLiteral(resourceName: "pegasus_attention_tab"), selectedImage:#imageLiteral(resourceName: "pegasus_attention_tab_s"))
        let item_discory = tabbarItem(title:"发现", image:#imageLiteral(resourceName: "discovery_tab") , selectedImage:#imageLiteral(resourceName: "discovery_tab_s"))
        let item_mine = tabbarItem(title:"我的", image:#imageLiteral(resourceName: "home_mine_tab"), selectedImage:#imageLiteral(resourceName: "home_mine_tab_s"))
        items.append(item_home)
        items.append(item_category)
        items.append(item_pegasus_attention)
        items.append(item_discory)
        items.append(item_mine)
        return items
    }()
    
    struct tabbarItem {
        var title:String
        var image:UIImage
        var selectedImage:UIImage
    }

    
}
