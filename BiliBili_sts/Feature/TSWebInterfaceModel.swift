//
//  TSWebInterfaceModel.swift
//  BiliBili_sts
//
//  Created by sts on 2017/6/20.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation

class TSWebInterfaceModel: TSBaseModel {
    required init() {
        super.init()
    }
    //这个b站怎么直接把数字当key……不能直接把整个json解析成model了，曲线一下
    init(jsonData:Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            guard let jsonDict = jsonObject as? NSDictionary else { return }
            guard let dataDict = jsonDict.object(forKey: "data") as? NSDictionary else { return  }
            for contentModelsAny in dataDict.allValues {
                guard let contentModelsArr = contentModelsAny as? NSArray else { break }
                for contentModelAny in contentModelsArr {
                    guard let contentModelDict = contentModelAny as? NSDictionary else { break }
                    guard let contentModel = TSDingContentModel.deserialize(from: contentModelDict) else { break }
                    dingContents.append(contentModel)
                }
                
            }
        } catch let error {
            TSLog(message: error)
        }
    }
    
    var dingContents:[TSDingContentModel] = [TSDingContentModel]()
    
    /// 每十个取四个
    ///
    /// - Returns: <#return value description#>
    func random4ContentModels() -> [TSDingContentModel]{
        
        var models = [TSDingContentModel]()
        let indexs = TSCommon.random4ToIndex(index: 10)
        let count:Int = (dingContents.count / 10) - 1
        for i in 0...count {
            for index in indexs {
                let realIndex = i*10 + index
                if realIndex < dingContents.count {
                    models.append(dingContents[realIndex])
                }
                
            }
        }
        
        return models
//        return dingContents
    }
    
}
