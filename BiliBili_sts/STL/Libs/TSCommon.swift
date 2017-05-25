//
//  TSCommon.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/25.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation

class TSCommon {
    
    //MARK: - 随机数
    
    class func randomInRange(range: Range<Int>) -> Int {
        let count = UInt32(range.upperBound - range.lowerBound)
        return  Int(arc4random_uniform(count)) + range.lowerBound
    }
    
    class  func random4InRange(range: Range<Int>) -> [Int] {
        
        var random4 = [Int]()
        
        while random4.count < 4 {
            let i = randomInRange(range: range)
            if !random4.contains(i) {
                random4.append(i)
            }
        }
        
        return random4
    }
    
    /// 取 0..<index 四个不重复的随机数
    ///
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    class func random4ToIndex(index: Int) -> [Int] {
        
        let range  = Range.init(uncheckedBounds: (lower: 0, upper: index))
        
        return random4InRange(range: range)
    }
    
}
