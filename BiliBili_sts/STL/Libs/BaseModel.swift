//
//  BaseModel.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/20.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import HandyJSON

class TSBaseModel: HandyJSON {
    
    required init() {}
        
    class func model(jsonString:String) -> TSBaseModel? {
        let obj = TSBaseModel.deserialize(from: jsonString)
        return obj
    }
    
    func jsonString() -> String? {
        return self.toJSONString()
    }
}
