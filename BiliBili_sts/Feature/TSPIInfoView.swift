//
//  TSPIInfoView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/25.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

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
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        
    }
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    //MARK: - property
    weak var updateFrameDelegate:TSUpdateFrameDelegate?
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.text = "【剧情/恐怖/惊悚/神话】克鲁斯 生肉 (2007)高清"
        return lbl
    }()
    
    lazy var playCountView: TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "play_cout_grey")!, title: "15.2万")
//        v.btn.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 0)
        v.detailLbl.textColor = UIColor.lightGray
        return v
    }()
    
    lazy var reviewCountView: TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "review_count_grey")!, title: "15.2万")
//        v.btn.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 0)
        v.detailLbl.textColor = UIColor.lightGray
        return v
    }()
    
    lazy var detailTextView: TSFlodTextView = {
        let frame = CGRect.init(x: 0, y: 0, width: tsScreenWidth, height: 30)
        let text = "简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介"
        let textView = TSFlodTextView(frame:frame, text:text)
        textView.arrowBtn.addTarget(self , action: #selector(detailTextViewArrowBtnClick), for: .touchUpInside)
        return textView
    }()
    
    lazy var lineView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hexString(hex: "FAFAFA")
        return v
    }()
    
    lazy var shareView :TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "share")!, title: "207")
        v.detailLbl.textColor = UIColor.hexString(hex: "2DCA7E")
//        v.btn.imageEdgeInsets = UIEdgeInsetsMake(4, 0, 0, 4)
        return v
    }()
    
    lazy var coinView :TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "insert_coin")!, title: "173")
//        v.btn.imageEdgeInsets = UIEdgeInsetsMake(4, 0, 1, 4)
        v.detailLbl.textColor = UIColor.hexString(hex: "000000")
        return v
    }()
    
    lazy var starView :TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "collect")!, title: "207")
        v.detailLbl.textColor = UIColor.hexString(hex: "FB7299")
//        v.btn.imageEdgeInsets = UIEdgeInsetsMake(4, 0, 0, 4)
        return v
    }()
    
    lazy var saveView :TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "download")!, title: "缓存")
//        v.btn.imageEdgeInsets = UIEdgeInsetsMake(4, 0, 0, 4)
        v.detailLbl.textColor = UIColor.hexString(hex: "11A1D6")
        v.btn.addTarget(self , action: #selector(saveViewBtnClick), for: UIControlEvents.touchUpInside)
        v.isUserInteractionEnabled = true
        
        return v
    }()
    var detailTextViewHeight = 30
    var requiredViewHeight:CGFloat = 101.0
    //MARK:- setup UI & add Constraints
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        addSubview(titleLbl)
        addSubview(playCountView)
        addSubview(reviewCountView)
        addSubview(detailTextView)
        addSubview(lineView)
        addSubview(shareView)
        addSubview(coinView)
        addSubview(starView)
        addSubview(saveView)
        
    }
    func setupConstraints() {
    
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
    
        titleLbl.snp.makeConstraints { (make ) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(30)
        }
        playCountView.snp.makeConstraints { (make ) in
            make.left.equalTo(self).offset(4)
            make.top.equalTo(titleLbl.snp.bottom)
            make.width.equalTo(60)
            make.height.equalTo(15)
        }
        reviewCountView.snp.makeConstraints { (make ) in
            make.left.equalTo(playCountView.snp.right).offset(4)
            make.top.equalTo(playCountView.snp.top)
            make.width.equalTo(playCountView.snp.width)
            make.height.equalTo(playCountView.snp.height)
        }
        
        detailTextView.snp.updateConstraints { (make ) in
            make.left.right.equalTo(self)
            make.top.equalTo(playCountView.snp.bottom)
            make.height.equalTo(detailTextViewHeight)
        }
        
        let padding = self.tsW  * 0.056
        shareView.snp.makeConstraints { (make ) in
            make.left.equalTo(self.snp.left).offset(padding)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(20)
            make.width.equalTo(self.snp.width).multipliedBy(0.18)
        }
        coinView.snp.makeConstraints { (make ) in
            make.left.equalTo(shareView.snp.right).offset(padding)
            make.bottom.equalTo(shareView.snp.bottom)
            make.height.equalTo(shareView.snp.height)
            make.width.equalTo(shareView.snp.width)
            
        }
        starView.snp.makeConstraints { (make ) in
            make.left.equalTo(coinView.snp.right).offset(padding)
            make.bottom.equalTo(shareView.snp.bottom)
            make.height.equalTo(shareView.snp.height)
            make.width.equalTo(shareView.snp.width)
            
        }
        saveView.snp.makeConstraints { (make ) in
            make.left.equalTo(starView.snp.right).offset(padding)
            make.bottom.equalTo(shareView.snp.bottom)
            make.height.equalTo(shareView.snp.height)
            make.width.equalTo(shareView.snp.width)
            
        }
        
        lineView.snp.makeConstraints { (make ) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(shareView.snp.top)
            make.height.equalTo(1)
        }
        
    }
    
    //MARK:- Event
    func saveViewBtnClick() {
        print("some thing happened")
    }
    func detailTextViewArrowBtnClick(){
        let newStatus = !detailTextView.isMutiLineStatus
        detailTextView.isMutiLineStatus = newStatus
        
        let status = detailTextView.isMutiLineStatus
        let height = detailTextView.mutiTextView.contentSize.height
        let addheight = height - 30 + 8
        
        if(newStatus){
            detailTextViewHeight = Int(30.0 + addheight)
            requiredViewHeight = 101.0 + addheight
        }
        else{
            detailTextViewHeight = 30
            requiredViewHeight = 101.0
        }
        
        if let del  = updateFrameDelegate {
            if let action = del.tsUpdateFrameHeight {
                action(self,requiredViewHeight)
            }
        }
    }
}


