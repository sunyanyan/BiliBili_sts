//
//  TSTransitionDelegate.swift
//  BiliBili_sts
//
//  Created by sts on 2017/6/1.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

/// 使 present/dismiss 动画类似于 push/pop
class TSSwipeTransitionDelegate: NSObject,UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        TSLog(message: "")
        return TSSwipePresentTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        TSLog(message: "")
        return TSSwipeDismissTransition()
    }
}

class TSSwipePresentTransition:NSObject,UIViewControllerAnimatedTransitioning{
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return 0.5
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        let toVC = transitionContext.viewController(forKey: .to)
        
        let finalFrame = transitionContext.finalFrame(for: toVC!)
        //初始位置在屏幕右侧
        toVC?.view.frame = finalFrame.offsetBy(dx: tsScreenWidth, dy: 0)
        
        let containerView = transitionContext.containerView
        containerView.addSubview((toVC?.view)!)
        
        //开始动画
        let duration = self.transitionDuration(using: transitionContext)        
        UIView.animate(withDuration: duration, animations: {
            toVC?.view.frame = finalFrame
        }) { (bool) in
            transitionContext.completeTransition(true)
        }
        
    }
}

class TSSwipeDismissTransition:NSObject,UIViewControllerAnimatedTransitioning{
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return 0.5
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        let toVC = transitionContext.viewController(forKey: .to)
        let fromVC = transitionContext.viewController(forKey: .from)
        
        let initFrame = transitionContext.initialFrame(for: fromVC!)
        //最后移到屏幕右侧
        let finalFrame = initFrame.offsetBy(dx: tsScreenWidth, dy: 0)
        
        let containerView = transitionContext.containerView
        containerView.addSubview((toVC?.view)!)
        containerView.sendSubview(toBack: (toVC?.view)!)
        
        //开始动画
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            
            fromVC?.view.frame = finalFrame
            
        }) { (bool) in
            
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
            
        }
    }
}
