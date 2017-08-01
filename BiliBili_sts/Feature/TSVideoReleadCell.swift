//
//  TSVideoReleadCell.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/1.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit


class TSVideoReleadCell:UITableViewCell{
    //MARK: - life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    //MARK: - setup UI
    func setupUI () {
        addSubview(videoThumIV)
        addSubview(videoTitleLbl)
        addSubview(videoAuthorView)
        addSubview(playCountView)
        addSubview(reviewCountView)
    }
    func setupConstraints(){
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
        
        videoThumIV.snp.makeConstraints { (make ) in
            make.left.equalTo(self).offset(4)
            make.top.equalTo(self).offset(4)
            make.width.equalTo(self).multipliedBy(0.4)
            make.bottom.equalTo(self).offset(-4)
        }
        
        videoTitleLbl.snp.makeConstraints { (make ) in
            make.left.equalTo(videoThumIV.snp.right).offset(4)
            make.top.equalTo(videoThumIV.snp.top)
            make.right.equalTo(self).offset(4)
            make.height.equalTo(videoThumIV).multipliedBy(0.5)
        }
        
        videoAuthorView.snp.makeConstraints { (make ) in
            make.top.equalTo(videoTitleLbl.snp.bottom)
            make.left.right.equalTo(videoTitleLbl)
            make.height.equalTo(videoThumIV).multipliedBy(0.25)
        }
        playCountView.snp.makeConstraints { (make ) in
            make.top.equalTo(videoAuthorView.snp.bottom)
            make.left.equalTo(videoAuthorView)
            make.width.equalTo(60)
            make.height.equalTo(videoAuthorView)
        }
        reviewCountView.snp.makeConstraints { (make ) in
            make.top.bottom.width.equalTo(playCountView)
            make.left.equalTo(playCountView.snp.right)
        }
    }
    //MARK:- property
    lazy var videoThumIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "default")
        return iv
    }()
    lazy var videoTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "《奇幻森林》特效揭秘，生物特效领域的里程碑"
        lbl.numberOfLines = 2
        return lbl
    }()
    lazy var videoAuthorView: TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "upInfo")!, title: "影视后期圈")
//        v.btn.imageEdgeInsets = UIEdgeInsetsMake(0, 24, 0, 0)
        return v
    }()
    lazy var playCountView: TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "play_cout_grey")!, title: "15.2万")
//        v.btn.imageEdgeInsets = UIEdgeInsetsMake(0, 24, 0, 0)
        v.detailLbl.textColor = UIColor.lightGray
        return v
    }()
    
    lazy var reviewCountView: TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "review_count_grey")!, title: "15.2万")
//        v.btn.imageEdgeInsets = UIEdgeInsetsMake(0, 24, 0, 0)
        v.detailLbl.textColor = UIColor.lightGray
        return v
    }()
}
