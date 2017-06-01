//
//  TSWebShowCell.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/24.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

@objc protocol TSWebShowCellDelegate {
    @objc optional func didSelectAtIndex(index:Int ,model:TSWebShowContentModel, imgUrl:String?)
}

class TSWebShowCell: UICollectionViewCell {
    
    static let TSWebShowCellKey = "TSWebShowCell"
    
    var contentModels:[TSWebShowContentModel]?{
        didSet{
            setupModel()
        }
    }
    
    lazy var carouselView: TSCarouselView = {
    
        let v = TSCarouselView.init(frame: self.bounds, imageUrlStrs: [String](), selectedAction: { (index, imgUrl) in
            if let delegate = self.delegate {
                if let method = delegate.didSelectAtIndex {
                    if let model = self.contentModels?[index] {
                        method(index,model,imgUrl)
                    }
                    
                }
            }
        })
        return v
    }()
    
    weak var delegate:TSWebShowCellDelegate?
    //MARK: - override
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(carouselView)
        
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.init(width: 1, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1

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
