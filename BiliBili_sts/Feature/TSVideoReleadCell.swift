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
    static let tsVideoReleadCellKey = "TSVideoReleadCell"
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
        
        let videoThumIVWidth = viewWidth * 0.4
        let videoThumIVHeight = self.tsH - 7 - 7
        
        videoThumIV.snp.makeConstraints { (make ) in
            make.left.equalTo(self).offset(7)
            make.top.equalTo(self).offset(7)
            make.width.equalTo(videoThumIVWidth)
            make.height.equalTo(videoThumIVHeight)
        }
        //这使用autolayout没有生效 还是使用手动生成吧
//        videoThumIV.mask?.snp.makeConstraints({ (make ) in
//            make.left.top.equalTo(0)
//            make.width.height.equalTo(videoThumIV)
//        })
//        videoThumIV.mask?.frame = CGRect.init(x: 0, y: 0, width: videoThumIVWidth, height: videoThumIVHeight)
        
        videoTitleLbl.snp.makeConstraints { (make ) in
            make.left.equalTo(videoThumIV.snp.right).offset(4)
            make.top.equalTo(self).offset(4)
            make.right.equalTo(self).offset(4)
            make.height.equalTo(videoThumIV).multipliedBy(0.5)
        }
        
        videoAuthorView.snp.makeConstraints { (make ) in
            make.top.equalTo(videoTitleLbl.snp.bottom).offset(2)
            make.left.right.equalTo(videoTitleLbl)
            make.height.equalTo(videoThumIV).multipliedBy(0.24)
        }
        playCountView.snp.makeConstraints { (make ) in
            make.top.equalTo(videoAuthorView.snp.bottom).offset(2)
            make.left.equalTo(videoAuthorView)
            make.width.equalTo(60)
            make.height.equalTo(videoAuthorView)
        }
        reviewCountView.snp.makeConstraints { (make ) in
            make.top.bottom.width.equalTo(playCountView)
            make.left.equalTo(playCountView.snp.right)
        }
    }
    func setupModel(model:TSPlayedVideoRelatedContentModel){
        videoTitleLbl.text = model.title
        
        if let urlString = model.pic {
            let nsUrl = URL.init(string: urlString.tsFullUrlString())
            let plcaeholderImage = UIImage.init(named: "default")
            videoThumIV.sd_setImage(with: nsUrl, placeholderImage: plcaeholderImage)
        }
        videoAuthorView.detailLbl.text = model.owner?.name
        playCountView.detailLbl.text = model.stat?.view
        reviewCountView.detailLbl.text = model.stat?.danmaku
        
    }
    //MARK:- property

    lazy var videoThumIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "default")

        //数量不多 圆角就用最简单的 下降的fps不明显
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        
//        let cornerImageView = UIImageView.init(image: UIImage.init(named: "imageCorner"))
//        cornerImageView.frame = CGRect.init(x: 0, y: 0, width: 60, height: 60)
//        iv.mask = cornerImageView
        
        
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
        v.detailLbl.textColor = UIColor.lightGray
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
