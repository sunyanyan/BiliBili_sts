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
        return v
    }()
    var requiredViewHeight:CGFloat = 80 * 10
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
            cell = TSVideoReleadCell.init(style: .default, reuseIdentifier: cellId)
        }
        return cell!
    }
}
extension TSVideoReleadView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
