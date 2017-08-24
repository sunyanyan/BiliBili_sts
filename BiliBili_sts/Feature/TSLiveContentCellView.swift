//
//  TSLiveContentCell.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/17.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSLiveContentCellView: UIView {
    
    //MARK: - Property
    static let tsLiveContentCellKey = "TSLiveContentCellKey"

    ///视频图片
    lazy var contentImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.white
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        iv.image = UIImage.init(named: "default")!
        return iv
    }()
    ///标题
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.font = .systemFont(ofSize: 12)
        lbl.lineBreakMode = .byCharWrapping
        lbl.text = "可能his孙尚香可能是百里"
        return lbl
    }()
    ///直播主 名子
    lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.white
        lbl.text = "小米额阿萨德"
        lbl.font = .systemFont(ofSize: 10)
        return lbl
    }()
    ///直播人数
    lazy var countBLV: TSButtonLabelView = {
        let v = TSButtonLabelView()
        v.setupImage(image: UIImage.init(named: "default")!, title: "1.4万")
        v.detailLbl.textColor = UIColor.white
        return v
    }()
    
    
    
    var contentModel:TSLiveContentModel?{
        didSet{
            setupModel()
        }
    }
 
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
    
    
    func setupUI(){
//        self.backgroundColor = UIColor.red
        addSubview(contentImage)
        addSubview(titleLabel)
        addSubview(nameLbl)
        addSubview(countBLV)
    }
    
    func setupConstraints() {
        let viewWidth = self.tsW
        if viewWidth <= 0 {return}
        contentImage.snp.updateConstraints { (make ) in
            make.right.left.top.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.8)
        }
        titleLabel.snp.updateConstraints { (make ) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(contentImage.snp.bottom)
        }
        nameLbl.snp.updateConstraints { (make ) in
            make.left.equalTo(contentImage.snp.left).offset(4)
            make.bottom.equalTo(contentImage.snp.bottom).offset(-4)
            make.height.equalTo(contentImage.snp.height).multipliedBy(0.15)
            make.width.equalTo(contentImage.snp.width).multipliedBy(0.45)
        }
        countBLV.snp.updateConstraints { (make ) in
            make.right.equalTo(contentImage.snp.right).offset(-4)
            make.bottom.equalTo(contentImage.snp.bottom).offset(-4)
            make.height.equalTo(contentImage.snp.height).multipliedBy(0.15)
            make.width.equalTo(contentImage.snp.width).multipliedBy(0.45)
        }
        
    }
 
    
    //MARK:- private method
    func setupModel(){
        if let imageUrl = self.contentModel?.cover?.src {
            let url = URL.init(string: imageUrl)
            contentImage.sd_setImage(with: url)
        }
        if let title = self.contentModel?.title {
            titleLabel.text = title
        }
        if let name = self.contentModel?.owner?.name {
            nameLbl.text = name
        }
        if let onlineCount = self.contentModel?.online {
            let countStr = countString(count: onlineCount)
            countBLV.detailLbl.text = countStr
        }
    }
    
    private func countString(count:Int64)->String{
        if count < 10000 {
            return String.init(count)
        }
        else{
            return String.init(format: "%dw", count/10000)
        }
    }
}
