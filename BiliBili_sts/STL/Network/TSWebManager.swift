//
//  TSWebManager.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/23.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation

class TSWebManager {
    
    /// 请求 各个区的数据 和 滚动推荐数据
    ///
    /// - Parameter block: resultDic["dingModel"]:TSDingModel? + resultDic["webShowModel"]:TSWebShowModel?
    class func requestRecommandData(block:@escaping((_ resultDic:Dictionary<String, Any>)->())){
        
        var resultDic = Dictionary<String,Any>.init()
        
        let group = DispatchGroup()
        
//        group.enter()
//        let url = tsDingUrl
//        _ = TSWebClient.get(urlString: url, params: nil, finishedBlock: { (Data) in
//            let jsonString = String.init(data: Data, encoding: .utf8)
//            let dingModel = TSDingModel.tsDeserialize(from: jsonString)
//            resultDic["dingModel"] =  dingModel
//            group.leave()
//            
//        }) { (Error) in
//            
//            group.leave()
//        }
        
        group.enter()
        let url2 = tsWebShowUrl
        _ = TSWebClient.get(urlString: url2, params: nil, finishedBlock: { (Data) in
            let jsonString = String.init(data: Data, encoding: .utf8)
            let webShowModel = TSWebShowModel.tsDeserialize(from: jsonString)
            resultDic["webShowModel"] =  webShowModel
            
            group.leave()
        }) { (Error) in
            
            group.leave()
        }
        
        group.enter()
        let url3 = tsWebInterfaceDynamicUrl
        _ = TSWebClient.get(urlString: url3, params: nil, finishedBlock: { (Data) in
            
            let webInterfaceModel = TSWebInterfaceModel.init(jsonData: Data)
            resultDic["webInterfaceModel"] =  webInterfaceModel
            
            group.leave()
        }, errorBlock: { (Error) in
            group.leave()
        })
        
        group.notify(queue: DispatchQueue.main) {
            block(resultDic)
        }
        
    }
    
}

extension TSWebManager{
    
    func clientGetWithGroup(group:DispatchGroup,
                            urlString: String,
                            params:[String: Any]?,
                            resultDic: Dictionary<String,Any>,
                            resultDataModel:String,
                            modifyResultDicBlock:@escaping (( Dictionary<String,Any>)->())) {
        group.enter()
        
        _ = TSWebClient.get(urlString: urlString, params: params, finishedBlock: { (Data) in
            
            let jsonString = String.init(data: Data, encoding: .utf8)
            if let modelClass:AnyClass = NSClassFromString(resultDataModel).self {
                if modelClass is TSBaseModel.Type{
                    if let model = (modelClass as? TSBaseModel.Type)?.tsDeserialize(from:jsonString) {
                        var rd = resultDic
                        rd[resultDataModel] = model
                        modifyResultDicBlock(rd)
                    }
                }
            }
            
            group.leave()
        }) { (error) in
            group.leave()
        }
    }
    
}
