//
//  TSPIAuthorAndTagsView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/26.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

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
        iv.image = #imageLiteral(resourceName: "default")
        return iv
    }()
    lazy var upNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 10)
        lbl.text = "孙同生"
        return lbl
    }()
    lazy var upTimeLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.lightGray
        lbl.text = "6天前投递"
        lbl.font = .systemFont(ofSize: 8)
        return lbl
    }()
    lazy var followBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setTitle("关注", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitleColor(UIColor.hexString(hex: "ECB1C0"), for: .normal)
        btn.layer.borderWidth = 2
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
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        return btn
    }()
    
    lazy var arrowBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"arrow_down"), for: UIControlState.normal)
        btn.addTarget(self , action: #selector(arrowBtnClick(sender:)), for: .touchUpInside)
        btn.tag = 0
        return btn
    }()
    lazy var tagListView: TSTagsListView = {
        let v = TSTagsListView()
        
        return v
    }()
    lazy var lineView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hexString(hex: "FAFAFA")
        return v
    }()
    var tagListViewHeight:CGFloat = 38.0//tagListView的高度
    var requiredViewHeight:CGFloat = 118.0
    weak var updateFrameDelegate:TSUpdateFrameDelegate?
}

extension TSPIAuthorAndTagsView{
    //MARK:- Event
    func arrowBtnClick(sender:UIButton){
        
        if sender.tag == 0 {
            sender.tag = 1
            arrowBtn.setImage(UIImage.init(named: "arrow_up"), for: .normal)
            tagListViewHeight = tagListView.requiredViewheight
        }
        else{
            sender.tag = 0
            arrowBtn.setImage(UIImage.init(named: "arrow_down"), for: .normal)
            tagListViewHeight = 38.0
        }
        requiredViewHeight = 118.0 + tagListViewHeight - 38.0
        
        if let del  = updateFrameDelegate {
            if let action = del.tsUpdateFrameHeight {
                action(self,requiredViewHeight)
            }
        }
        setNeedsLayout()
    }
    
    //MARK:- setup UI & add Constraints
    func setupUI(){
        backgroundColor = UIColor.white
        addSubview(upHeadImageView)
        addSubview(upNameLbl)
        addSubview(upTimeLbl)
        addSubview(followBtn)
        addSubview(titleLbl)
        addSubview(editBtn)
        addSubview(arrowBtn)
        addSubview(tagListView)
        addSubview(lineView)
    }
    func setupConstraints(){
    
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
        
        upHeadImageView.snp.makeConstraints { (make ) in
            make.left.equalTo(self).offset(6)
            make.top.equalTo(self).offset(10)
            make.width.height.equalTo(30)
        }
        followBtn.snp.makeConstraints { (make ) in
            make.top.equalTo(upHeadImageView.snp.top)
            make.right.equalTo(self).offset(-8)
            make.height.equalTo(upHeadImageView.snp.height)
            make.width.equalTo(50)
            
        }
        upNameLbl.snp.makeConstraints { (make ) in
            make.left.equalTo(upHeadImageView.snp.right).offset(6)
            make.top.equalTo(upHeadImageView.snp.top)
            make.right.equalTo(followBtn.snp.left)
            make.height.equalTo(upHeadImageView.snp.height).multipliedBy(0.5)
        }
        upTimeLbl.snp.makeConstraints { (make ) in
            make.left.right.height.equalTo(upNameLbl)
            make.top.equalTo(upNameLbl.snp.bottom)
        }
        titleLbl.snp.makeConstraints { (make ) in
            make.left.equalTo(upHeadImageView)
            make.top.equalTo(upHeadImageView.snp.bottom).offset(20)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        editBtn.snp.makeConstraints { (make ) in
            make.top.equalTo(titleLbl)
            make.right.equalTo(self).offset(-4)
            make.width.height.equalTo(titleLbl)
        }
        arrowBtn.snp.makeConstraints { (make ) in
            make.right.bottom.equalTo(self)
            make.width.height.equalTo(30)
        }
        tagListView.snp.updateConstraints { (make ) in
            make.left.equalTo(self)
            make.top.equalTo(titleLbl.snp.bottom)
            make.right.equalTo(arrowBtn.snp.left)
            make.height.equalTo(tagListViewHeight)
        }
        lineView.snp.makeConstraints { (make ) in
            make.left.equalTo(upHeadImageView.snp.left)
            make.right.equalTo(followBtn.snp.right)
            make.height.equalTo(2)
            make.top.equalTo(upHeadImageView.snp.bottom).offset(9)
        }
    }
}
