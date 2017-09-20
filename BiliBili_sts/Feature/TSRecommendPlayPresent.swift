//
//  TSRecommendPlayPresent.swift
//  BiliBili_sts
//
//  Created by sts on 2017/6/20.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
class TSRecommendPlayPresent {
    
    init(aid:String) {
        self.aid = aid
    }
    
    var aid:String?
    /// 缩略图链接
    var playerThumbnailUrl:String?
    var videoUrl:String?
}

extension TSRecommendPlayPresent{
    
    func requestData(block:@escaping ()->()){
        if let urlId = self.aid {
            
            TSWebManager.requestPlayerData(aid: urlId, block: { (resultDic) in
                if let playerMaskImgUrlData:Data = resultDic["playerMaskImgUrlData"] as? Data {
                    self.handlePlayerMaskImgUrlData(data: playerMaskImgUrlData)
                }
                if let videoUrlData:Data = resultDic["videoUrlData"] as? Data {
                    self.handleVideoUrlData(data: videoUrlData)
                }
                block()
            })
            
        }
        else{
            TSLog(message: " aid 为空 ")
            block()
        }
    }
    
    func handlePlayerMaskImgUrlData(data:Data){
        guard let responseString = String.init(data: data, encoding: .utf8) else { return }
        
        let range1 = responseString.range(of: "og:image\" content=\"")
        let range2 = responseString.range(of: "\"/>\n<meta property=\"og:url\"")
        guard range1 != nil && range2 != nil else {
            return
        }
        let range = Range<String.Index>.init(uncheckedBounds: (lower: (range1?.upperBound)!, upper: (range2?.lowerBound)!))
        let subStr = responseString.substring(with: range)
        self.playerThumbnailUrl = subStr
    }
     
    func handleVideoUrlData(data:Data){
        guard let responseString = String.init(data: data, encoding: .utf8) else { return }
        
        let range1 = responseString.range(of: "url\":\"")
        let range2 = responseString.range(of: "\"}]")
        guard range1 != nil && range2 != nil else {
            return
        }
        let range = Range<String.Index>.init(uncheckedBounds: (lower: (range1?.upperBound)!, upper: (range2?.lowerBound)!))
        let subStr = responseString.substring(with: range)
        let str = subStr.replacingOccurrences(of: "\\", with: "")
        self.videoUrl = str
    }
    
    
}
