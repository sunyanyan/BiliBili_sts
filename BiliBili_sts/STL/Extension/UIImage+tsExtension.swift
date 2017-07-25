//
//  UIImage+tsExtension.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/22.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    /**
     获取图片中的像素颜色值
     
     - parameter pos: 图片中的位置
     
     - returns: 颜色值
     */
    func getPixelColor(pos:CGPoint)->(alpha: CGFloat, red: CGFloat, green: CGFloat,blue:CGFloat){
        let pixelData=self.cgImage!.dataProvider!.data
        let data:UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return (a,r,g,b)
    }
}
