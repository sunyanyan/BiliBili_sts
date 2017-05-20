//
//  TSDingViewModel.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/20.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

/// TSDingViewModel - property
class TSDingViewModel {
    
    var dingModel:TSDingModel = TSDingModel()
    
    var itemSizeArray = [CGSize]()

}

// MARK: - TSDingViewModel Network
extension TSDingViewModel{
    func requestData(finishCallBack:@escaping ()->(),failueCallBack:@escaping ()->()) {
        
        let url = tsDingUrl
        _ = TSWebClient.get(urlString: url, params: nil, finishedBlock: { (Data) in
            
            let jsonString = String.init(data: Data, encoding: .utf8)
            let dingModel = TSDingModel.deserialize(from: jsonString)
            self.dingModel = dingModel!
            
            finishCallBack()
            
        }) { (Error) in
            
            failueCallBack()
            
        }
        
    }
}

// MARK: - TSDingViewModel FlowLayoutDelegate
extension TSDingViewModel{

    func itemSize() -> CGSize {
        let width:CGFloat = (tsScreenWidthCgfloat - 3 * tsCollectionViewItemSpace)/2
        let height:CGFloat = 160
        return CGSize.init(width: width, height: height)
    }
}
