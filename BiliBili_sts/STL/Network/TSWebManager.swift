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
    /// - Parameter block: 
    ///         resultDic["dingModel"]:TSDingModel? + 
    ///         resultDic["webShowModel"]:TSWebShowModel?
    class func requestRecommandData(block:@escaping((_ resultDic:Dictionary<String, Any>)->())){
        
        var resultDic = Dictionary<String,Any>.init()
        
        let group = DispatchGroup()

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
    
    
    /// 请求播放视频所需内容
    ///
    /// - Parameters:
    ///   - aid: 视频页面的aid
    ///   - block: playerMaskImgUrlData:Data / videoUrlData:Data
    class func requestPlayerData(aid:String,block:@escaping((_ resultDic:Dictionary<String,Any>)->())) {
        var resultDic = Dictionary<String, Any>()
        let group = DispatchGroup()
        
        //视频预览图信息
        group.enter()
        let fetchImageUrl = tsVideoUrl(aid: aid)
        _ = TSWebClient.get(urlString: fetchImageUrl, params: nil, finishedBlock: { (data ) in
            let playerMaskImgUrlData = data
            resultDic["playerMaskImgUrlData"] = playerMaskImgUrlData
            group.leave()
        }, errorBlock: { (error) in
            group.leave()
        })
        
        //获取视频链接信息
        group.enter()
        let playUrl = tsPlayUrl(aid: aid)
        let headers: [String : String] = [
            "Accept-Encoding":"gzip, deflate, sdch",
            "Accept": "*/*",
            "Accept-Language":"zh-CN,zh;q=0.8,en;q=0.6",
            "User-Agent":"Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1",
            "Cookie":"UM_distinctid=15c111f8a67315-0d8ca1f0d10f98-574e6e46-3d10d-15c111f8a68965; fts=1494935899; pgv_pvi=7700364288; sid=kl4udkbw; buvid3=56480B76-957A-4C01-887A-AED221A053ED26517infoc; rpdid=kwmqmiqmpwdoplmqmoqxw; HTML5PlayerCRC32=3741993498; _ga=GA1.2.1941838315.1498033519; purl_token=bilibili_1498786973"
        ];
            
        _ = TSWebClient.get(urlString: playUrl, params: nil,header: headers,  finishedBlock: { (data ) in
            let videoUrlData = data
            resultDic["videoUrlData"] = videoUrlData
            group.leave()
        }, errorBlock: { (error) in
            group.leave()
        })
        
        group.notify(queue: DispatchQueue.main) {
            block(resultDic)
        }
    }
    
    /// 播放页 视频相关内容
    ///
    /// - Parameters:
    ///   - aid: 视频页面的aid
    ///   - block: videoRelatedModel:TSPlayedVideoRelatedModel
    class func requestPlayedVideorelatedData(aid:String,block:@escaping(_ resultDic:Dictionary<String,Any>)->())  {
        var resultDic = Dictionary<String,Any>.init()
        let url = tsPlayedVideoRelatedUrl(aid: aid)
        _ = TSWebClient.get(urlString: url, params: nil , finishedBlock: { (data ) in
            let jsonString = String.init(data: data , encoding: .utf8)
            let videoRelatedModel = TSPlayedVideoRelatedModel.tsDeserialize(from: jsonString)
            resultDic["videoRelatedModel"] = videoRelatedModel
            block(resultDic)
        }, errorBlock: { (Error) in
            block(resultDic)
        })
        
    }
    
    /// 播放页 评论内容
    ///
    /// - Parameters:
    ///   - aid: 视频页面的aid
    ///   - block: playerCommentModel:playerCommentModel
    class func requestPlayedVideoCommentData(aid:String,block:@escaping(_ resultDic:Dictionary<String,Any>)->())  {
        var resultDic = Dictionary<String,Any>.init()
        let url = tsPlayedVideoCommentUrl(aid: aid)
        _ = TSWebClient.get(urlString: url, params: nil , finishedBlock: { (data ) in
            let jsonString = String.init(data: data , encoding: .utf8)
            let playerCommentModel = TSPlayerCommentModel.tsDeserialize(from: jsonString)
            resultDic["playerCommentModel"] = playerCommentModel
            block(resultDic)
        }, errorBlock: { (Error) in
            block(resultDic)
        })
        
    }
    
}

//extension TSWebManager{
//    
//    func clientGetWithGroup(group:DispatchGroup,
//                            urlString: String,
//                            params:[String: Any]?,
//                            resultDic: Dictionary<String,Any>,
//                            resultDataModel:String,
//                            modifyResultDicBlock:@escaping (( Dictionary<String,Any>)->())) {
//        group.enter()
//        
//        _ = TSWebClient.get(urlString: urlString, params: params, finishedBlock: { (Data) in
//            
//            let jsonString = String.init(data: Data, encoding: .utf8)
//            if let modelClass:AnyClass = NSClassFromString(resultDataModel).self {
//                if modelClass is TSBaseModel.Type{
//                    if let model = (modelClass as? TSBaseModel.Type)?.tsDeserialize(from:jsonString) {
//                        var rd = resultDic
//                        rd[resultDataModel] = model
//                        modifyResultDicBlock(rd)
//                    }
//                }
//            }
//            
//            group.leave()
//        }) { (error) in
//            group.leave()
//        }
//    }
//    
//}
