//
//  Common+tsExtension.swift
//  BiliBili_sts
//
//  Created by sts on 2017/9/6.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation

extension Array {
    
    func tsRandom4Arr() -> [Any]? {
        if self.count < 4 {
            return nil
        }
        else if self.count == 4 {
            return self
        }
        
        let indexes = TSCommon.random4ToIndex(index: self.count)
        var ranArr = [Any]()
        for index in indexes {
            if let item = TSCommon.modelAt(index: index , models: self){
                ranArr.append(item)
            }
        }
        return ranArr
    }
    
}
