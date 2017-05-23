//
//  UIImageView+tsExtension.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/23.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    class func refreshLogoGif() -> UIImageView {
        let gifImage = UIImageView()
        gifImage.image = UIImage.init(named: "refresh_logo_1")
        var gifImageArray = [UIImage]()
        for i in 1...4 {
            let image = UIImage(named: "refresh_logo_\(i)")
            gifImageArray.append(image!)
        }
        gifImage.contentMode = UIViewContentMode.center
        gifImage.animationImages = gifImageArray
        gifImage.animationDuration = 0.3
        gifImage.animationRepeatCount = 0
        return gifImage
    }
    
}
