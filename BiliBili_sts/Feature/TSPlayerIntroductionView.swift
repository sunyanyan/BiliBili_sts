//
//  TSPlayerIntroductionViewController.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/11.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSPlayerIntroductionView:UIScrollView{
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
    
    //MARK: - property
    lazy var infoView : TSPIInfoView = {
        let v = TSPIInfoView()
        v.updateFrameDelegate = self
        return v
    }()
    
    lazy var authorAndTagsView: TSPIAuthorAndTagsView = {
        let v = TSPIAuthorAndTagsView()
        v.updateFrameDelegate = self
        return v
    }()
    
    lazy var videoReleadtedView:TSVideoReleadView = {
        let v = TSVideoReleadView()
        return v
    }()
    weak var updateFrameDelegate:TSUpdateFrameDelegate?
    
    //MARK:- setup UI & add Constraints
    func setupUI(){
        backgroundColor = UIColor.hexString(hex: "FAFAFA")
        addSubview(infoView)
        addSubview(authorAndTagsView)
        addSubview(videoReleadtedView)
        
        self.contentSize = CGSize.init(width: 0, height: self.requiredViewHeight())
        
    }
    func setupConstraints(){
    
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
    
        infoView.snp.updateConstraints { (make ) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(10)
            make.height.equalTo(infoView.requiredViewHeight)
        }
        authorAndTagsView.snp.updateConstraints { (make ) in
            make.top.equalTo(infoView.snp.bottom).offset(8)
            make.left.right.equalTo(self)
            make.height.equalTo(authorAndTagsView.requiredViewHeight)
            
        }
        videoReleadtedView.snp.updateConstraints { (make ) in
            make.top.equalTo(authorAndTagsView.snp.bottom).offset(8)
            make.left.right.equalTo(self)
            make.height.equalTo(videoReleadtedView.requiredViewHeight)
        }
        
        self.contentSize = CGSize.init(width: 0, height: self.requiredViewHeight())
    }
    
    /// 当前视图合适的高度
    ///
    /// - Returns: <#return value description#>
    func requiredViewHeight()->CGFloat{
        let height = infoView.requiredViewHeight + authorAndTagsView.requiredViewHeight + videoReleadtedView.requiredViewHeight
        return  height
    }

    
}

extension TSPlayerIntroductionView:TSUpdateFrameDelegate{
    func tsUpdateFrameHeight(targetView: UIView, newHeight: CGFloat) {
        if let del  = updateFrameDelegate {
            del.tsUpdateFrameHeight(targetView: self, newHeight: self.requiredViewHeight())
        }
        setNeedsLayout()
    }
}

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
        return v
    }()
    var requiredViewHeight:CGFloat = 44.0 * 10
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
}

extension TSVideoReleadView:UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 10;
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = "这是一条cell"
        return cell!
    }
}
extension TSVideoReleadView:UITableViewDelegate{}
