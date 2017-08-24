//
//  TSLiveModel.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/14.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
class TSLiveModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    var data:TSLiveDataModel?
}
class TSLiveDataModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    var banner:[TSLiveBannerModel]?
    var partitions:[TSLivePartitionsModel]?
}

class TSLiveBannerModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    var title:String?
    var img:String?
    var remark:String?
    var link:String?
}

class TSLivePartitionsModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    var partition:TSLivePartitionModel?
    var lives:[TSLiveContentModel]?
}

class TSLivePartitionModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    var name:String?
    var area:String?
    var count:String?
    var sub_icon:TSLivePartitionSubIconModel?
}
class TSLivePartitionSubIconModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    var width:String?
    var height:String?
    var src:String?
}

class TSLiveContentModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    var title:String?
    var room_id:String?
    var online:Int64?
    var area:String?
    var area_id:String?
    var playurl:String?
    var owner:TSLiveContentOwnerModel?
    var cover:TSLiveContentCoverModel?
}

class TSLiveContentOwnerModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    var face:String?
    var mid:String?
    var name:String?
}
class TSLiveContentCoverModel: TSBaseModel {
    required init() {
        super.init()
    }
    
    var src:String?
    var height:String?
    var width:String?
}
