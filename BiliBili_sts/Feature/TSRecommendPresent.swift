//
//  TSRecommendPresent.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/20.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

let tsDingCellKey = "TSDingCellKey"

/// TSRecommendPresent - property
class TSRecommendPresent {
    
    /// 区置顶数据
    var dingModel:TSDingModel = TSDingModel()
    /// 滚动推荐数据
    var webShowModel:TSWebShowModel = TSWebShowModel()
    
    var itemSizeArray = [CGSize]()
    
    
    func registerCellIn(collectionView:UICollectionView) {
        collectionView.register(TSDingCell.self, forCellWithReuseIdentifier: tsDingCellKey)
    }
    

}

// MARK: - TSRecommendPresent Network
extension TSRecommendPresent{

    func requestData(finishCallBack:@escaping ()->()) {
        
        TSWebManager.requestRecommandData { (resultDic) in
            let dingModel:TSDingModel? = resultDic["dingModel"] as? TSDingModel
            if dingModel != nil {
                self.dingModel = dingModel!
            }
            let webShowModel:TSWebShowModel? = resultDic["webShowModel"] as? TSWebShowModel
            if webShowModel != nil {
                self.dingModel = dingModel!
            }
            
            finishCallBack()
        }
    }
}

// MARK: - TSRecommendPresent DataSource
extension TSRecommendPresent{

    func numOfSection() -> Int{
        return dingModel.itemTypes.count
    }
    
    func numOfItemsInSection(section:Int) -> Int{
        return 1
    }
    
    func cellForItemAt(collectionView: UICollectionView , indexPath:IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tsDingCellKey, for: indexPath) as! TSDingCell
        cell.contentModels = dingModel.contentModelsAt(indexPath: indexPath)
        cell.dingCellPresent.recommendPresent = self
        return cell
    }
}


// MARK: - TSRecommendPresent FlowLayoutDelegate
extension TSRecommendPresent{

    func itemSize() -> CGSize {
        let width:CGFloat = tsScreenWidth
        let height:CGFloat = tsScreenWidth * 352 / 320
        return CGSize.init(width: width, height: height)
    }
    
    func itemInset() -> UIEdgeInsets{
        return UIEdgeInsetsMake(tsCollectionViewItemSpace, 0, 0, 0)
    }
    
    
//    func itemContentSize() -> CGSize {
//        let width:CGFloat = (itemSize().width - 3 * tsCollectionViewItemSpace)/2
//        let height:CGFloat = itemSize().height / 2
//        return CGSize.init(width: width, height: height)
//    }
//    
//    func itemContentInset() -> UIEdgeInsets{
//        return UIEdgeInsetsMake(0, tsCollectionViewItemSpace, 0, tsCollectionViewItemSpace)
//    }
}
