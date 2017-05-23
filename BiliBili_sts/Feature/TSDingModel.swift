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
    
    lazy var itemTypes:NSArray = ["guochuang","douga","music","dance",
                      "game","technology","life","kichiku",
                      "fashion","ent","teleplay","movie",
                      "ad"]
    lazy var itemNames:NSArray = ["国创","动画","音乐","舞蹈",
                      "游戏","科技","生活","鬼畜",
                      "时尚","娱乐","电视剧","电影",
                      "广告"]
    func name(item:String) -> String{
        
        if itemTypes.contains(item) {
            let index = itemTypes.index(of: item)
            return itemNames[index] as! String
        }
        
        return "其他"
    }
    
    func contentModelsAt(indexPath:IndexPath) ->[TSDingContentModel]?{
        let section = indexPath.section
        
        guard section >= 0 && section < itemTypes.count else {
            return nil
        }
        let itemType:String = itemTypes[section] as! String
        let obj = self.value(forKey: itemType)
        return obj as? [TSDingContentModel]
        
    }
}
