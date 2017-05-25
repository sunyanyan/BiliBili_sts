//
//  TSBaseModel.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/25.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import HandyJSON

class TSBaseModel:NSObject, HandyJSON {
    required override init() {}
    
    //tsDeserialize会转成TSBaseModel子类对应的类型
    public static func tsDeserialize(from json: String?, designatedPath: String? = nil) -> Self? {
        return JSONDeserializer.deserializeFrom(json: json, designatedPath: designatedPath)
    }
    
    //deserialize会直接转成TSBaseModel类型……
//    class func tsModel(jsonString:String?) -> HandyJSON? {
//        let dtype = type(of: self.init())
//        let obj = dtype.deserialize(from: jsonString)
//        
//        let objE = self.deserialize(from: jsonString)
//        
//        return obj
//    }
    
    func tsJsonString() -> String? {
        return self.toJSONString()
    }
}
