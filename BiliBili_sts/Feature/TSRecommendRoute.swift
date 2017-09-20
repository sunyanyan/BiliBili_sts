//
//  TSRoute.swift
//  BiliBili_sts
//
//  Created by sts on 2017/6/1.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit



extension TSRecommendVC{
    
    
    
    private static var homeVCtransitioningDelegateAssociationKey:UInt8 = 0
    var homeVCtransitioningDelegate:UIViewControllerTransitioningDelegate?{
        get{
            return  objc_getAssociatedObject(self, &TSRecommendVC.homeVCtransitioningDelegateAssociationKey) as? UIViewControllerTransitioningDelegate
        }
        set(newValue){
            objc_setAssociatedObject(self, &TSRecommendVC.homeVCtransitioningDelegateAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// 跳转到网页展示
    ///
    /// - Parameter url: <#url description#>
    func presentWebVC(url:String) {
        
        let homeVc:TSHomeVC? = self.homeVC()
        if homeVc == nil {
            TSLog(message: "homeVc is nil  ")
            return
        }
        
        let webvc = TSWebVC()
        webvc.webUrlStr = url
        let nav = UINavigationController.init(rootViewController: webvc)
        let delegate = TSSwipeTransitionDelegate()
        self.homeVCtransitioningDelegate = delegate
        nav.transitioningDelegate = delegate
        
        homeVc!.present(nav, animated: true, completion: nil)
    }
    
    /// 跳转到播放页
    ///
    /// - Parameter aid: <#aid description#>
    func presentPlayVC(aid:String){
        let homeVc:TSHomeVC? = self.homeVC()
        if homeVc == nil {
            TSLog(message: "homeVc is nil  ")
            return
        }
        
        let playVc = TSRecommendPlayVC()
        playVc.aid = aid
        let nav = UINavigationController.init(rootViewController: playVc)
        let delegate = TSSwipeTransitionDelegate()
        self.homeVCtransitioningDelegate = delegate
        nav.transitioningDelegate = delegate
        homeVc!.present(nav, animated: true, completion: nil)

    }
    
    func homeVC()->TSHomeVC?{
        //当前ViewController相对于Home的位置
        let homeVC:TSHomeVC? = self.parent as? TSHomeVC
        return homeVC
    }
}




