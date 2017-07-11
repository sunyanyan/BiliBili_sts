//
//  TSRecommendHeadView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/26.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSRecommendHeadView: UICollectionReusableView {
    
    static let tsRecommendHeadViewKey = "tsRecommendHeadViewKey" 
    
    lazy var desLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.lightGray
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 14)
        lbl.text = "综合"
        return lbl
    }()
    
    lazy var rankingBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(#imageLiteral(resourceName: "rank_entrance"), for: UIControlState.normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    
    lazy var tagBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(#imageLiteral(resourceName: "sheet_tag"), for: UIControlState.normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    
    lazy var greyLineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

    }
    
    func setupUI(){
        addSubview(desLabel)
        addSubview(rankingBtn)
        addSubview(tagBtn)
        addSubview(greyLineView)
        
        addConstraints()

    }
    func addConstraints() {
        desLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(tsCollectionViewItemSpace)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(self.snp.width).multipliedBy(0.2)
        }
        
        tagBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-tsCollectionViewItemSpace)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(self.snp.height).multipliedBy(0.75)
            make.width.equalTo(self.snp.height).multipliedBy(0.75)
        }
        
        rankingBtn.snp.makeConstraints { (make) in
            make.right.equalTo(tagBtn.snp.left).offset(-tsCollectionViewItemSpace)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(self.snp.height).multipliedBy(0.75)
            make.width.equalTo(self.snp.height).multipliedBy(0.75)
        }
        
        greyLineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
