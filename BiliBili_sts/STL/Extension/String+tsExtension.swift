//
//  String+tsExtension.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/12.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

extension String{
    // 获取字符串的高度
    func tsHeightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
    
    // 获取字符串的宽度
    func tsWidthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.width
    }
    
    func tsFullUrlString()->String{
        let urlStr = "http:" + self 
        return urlStr
    }
    
    static func tsIsEmpty(string:String?) -> Bool {
        if let str  = string {
            if str.lengthOfBytes(using: .utf8) > 0 {
                return false 
            }
        }
        return true
    }
}
