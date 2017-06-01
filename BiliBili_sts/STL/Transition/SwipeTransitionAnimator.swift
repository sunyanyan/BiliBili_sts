//
//  SwipeTransitionAnimator.swift
//  SwipePresentTransition
//
//  Created by LiChunyu on 16/1/31.
//  Copyright © 2016年 leacode. All rights reserved.
//

import UIKit

class SwipeTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var targetEdge: UIRectEdge!
    
    override init() {
        super.init()
    }

    convenience init(targetEdge: UIRectEdge) {
        self.init()
        self.targetEdge = targetEdge
    }
    

    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let containerView = transitionContext.containerView
        // For a Presentation:
        //      fromView = The presenting view.
        //      toView   = The presented view.
        // For a Dismissal:
        //      fromView = The presented view.
        //      toView   = The presenting view.
        var fromView: UIView! = nil
        var toView: UIView! = nil
        
        // In iOS 8, the viewForKey: method was introduced to get views that the
        // animator manipulates.  This method should be preferred over accessing
        // the view of the fromViewController/toViewController directly.
        // It may return nil whenever the animator should not touch the view
        // (based on the presentation style of the incoming view controller).
        // It may also return a different view for the animator to animate.
        //
        // Imagine that you are implementing a presentation similar to form sheet.
        // In this case you would want to add some shadow or decoration around the
        // presented view controller's view. The animator will animate that
        // decoration instead and the presented view controller's view will be a
        // child of the decoration.
        if #available(iOS 8.0, *) {
            fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        } else {
            fromView = fromVC!.view
            toView = toVC!.view
        }
        
        // If this is a presentation, toViewController corresponds to the presented
        // view controller and its presentingViewController will be
        // fromViewController.  Otherwise, this is a dismissal.
        let isPresenting = (toVC?.presentingViewController == fromVC)
        
        let fromFrame = transitionContext.initialFrame(for: fromVC!)
        let toFrame = transitionContext.finalFrame(for: toVC!)
        
        // Based on our configured targetEdge, derive a normalized vector that will
        // be used to offset the frame of the presented view controller.
        let offset: CGVector!
        if targetEdge == UIRectEdge.top {
            offset = CGVector(dx: 0.0, dy: 1.0)
        } else if targetEdge == UIRectEdge.bottom {
            offset = CGVector(dx: 0.0, dy: -1.0)
        } else if targetEdge == UIRectEdge.left {
            offset = CGVector(dx: 1.0, dy: 0.0)
        } else if targetEdge == UIRectEdge.right {
            offset = CGVector(dx: -1.0, dy: 0.0)
        } else {
            offset = CGVector(dx: 0.0, dy: 0.0)
        }
        
        if isPresenting {
            fromView.frame = fromFrame
            
            let dx = toFrame.size.width * offset.dx * -1
            let dy = toFrame.size.height * offset.dy * -1
            
            toView.frame = toFrame.offsetBy(dx: dx, dy: dy)
        } else {
            fromView.frame = fromFrame
            toView.frame = toFrame
        }
        
        // We are responsible for adding the incoming view to the containerView
        // for the presentation.
        
        if isPresenting {
            containerView.addSubview(toView)
        } else {
            // -addSubview places its argument at the front of the subview stack.
            // For a dismissal animation we want the fromView to slide away,
            // revealing the toView.  Thus we must place toView under the fromView.
            containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: transitionDuration, animations: { () -> Void in
            
            if isPresenting {
                toView.frame = toFrame
            } else {
                fromView.frame = fromFrame.offsetBy(dx: fromFrame.size.width * offset.dx, dy: fromFrame.size.height * offset.dy)
            }
            
            }, completion: { (finished:Bool) -> Void in
                let wasCancelled = transitionContext.transitionWasCancelled
                if wasCancelled {
                    toView.removeFromSuperview()
                }
                transitionContext.completeTransition(!wasCancelled)
        }) 
        
    }
    

    
}
