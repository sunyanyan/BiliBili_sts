//
//  TSVideoReleadViewPresent.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/2.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSVideoReleadViewPresent{
    init(aid:String) {
        self.aid = aid
    }
    var aid:String?
    var models:[TSPlayedVideoRelatedContentModel] = [TSPlayedVideoRelatedContentModel]()
    weak var weakVideoReleadView:TSVideoReleadView?
}
extension TSVideoReleadViewPresent{
    func requestData(block:@escaping()->()){
        if (self.aid != nil) && !String.tsIsEmpty(string: self.aid) {
            let videoAid = self.aid!
            TSWebManager.requestPlayedVideorelatedData(aid: videoAid, block: { (resultDic) in
                
                if let model:TSPlayedVideoRelatedModel = resultDic["videoRelatedModel"] as? TSPlayedVideoRelatedModel{
                    if let contentModels:[TSPlayedVideoRelatedContentModel] = model.data {
                        self.models = contentModels
                    }
                }
                block()
            })
        }
        else {
            block()
        }
        
    }
}

// MARK: - tableview DataSource/delegate
extension TSVideoReleadViewPresent{
    func numberOfRowsInSection()->Int{
        return self.models.count
    }
    func cellForRowAt(indexPath:IndexPath,tableView:UITableView) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: TSVideoReleadCell.tsVideoReleadCellKey)
        if cell == nil {
            cell = TSVideoReleadCell.init(style: .default, reuseIdentifier: TSVideoReleadCell.tsVideoReleadCellKey)
        }
        
        if let model  = TSCommon.modelAt(indexPath: indexPath, oneSectionModels:self.models) as? TSPlayedVideoRelatedContentModel{
            if let videoRelatedCell = cell as?  TSVideoReleadCell{
                videoRelatedCell.setupModel(model:model)
                return videoRelatedCell
            }
        }
        
        fatalError(" model数组异常 ")
    }
    func cellHeight() -> CGFloat {
        return 80
    }
    func didSelect(indexPath:IndexPath,tableView:UITableView){
        TSLog(message: "")
    }
    
}
