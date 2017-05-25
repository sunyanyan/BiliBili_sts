//
//  TSDingCellPresent.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/22.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSDingCellPresent {
    weak open var recommendPresent: TSRecommendPresent?
    var contentModels:[TSDingContentModel] = []
    
    func registerCellIn(collectionView:UICollectionView) {
        collectionView.register(TSDingContentCell.self, forCellWithReuseIdentifier: TSDingContentCell.tsDingContentCellKey)
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSDingContentCell.tsDingContentCellKey, for: indexPath) as! TSDingContentCell
        
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
//        let width:CGFloat = (recommendPresent!.itemSize(section: 1).width - 3 * tsCollectionViewItemSpace)/2
//        let height:CGFloat = (recommendPresent!.itemSize(section: 1).height - 3 * tsCollectionViewItemSpace)/2
//        return CGSize.init(width: width, height: height)
        return CGSize.zero
    }
    
    func itemInset() -> UIEdgeInsets{
        return UIEdgeInsetsMake(tsCollectionViewItemSpace, tsCollectionViewItemSpace, tsCollectionViewItemSpace, tsCollectionViewItemSpace)
    }
}
