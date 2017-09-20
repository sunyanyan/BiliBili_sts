//
//  TSPlayedVideoRelatedModel.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/2.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
///视频相关
class TSPlayedVideoRelatedModel: TSBaseModel {
    required init() {
        super.init()
    }
    var data:[TSPlayedVideoRelatedContentModel]?
}
class TSPlayedVideoRelatedContentModel: TSBaseModel {
    required init() {
        super.init()
    }
    var aid:String?
    var desc:String?
    var tid:String?
    var title:String?
    var tname:String?
    var pic:String?
    var owner:TSPlayedVideoRelatedContentOwnerModel?
    var stat:TSPlayedVideoRelatedContentStatModel?
}

class TSPlayedVideoRelatedContentOwnerModel: TSBaseModel {
    required init() {
        super.init()
    }
    var name:String?
    var face:String?
}
class TSPlayedVideoRelatedContentStatModel: TSBaseModel {
    required init() {
        super.init()
    }
    var aid :String?
    var coin:String?
    var danmaku:String?
    var replay:String?
    var view:String?
}
