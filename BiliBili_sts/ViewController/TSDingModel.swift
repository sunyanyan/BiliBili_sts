//
//  TSDingModel.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/20.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation

class TSDingContentStatModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    /// 播放数
    var view:Int64?
    /// 评论
    var reply:Int64?
}

class TSDingContentModel: TSBaseModel {
    //MARK:- init
    required init() {
        super.init()
    }
    //MARK: - property
    var pic:String?
    var title:String?
    var duration:Int64?
    var stat:TSDingContentStatModel?
}

class TSDingModel : TSBaseModel {
    required init() {
        super.init()
    }
    
    var douga:[TSDingContentModel]?
    var teleplay:[TSDingContentModel]?
    var kichiku:[TSDingContentModel]?
    var dance:[TSDingContentModel]?
    var bangumi:[TSDingContentModel]?
    var fashion:[TSDingContentModel]?
    var life:[TSDingContentModel]?
    var ad:[TSDingContentModel]?
    var guochuang:[TSDingContentModel]?
    var movie:[TSDingContentModel]?
    var music:[TSDingContentModel]?
    var technology:[TSDingContentModel]?
    var game:[TSDingContentModel]?
    var ent:[TSDingContentModel]?
}
