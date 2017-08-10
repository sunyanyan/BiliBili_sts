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

extension String {
//usage:
//    let str = "Hello, playground, playground, playground"
//    str.index(of: "play")      // 7
//    str.endIndex(of: "play")   // 11
//    str.indexes(of: "play")    // [7, 19, 31]
//    str.ranges(of: "play")     // [{lowerBound 7, upperBound 11}, {lowerBound 19, upperBound 23}, {lowerBound 31, upperBound 35}]

    func tsIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func tsEndIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func tsIndexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.upperBound
        }
        return result
    }
    func tsRanges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.upperBound
        }
        return result
    }
}
