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
        return v
    }()
    //MARK:- setup UI & add Constraints
    func setupUI(){
        backgroundColor = UIColor.green
        addSubview(infoView)
        bringSubview(toFront: infoView)
        addConstraints()
    }
    func addConstraints(){
        infoView.snp.makeConstraints { (make ) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(150)
        }
    }
    
}

//MARK:- 简介 + 分享 投币 收藏 缓存 按钮
class TSPIInfoView: UIView {
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - property
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.text = "【剧情/恐怖/惊悚/神话】克鲁斯 生肉 (2007)高清"
        return lbl
    }()
    
    lazy var playCountView: TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "play_cout_grey")!, title: "15.2万")
        return v
    }()
    
    lazy var reviewCountView: TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "review_count_grey")!, title: "15.2万")
        return v
    }()

    lazy var detailTextView: UITextView = {
        let textView = UITextView()
        textView.text = "简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介"
        return textView
    }()
    
    lazy var lineView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black
        return v
    }()
    
    lazy var shareView :TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "share")!, title: "207")
        return v
    }()
    
    lazy var coinView :TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "category_tab_s")!, title: "173")
        return v
    }()
    
    lazy var starView :TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "sheet_tag")!, title: "207")
        return v
    }()
    
    lazy var saveView :TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "default")!, title: "207")
        v.btn.addTarget(self , action: #selector(someBtnClick), for: UIControlEvents.touchUpInside)
        v.isUserInteractionEnabled = true
        return v
    }()
    
    func someBtnClick() {
        print("some thing happened")
    }
    
    //MARK:- setup UI & add Constraints
    func setupUI(){
        addSubview(titleLbl)
        addSubview(playCountView)
        addSubview(reviewCountView)
        addSubview(detailTextView)
        addSubview(lineView)
        addSubview(shareView)
        addSubview(coinView)
        addSubview(starView)
        addSubview(saveView)
        addConstraints()
    }
    func addConstraints() {
        titleLbl.snp.makeConstraints { (make ) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(30)
        }
        playCountView.snp.makeConstraints { (make ) in
            make.left.equalTo(self)
            make.top.equalTo(titleLbl.snp.bottom)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        reviewCountView.snp.makeConstraints { (make ) in
            make.left.equalTo(playCountView.snp.right).offset(8)
            make.top.equalTo(titleLbl.snp.bottom)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        detailTextView.snp.makeConstraints { (make ) in
            make.left.right.equalTo(self)
            make.top.equalTo(playCountView.snp.bottom)
            make.bottom.equalTo(lineView.snp.top)
        }
        lineView.snp.makeConstraints { (make ) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(shareView.snp.top)
            make.height.equalTo(1)
        }
        shareView.snp.makeConstraints { (make ) in
            make.left.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(30)
            make.width.equalTo(self).multipliedBy(0.25)
        }
        coinView.snp.makeConstraints { (make ) in
            make.left.equalTo(shareView.snp.right)
            make.bottom.equalTo(self)
            make.height.equalTo(30)
            make.width.equalTo(self).multipliedBy(0.25)
        }
        starView.snp.makeConstraints { (make ) in
            make.left.equalTo(coinView.snp.right)
            make.bottom.equalTo(self)
            make.height.equalTo(30)
            make.width.equalTo(self).multipliedBy(0.25)
        }
        saveView.snp.makeConstraints { (make ) in
            make.left.equalTo(starView.snp.right)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(30)
            make.width.equalTo(self).multipliedBy(0.25)
        }
        
    }
}

/// 左边按钮 右边文字
class TSButtonLabelView:UIView{
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- property
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"share"), for: UIControlState.normal)
        return btn
    }()
    
    lazy var detailLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.red
        lbl.font = .systemFont(ofSize: 12)
        return lbl
    }()
    //MARK: - setup UI
    func setupUI () {
        addSubview(btn)
        addSubview(detailLbl)
        addConstraints()
    }
    func addConstraints() {
        btn.snp.makeConstraints { (make ) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
        }
        detailLbl.snp.makeConstraints { (make ) in
            make.right.top.bottom.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
        }
    }
    //MARK: - event
    func setupImage(image:UIImage, title:String){
        btn.setImage(image, for: UIControlState.normal)
        detailLbl.text = title
    
//        image.getPaletteImageColor { (recommendColorModel, allModeColorDic, error) in
//            if let colorHexString:String = recommendColorModel?.imageColorString {
//                self.detailLbl.textColor = UIColor.hexString(hex: colorHexString)
//            }
//        }
    }
    
}
