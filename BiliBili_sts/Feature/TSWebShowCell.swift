//
//  TSWebShowCell.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/24.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSWebShowCell: UICollectionViewCell {
    
    static let TSWebShowCellKey = "TSWebShowCell"
    
    var contentModels:[TSWebShowContentModel]?{
        didSet{
            setupModel()
        }
    }
    
    lazy var carouselView: TSCarouselView = {
        let v = TSCarouselView.init(frame: self.bounds)
        return v
    }()
    
    //MARK: - override
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(carouselView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        carouselView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
}

extension TSWebShowCell{
    func setupModel() {
        if self.contentModels != nil {
            
            var urlStrs = [String]()
            for model in self.contentModels! {
                if let urlStr = model.pic{
                    urlStrs.append(urlStr)
                }
            }
            carouselView.imageUrlStrings = urlStrs
            
        }
    }
}
