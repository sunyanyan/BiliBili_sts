//
//  TSUpdateFrameDelegate.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/26.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

protocol TSUpdateFrameDelegate:NSObjectProtocol {
    func tsUpdateFrameHeight(targetView:UIView, newHeight:CGFloat)
}
