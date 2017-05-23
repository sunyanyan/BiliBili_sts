//
//  TSWebShowModel.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/23.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation

class TSWebShowContentModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    /// 图片链接
    var pic:String?
    /// 点击图片 引用的地址
    var url:String?
}

class TSWebShowModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    var data:[TSWebShowContentModel]?
}
