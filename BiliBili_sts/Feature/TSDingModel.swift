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
    var tags:[String]?//废弃
    var tname:String?
    var aid:String?
    
    //转换标签信息
    func formedTagStr () -> String? {
//        if let tagStrings = tags{
//            if tagStrings.count <= 2{
//                let nsArray = NSArray.init(array: tagStrings)
//                return nsArray.componentsJoined(by: " · ")
//            }
//            else{
//                let nsArray = NSArray.init(objects: tagStrings[0],tagStrings[1])
//                return nsArray.componentsJoined(by: " · ")
//            }
//        }
//        return nil
        return tname;
    }
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
    
    func contentModelsAt(index:Int) ->[TSDingContentModel]?{
        let section = index
        
        guard section >= 0 && section < itemTypes.count else {
            return nil
        }
        let itemType:String = itemTypes[section] as! String
        let obj = self.value(forKey: itemType)
        return obj as? [TSDingContentModel]
        
    }
    
    /// 从每个区数据中取出随机四个
    ///
    /// - Returns: <#return value description#>
    func random4ContentModels() -> [TSDingContentModel]{
        
        var models = [TSDingContentModel]()
        
        for type in itemTypes {
            if let obj:[TSDingContentModel] = self.value(forKey: type as! String) as? [TSDingContentModel]{
                let count = obj.count
                let indexs = TSCommon.random4ToIndex(index: count - 1)
//                TSLog(message: "indexs:\(indexs)")
                for index in indexs{
                    models.append(obj[index])
                }
            }
        }
        
        return models
    }
}
