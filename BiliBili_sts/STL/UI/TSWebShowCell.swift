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
//    @objc optional func didSelectAtIndex(index:Int ,model:TSWebShowContentModel, imgUrl:String?)
    @objc optional func didSelect(index:Int ,linkUrl:String?, imgUrl:String?)
    
}

class TSWebShowCell: UICollectionViewCell {
    
    static let TSWebShowCellKey = "TSWebShowCell"
    
    var contentModels:[TSBaseModel]?{
        didSet{
            setupModel()
        }
    }
    
    lazy var carouselView: TSCarouselView = {
    
        let v = TSCarouselView.init(frame: self.bounds, imageUrlStrs: [String](), selectedAction: { (index, imgUrl) in
            if let delegate = self.webCellSelectDelegate {
                if let method = delegate.didSelect {
                    let modelStruct = self.modelUrl(index:index)
                    method(index,modelStruct.linkUrl,modelStruct.imageUrl)
                }
            }
        })
        return v
    }()
    
    weak var webCellSelectDelegate:TSWebShowCellDelegate?
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
    
        if let contentModelsT = self.contentModels {
        
            var urlStrs = [String]()
            for index in 0..<contentModelsT.count {
                if let imageUrl = modelUrl(index: index).imageUrl {
                    urlStrs.append(imageUrl)
                }
            }
            carouselView.imageUrlStrings = urlStrs
        }
    }
    func modelUrl(index:Int)->(imageUrl:String? , linkUrl:String?){
        if let contentModelsT = self.contentModels {
            let model = TSCommon.modelAt(index: index, models: contentModelsT)
            if model is TSWebShowContentModel {
                let modelTmp = model as! TSWebShowContentModel
                return (modelTmp.pic,modelTmp.url)
            }
            else if model is TSLiveBannerModel {
                let modelTmp = model as! TSLiveBannerModel
                return (modelTmp.img,modelTmp.link)
            }
            else {
                return (nil,nil)
            }
        }
        else {
            return (nil,nil)
        }
    }
}
