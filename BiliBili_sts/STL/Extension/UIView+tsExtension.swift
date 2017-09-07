//
//  UIView+tsFrame.swift
//  BiliBili
//
//  Created by sts on 2017/5/10.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Frame
extension UIView {
    
    public var tsCenterX:CGFloat{
        return center.x
    }
    
    public var tsCenterY:CGFloat{
        return center.y
    }
    
    public var tsX:CGFloat{
        return frame.origin.x
    }
    
    public var tsY:CGFloat{
        return frame.origin.y
    }
    
    public var tsBottomY:CGFloat{
        return frame.origin.y + tsH
    }
    
    public var tsW:CGFloat{
        return frame.size.width
    }
    
    public var tsH:CGFloat{
        return frame.size.height
    }
}

extension CALayer {
    
    public var tsCenter:CGPoint{
        return CGPoint.init(x:  tsCenterX, y: tsCenterY)
    }
    
    public var tsCenterX:CGFloat{
        return frame.origin.x + frame.size.width / 2
    }
    
    public var tsCenterY:CGFloat{
        return frame.origin.y + frame.size.height / 2
    }

    public var tsX:CGFloat{
        return frame.origin.x
    }
    
    public var tsY:CGFloat{
        return frame.origin.y
    }
    
    public var tsBottomY:CGFloat{
        return frame.origin.y + tsH
    }
    
    public var tsW:CGFloat{
        return frame.size.width
    }
    
    public var tsH:CGFloat{
        return frame.size.height
    }
}

// MARK: - Animate
extension UIView {

    /// 0.8秒里 旋转半圈，先变大再变回原大小
    func tsAnimateStarGrace() {
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: 0), animations: { [unowned self] in
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4, animations: {
                self.transform = self.transform.rotated(by: CGFloat.pi / 2)
                self.transform = self.transform.scaledBy(x: 1.2, y: 1.2)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4, animations: {
                self.transform = self.transform.rotated(by: CGFloat.pi / 2)
                self.transform = self.transform.scaledBy(x: 5/6, y: 5/6)
            })
        }, completion: nil)
    }
    
    /// 1秒里 将frame变大到接近全屏的大小
    ///
    /// - Parameter completion: <#completion description#>
    func tsAnimateBigger(completion:@escaping()->()){
        UIView.animate(withDuration: 1, animations: { [unowned self] in
            let scaledX:CGFloat = (tsScreenWidth - 60) / self.tsW
            let scaledY:CGFloat = (tsScreenHeight - 60) / self.tsH
            self.transform = self.transform.scaledBy(x: scaledX, y: scaledY)
        }) { (bool) in
            completion()
        }
    }
}
