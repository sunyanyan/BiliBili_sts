//
//  TSUpdateFrameDelegate.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/26.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

@objc protocol TSUpdateFrameDelegate {
    @objc optional func tsUpdateFrameHeight(targetView:UIView, newHeight:CGFloat)
    @objc optional func tsUpdateHeight(targetView:UIView, addHeight:CGFloat)
}
