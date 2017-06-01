
//
//  SwipePercentTransitionInteractionController.swift
//  SwipePresentTransition
//
//  Created by LiChunyu on 16/2/1.
//  Copyright © 2016年 leacode. All rights reserved.
//

import UIKit

class SwipePercentTransitionInteractionController: UIPercentDrivenInteractiveTransition {
    
//    @property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
//    @property (nonatomic, strong, readonly) UIScreenEdgePanGestureRecognizer *gestureRecognizer;
//    @property (nonatomic, readonly) UIRectEdge edge;
    
    var transitionContext: UIViewControllerContextTransitioning!
    var gestureRecognizer: UIScreenEdgePanGestureRecognizer!
    var edge: UIRectEdge!
    
    
    override init() {
        super.init()
    }
    
    convenience init(gestureRecognizer: UIScreenEdgePanGestureRecognizer, edgeForDragging edge: UIRectEdge) {
        self.init()
        
        self.gestureRecognizer = gestureRecognizer
        self.edge = edge
        self.gestureRecognizer.addTarget(self, action: #selector(SwipePercentTransitionInteractionController.gestureRecognizeDidUpdate(_:)))
        
    }
    
    deinit {
        gestureRecognizer.removeTarget(self, action: #selector(SwipePercentTransitionInteractionController.gestureRecognizeDidUpdate(_:)))
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        super.startInteractiveTransition(transitionContext)
    }
    
    func percentForGesture(_ gesture: UIScreenEdgePanGestureRecognizer) -> CGFloat {
        
        if self.transitionContext == nil {
            return 0
        }
        
        let transitionContainerView = self.transitionContext.containerView
        let locationInSourceView = gesture.location(in: transitionContainerView)
        
        let width = transitionContainerView.bounds.width
        let height = transitionContainerView.bounds.height
        
        if self.edge == UIRectEdge.right {
            return (width - locationInSourceView.x) / width
        } else if self.edge == UIRectEdge.left {
            return locationInSourceView.x / width
        } else if self.edge == UIRectEdge.bottom {
            return (height - locationInSourceView.y) / height
        } else if self.edge == UIRectEdge.top {
            return locationInSourceView.y / height
        } else {
            return 0
        }
        
        
    }
    
    func gestureRecognizeDidUpdate(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
    
        switch gestureRecognizer.state {
        case .began:
            break
        case .changed:
            self.update(percentForGesture(gestureRecognizer))
            break
        case .ended:
            if percentForGesture(gestureRecognizer) >= 0.5 {
                self.finish()
            } else {
                self.cancel()
            }
            break
        default:
            cancel()
            break
        }
        
    }
    
 
    

}
