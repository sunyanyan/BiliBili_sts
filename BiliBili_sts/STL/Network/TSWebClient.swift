//
//  TSWebClient.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/16.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import Alamofire

class TSWebClient{

    class func get(urlString: String,
                   params:[String: Any]?,header:[String : String] = tsHeaders,
                   finishedBlock: @escaping (_ resultData: Data)->(),
                   errorBlock: @escaping (_ error: Error)->()) -> DataRequest{
        
        NSLog(" url is \(urlString) ")
        
//        let header = tsHeaders
        
        let request = Alamofire.request(urlString, method: .get, parameters: params, encoding: URLEncoding.default, headers: header)
        
        request.responseData { (response) in
            // 失败的回调
            guard let result = response.result.value else {
                if let error = response.result.error{
                    
                    let errorMsg = "url is: " + urlString + "error is: " + error.localizedDescription
                    TSLog(message: errorMsg)
                    
                    errorBlock(error)
                }
                return
            }
            
            // 成功的回调
            finishedBlock(result)
        }
        
        return request
    }
    
}


