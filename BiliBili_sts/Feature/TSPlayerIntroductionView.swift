//
//  TSPlayerIntroductionViewController.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/11.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSPlayerIntroductionView:UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - property
    lazy var infoView : TSPIInfoView = {
        let v = TSPIInfoView()
        v.delegate = self
        return v
    }()
    
    lazy var authorAndTagsView: TSPIAuthorAndTagsView = {
        let v = TSPIAuthorAndTagsView()
        return v
    }()
    //MARK:- setup UI & add Constraints
    func setupUI(){
        backgroundColor = UIColor.hexString(hex: "FAFAFA")
        addSubview(infoView)
        bringSubview(toFront: infoView)
        addConstraints()
    }
    func addConstraints(){
        infoView.snp.makeConstraints { (make ) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(10)
            make.height.equalTo(101)
        }
        authorAndTagsView.snp.makeConstraints { (make ) in
            make.top.equalTo(infoView.snp.bottom).offset(8)
            make.left.right.equalTo(self)
            make.height.equalTo(150)
            
        }
    }

    
}

extension TSPlayerIntroductionView:TSPIInfoViewDelegate{
    func infoViewShouldUpdateFrame(isMutiLineStatus:Bool,addHeight:CGFloat) {
        if isMutiLineStatus {
            infoView.snp.updateConstraints({ (make) in
                make.left.right.equalTo(self)
                make.top.equalTo(self).offset(10)
                make.height.equalTo(101+addHeight)
            })
        }
        else{
            infoView.snp.updateConstraints({ (make) in
                make.left.right.equalTo(self)
                make.top.equalTo(self).offset(10)
                make.height.equalTo(101)
            })
        }
        setNeedsLayout()
    }
}

/// up主头像 + 关注按钮 + 标签栏
class TSPIAuthorAndTagsView:UIView{
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
    //MARK: - property
    lazy var upHeadImageView:UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var upNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 10)
        return lbl
    }()
    lazy var upTimeLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 8)
        return lbl
    }()
    lazy var followBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setTitle("关注", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.hexString(hex: "ECB1C0").cgColor
        btn.layer.cornerRadius = 5
        return btn
    }()
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "标签相关"
        return lbl
    }()
    lazy var editBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setTitle("编辑", for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        return btn
    }()
    
    lazy var arrowBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"arrow_down"), for: UIControlState.normal)
        return btn
    }()
    lazy var tagListView: TSTagsListView = {
        let v = TSTagsListView()
        return v
    }()
}

extension TSPIAuthorAndTagsView{
    //MARK:- setup UI & add Constraints
    func setupUI(){
        addSubview(upHeadImageView)
        addSubview(upNameLbl)
        addSubview(upTimeLbl)
        
    }
    func setupConstraints(){
    }
}

class TSTagsListView:UIView{
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blue
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
