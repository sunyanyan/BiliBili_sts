//
//  TSVideoReleadView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/1.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit


/// 展示视频相关列表
class TSVideoReleadView:UIView{
    //MARK: - life cycle
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
    //MARK:-property
    lazy var contentTableView: UITableView = {
        let v = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        v.delegate = self
        v.dataSource = self
        v.separatorStyle = .none
        return v
    }()
    
    var videoAid:String=""{
        didSet{
            videoRelatedPresent.aid = videoAid
            reload()
        }
    }
    lazy var videoRelatedPresent: TSVideoReleadViewPresent = {
        let p = TSVideoReleadViewPresent.init(aid: self.videoAid)
        p.weakVideoReleadView = self 
        return p
    }()
    func requiredViewHeight()->CGFloat{
        let cellNum:CGFloat = CGFloat.init(self.videoRelatedPresent.numberOfRowsInSection())
        let cellHeight = self.videoRelatedPresent.cellHeight()
        let height = cellNum * cellHeight
        return height
    }
    weak var updateFrameDelegate:TSUpdateFrameDelegate?
}

extension TSVideoReleadView{
    //MARK: - setup UI
    func setupUI () {
        contentTableView.isScrollEnabled = false
        self.backgroundColor = UIColor.red
        addSubview(contentTableView)
    }
    func setupConstraints(){
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
        
        contentTableView.snp.makeConstraints { (make ) in
            make.left.top.equalTo(self)
            make.width.height.equalTo(self)
        }
    }
    
    func reload(){
        videoRelatedPresent.requestData {
            self.contentTableView.reloadData()
            
            if let del  = self.updateFrameDelegate  {
                del.tsUpdateFrameHeight(targetView: self , newHeight: 0)
            }
            self.setNeedsLayout()
        }
    }
}

extension TSVideoReleadView:UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.videoRelatedPresent.numberOfRowsInSection();
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        return self.videoRelatedPresent.cellForRowAt(indexPath: indexPath, tableView: tableView)
    }
}
extension TSVideoReleadView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.videoRelatedPresent.cellHeight()
    }
}
