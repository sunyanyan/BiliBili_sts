//
//  TSPlayPresent.swift
//  BiliBili_sts
//
//  Created by sts on 2017/6/20.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
class TSPlayPresent {
    
    init(aid:String) {
        self.aid = aid
    }
    
    var aid:String?
    /// 缩略图链接
    var playerThumbnailUrl:String?
}

extension TSPlayPresent{
    
    func requestData(block:@escaping ()->()){
        if let urlId = self.aid {
            let url = tsVideoUrl(aid: urlId)
            _ = TSWebClient.get(urlString: url, params: nil, finishedBlock: { (Data) in
                self.handleResponseData(data: Data)
                block()
            }) { (Error) in
                block()
            }
        }
        else{
            TSLog(message: " aid 为空 ")
            block()
        }
    }
    func handleResponseData(data:Data){
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
    
    
}
