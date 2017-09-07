//
//  TSBangumiModel.swift
//  BiliBili_sts
//
//  Created by sts on 2017/9/7.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation

class TSBangumiModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    var aid:String?
    var author:String?
    var coins:Int64?
    var create:String?
    var favorites:Int64?
    var mid:Int64?
    var pic:String?
    var play:Int64?
    var review:Int64?
    var title:String?
    var typename:String?

}
