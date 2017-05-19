//
//  TSPreloadModel.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/17.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation

class TSPreloadModel:NSObject{
    
    /// 滚动视图的接口
    var webShowUrl :String?
    /// 各个区置顶
    var dingUrl :String?
    /// 热门推荐
    var rankUrl :String?
    
    init(data:Data) {
        let responseString = String.init(data: data, encoding: .utf8)
        
        let preloadRange = responseString?.range(of: "preload")
        let appQueueRange = responseString?.range(of: "app.queue")
        
        guard (preloadRange != nil) && (appQueueRange != nil)  else {
            TSLog(message: "responseString数据不正确  ")
            return
        }
        
        let range = Range<String.Index>.init(uncheckedBounds: (lower: (preloadRange?.upperBound)!, upper: (appQueueRange?.lowerBound)!))
        let subStr = responseString?.substring(with: range)
        let urls = subStr?.components(separatedBy: "\"")
        
        var webShowUrl = ""
        var dingUrl = ""
        var rankingUrl = ""
        
        for url in urls! {
            if(url.contains("web-show")){
                webShowUrl = url
            }
            else if (url.contains("ding")){
                dingUrl = url
            }
            else if (url.contains("ranking")){
                rankingUrl = url
            }
        }
        
        self.webShowUrl = tshttp + webShowUrl
        self.dingUrl = tsBilibiliHost + dingUrl
        self.rankUrl = tshttp + rankingUrl
    }
    
}

class TSPreloadViewModel:NSObject{
    
   

    //MARK: - private method
    /// 请求数据
    func requestData(block: @escaping ()->()){
        
        let url = tsIndexUrl
        _ = TSWebClient.get(urlString: url, params: nil, finishedBlock: { (Data) in
            
            let model = TSPreloadModel.init(data: Data)
            
            if(model != nil) {
                tsUserDefaults.setValue(model, forKey: tsLocalPreloadModelKey)
            }
            
            self.preloadModel = model
            block()
        }) { (Error) in
            block()
        }
        
    }
    
    //MARK: - PROPERTY
    var preloadModel:TSPreloadModel?
    
    class func localPreloadModel() -> TSPreloadModel{
        let model:TSPreloadModel = tsUserDefaults.object(forKey: tsLocalPreloadModelKey) as! TSPreloadModel
        return model
    }
}

