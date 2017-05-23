//
//  TSDingCellPresent.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/22.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

let tsDingContentCellKey = "TSDingContentCellKey"

class TSDingCellPresent {
    weak open var recommendPresent: TSRecommendPresent?
    var contentModels:[TSDingContentModel] = []
    
    func registerCellIn(collectionView:UICollectionView) {
        collectionView.register(TSDingContentCell.self, forCellWithReuseIdentifier: tsDingContentCellKey)
    }
}

// MARK: - UICollectionViewDelegate
extension TSDingCellPresent {

}


// MARK: - TSRecommendPresent DataSource
extension TSDingCellPresent{
    
    func numOfItemsInSection(section:Int) -> Int{
        return (contentModels.count <= 4) ? contentModels.count : 4
    }
    
    func cellForItemAt(collectionView: UICollectionView , indexPath:IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tsDingContentCellKey, for: indexPath) as! TSDingContentCell
        
        let row = indexPath.row
        if row >= 0 && row < contentModels.count {
            let contentModel = contentModels[row]
            cell.contentModel = contentModel
        }
        
        return cell
    }
}


// MARK: - TSRecommendPresent FlowLayoutDelegate
extension TSDingCellPresent{
    
    func itemSize() -> CGSize {
        let width:CGFloat = (recommendPresent!.itemSize().width - 3 * tsCollectionViewItemSpace)/2
        let height:CGFloat = recommendPresent!.itemSize().height / 2
        return CGSize.init(width: width, height: height)
    }
    
    func itemInset() -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, tsCollectionViewItemSpace, 0, tsCollectionViewItemSpace)
    }
}
