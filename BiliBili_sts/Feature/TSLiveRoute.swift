//
//  TSLiveRoute.swift
//  BiliBili_sts
//
//  Created by sts on 2017/9/14.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

extension TSLiveVC{
    private static var liveVCtransitioningDelegateAssociationKey:UInt8 = 0
    var homeVCtransitioningDelegate:UIViewControllerTransitioningDelegate?{
        get{
            return  objc_getAssociatedObject(self, &TSLiveVC.liveVCtransitioningDelegateAssociationKey) as? UIViewControllerTransitioningDelegate
        }
        set(newValue){
            objc_setAssociatedObject(self, &TSLiveVC.liveVCtransitioningDelegateAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// 跳转到播放页
    func presentFakeLivePlayVC(){
        let homeVc:TSHomeVC? = self.homeVC()
        if homeVc == nil {
            TSLog(message: "homeVc is nil  ")
            return
        }
        
        let playVc = TSLivePlayVC()

        let nav = UINavigationController.init(rootViewController: playVc)
        let delegate = TSSwipeTransitionDelegate()
        self.homeVCtransitioningDelegate = delegate
        nav.transitioningDelegate = delegate
        homeVc!.present(nav, animated: true, completion: nil)
        
    }
    
    /// 跳到直播录制页
    func presentLiveRecordVC(){
        let homeVc:TSHomeVC? = self.homeVC()
        if homeVc == nil {
            TSLog(message: "homeVc is nil  ")
            return
        }
        
        let playVc = TSLiveRecordVC()

        let delegate = TSSwipeTransitionDelegate()
        self.homeVCtransitioningDelegate = delegate
        playVc.transitioningDelegate = delegate
        homeVc!.present(playVc, animated: true, completion: nil)
    }
    
    func homeVC()->TSHomeVC?{
        //当前ViewController相对于Home的位置
        let homeVC:TSHomeVC? = self.parent as? TSHomeVC
        return homeVC
    }
}
