//
//  TSDingCell.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/18.
//  Copyright © 2017年 sts. All rights reserved.
//

import UIKit
import SnapKit

class TSDingCell: UICollectionViewCell {
    //MARK: - Property
    lazy var contentImage: UIImageView = {
        let imagePath = Bundle.main.path(forResource: "testDing", ofType: "jpg")
        let img = UIImage.init(contentsOfFile: imagePath!)
        let iv = UIImageView.init(image: img)
        return iv
    }()
    
    //MARK: - override
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(contentImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentImage.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
}
