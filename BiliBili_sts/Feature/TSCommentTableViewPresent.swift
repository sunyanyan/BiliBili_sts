//
//  TSCommentTableViewPresent.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/17.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSCommentTableViewPresent{
    init(aid:String) {
        self.aid = aid
    }
    var aid:String?
    var replyModels = [TSPlayerCommentReplyModel]()
    fileprivate var cellHeights = [CGFloat]()
}

extension TSCommentTableViewPresent {
    func requestData(block:@escaping()->()){
        if !String.tsIsEmpty(string: self.aid){
            let commentAid = self.aid!
            TSWebManager.requestPlayedVideoCommentData(aid: commentAid, block: { (resultDic) in
                if let playerCommentModel = resultDic["playerCommentModel"] as? TSPlayerCommentModel {
                    self.handlePlayerCommentModel(playerCommentModel: playerCommentModel)
                }
                block()
            })
        }
        else{
            block()
        }
    }
    
    func handlePlayerCommentModel(playerCommentModel:TSPlayerCommentModel )  {
        if let replies = playerCommentModel.data?.replies {
            self.replyModels = replies
            //计算高度
            cellHeights = [CGFloat]()
            for model  in replies {
                let height = TSCommentTableCell.requiredHeight(model: model)
                cellHeights.append(height)
                
            }
        }
        
        
    }
}
extension TSCommentTableViewPresent{
    func numberOfRowsInSection()->Int{
        return self.replyModels.count
    }
    func cellForRowAt(indexPath:IndexPath,tableView:UITableView) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: TSVideoReleadCell.tsVideoReleadCellKey)
        if cell == nil {
            cell = TSCommentTableCell.init(style: .default, reuseIdentifier: TSCommentTableCell.tsCommentTableCellKey)
        }
        
        if let model  = TSCommon.modelAt(indexPath: indexPath, oneSectionModels:self.replyModels) as? TSPlayerCommentReplyModel{
            if let commentCell = cell as?  TSCommentTableCell{
                commentCell.setupModel(model:model)
                return commentCell
            }
        }
        
        fatalError(" model数组异常 ")
    }
    
    func cellHeight(indexPath:IndexPath,tableView:UITableView?) -> CGFloat {
        
        if let height = TSCommon.modelAt(indexPath: indexPath, oneSectionModels: cellHeights) as? CGFloat{
            return height
        }
        return 76
    }
    
    func allHeight()->CGFloat{
        var allHeight:CGFloat = 0.0
        let count = numberOfRowsInSection() - 1
        if count <= 0 {
            return allHeight
        }
        for rowIndex in 0...count {
            let indexPath = IndexPath.init(row: rowIndex, section: 0)
            let cellHeight = self.cellHeight(indexPath: indexPath, tableView: nil)
            allHeight = allHeight + cellHeight
        }
        return allHeight
    }
}
