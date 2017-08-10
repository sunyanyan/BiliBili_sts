//
//  TSPlayerCommentViewController.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/11.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSPlayerCommentView: UIScrollView  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
  
    //MARK:- setup UI & add Constraints
    func setupUI(){
        addSubview(tableView)
    }
    func setupConstraints(){
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
        
        tableView.snp.updateConstraints { (make ) in
            make.left.top.equalTo(self)
            make.width.height.equalTo(self)
        }
    }
    //MARK: - property
    lazy var tableView: TSCommentTableView = {
        let v = TSCommentTableView()
        return v
    }()
    //MARK: - property
    var aid:String = ""{
        didSet{
            tableView.videoAid = aid
        }
    }
}

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
        }
        //计算高度
        
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
    
    func cellHeight(indexPath:IndexPath,tableView:UITableView) -> CGFloat {
        return 76
    }
}
