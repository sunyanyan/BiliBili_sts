//
//  UIView+tsFrame.swift
//  BiliBili
//
//  Created by sts on 2017/5/10.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public var tsCenterX:CGFloat{
        return center.x
    }
    
    public var tsCenterY:CGFloat{
        return center.y
    }
    
    public var tsW:CGFloat{
        return frame.size.width
    }
    
    public var tsH:CGFloat{
        return frame.size.height
    }
}
