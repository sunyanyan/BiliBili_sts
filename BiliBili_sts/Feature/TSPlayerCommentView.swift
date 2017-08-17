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
        
        
        let tableViewHeight = tableView.requiredHeight()
        TSLog(message: " 评论框 \(tableViewHeight)")
        tableView.snp.updateConstraints { (make ) in
            make.left.top.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(tableViewHeight)
        }
        
        self.contentSize = CGSize.init(width: 0, height: tableViewHeight)
    }
    //MARK: - property
    lazy var tableView: TSCommentTableView = {
        let v = TSCommentTableView()
        v.updateFrameDelegate = self
        return v
    }()
    //MARK: - property
    var aid:String = ""{
        didSet{
            tableView.videoAid = aid
        }
    }
}

extension TSPlayerCommentView :TSUpdateFrameDelegate{
    func tsUpdateHeight(targetView: UIView, addHeight: CGFloat) {
        setNeedsLayout()
    }
}

