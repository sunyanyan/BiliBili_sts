//
//  TSBangumiContentCellView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/9/7.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSBangumiContentCellView: UIView {
    
    //MARK: - Property
    static let tsKey = "TSBangumiContentCellView"
    
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
    lazy var maskImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "banner_bottom")
        return iv
    }()
    
    lazy var playInfoView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "banner_bottom")
        return v
    }()
    
    lazy var playCountIV: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "play_count")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var playCountLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.white
        lbl.font = .systemFont(ofSize: 8)
        return lbl
    }()
    
    lazy var reviewCountIV: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "review_count")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var reviewCountLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.white
        lbl.font = .systemFont(ofSize: 8)
        return lbl
    }()
    
    
    
    var contentModel:TSBangumiModel?{
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
        addSubview(maskImageView)
        addSubview(titleLabel)
        
        addSubview(playInfoView)
        playInfoView.addSubview(playCountIV)
        playInfoView.addSubview(playCountLbl)
        playInfoView.addSubview(reviewCountIV)
        playInfoView.addSubview(reviewCountLbl)
    }
    
    func setupConstraints() {
        let viewWidth = self.tsW
        if viewWidth <= 0 {return}
        contentImage.snp.updateConstraints { (make ) in
            make.right.left.top.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.8)
        }
        maskImageView.snp.updateConstraints { (make ) in
            make.left.top.width.height.equalTo(contentImage)
        }
        titleLabel.snp.updateConstraints { (make ) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(contentImage.snp.bottom)
        }
        playInfoView.snp.updateConstraints { (make ) in
            make.left.right.bottom.equalTo(contentImage)
            make.height.equalTo(contentImage).multipliedBy(0.2)
        }
        playCountIV.snp.makeConstraints { (make) in
            make.left.equalTo(playInfoView.snp.left).offset(8)
            make.bottom.equalTo(playInfoView.snp.bottom)
            make.height.equalTo(playInfoView)
            make.width.equalTo(playInfoView).multipliedBy(0.1)
        }
        
        playCountLbl.snp.makeConstraints { (make) in
            make.left.equalTo(playCountIV.snp.right).offset(8)
            make.bottom.equalTo(playInfoView.snp.bottom)
            make.height.equalTo(playInfoView)
            make.width.equalTo(playInfoView).multipliedBy(0.2)
        }
        
        reviewCountIV.snp.makeConstraints { (make) in
            make.left.equalTo(playCountLbl.snp.right)
            make.bottom.equalTo(playInfoView.snp.bottom)
            make.height.equalTo(playInfoView)
            make.width.equalTo(playInfoView).multipliedBy(0.1)
        }
        
        reviewCountLbl.snp.makeConstraints { (make) in
            make.left.equalTo(reviewCountIV.snp.right).offset(8)
            make.bottom.equalTo(playInfoView.snp.bottom)
            make.height.equalTo(playInfoView)
            make.width.equalTo(playInfoView).multipliedBy(0.2)
        }
        
    }
    
    
    //MARK:- private method
    func setupModel(){
        
        if let imageUrl = self.contentModel?.pic {
            let url = URL.init(string: imageUrl)
            contentImage.sd_setImage(with: url)
        }
        if let title = self.contentModel?.title {
            titleLabel.text = title
        }
 
        if let reviewCount = self.contentModel?.review {
            let countStr = countString(count: reviewCount)
            reviewCountLbl.text = countStr
        }
        
        if let playCount = self.contentModel?.play {
            let countStr = countString(count: playCount)
            playCountLbl.text = countStr
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
