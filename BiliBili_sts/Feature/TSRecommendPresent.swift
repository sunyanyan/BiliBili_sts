//
//  TSRecommendPresent.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/20.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

/// TSRecommendPresent - property
class TSRecommendPresent {
    
    /// 区置顶数据
    var dingModel:TSDingModel = TSDingModel()
    /// 滚动推荐数据
    var webShowModel:TSWebShowModel = TSWebShowModel()
    
    /// 包含 TSWebShowModel / TSDingContentModel
    var models:[TSBaseModel] = [TSBaseModel]()
    
    var itemSizeArray = [CGSize]()
//    var itemInsetArray =  [UIEdgeInsets]()
    
    func registerCellIn(collectionView:UICollectionView) {
        collectionView.register(TSDingCell.self, forCellWithReuseIdentifier: TSDingCell.tsDingCellKey)
        collectionView.register(TSDingContentCell.self, forCellWithReuseIdentifier: TSDingContentCell.tsDingContentCellKey)
        collectionView.register(TSWebShowCell.self, forCellWithReuseIdentifier: TSWebShowCell.TSWebShowCellKey)

    }
    

}

// MARK: - TSRecommendPresent Network
extension TSRecommendPresent{

    func requestData(finishCallBack:@escaping ()->()) {
        
        TSWebManager.requestRecommandData { (resultDic) in
            if let dingModel:TSDingModel =  resultDic["dingModel"] as? TSDingModel{
                self.dingModel = dingModel
                for model in dingModel.random4ContentModels(){
                    self.models.append(model)
                }
            }
            if let webShowModel:TSWebShowModel = resultDic["webShowModel"] as? TSWebShowModel{
                self.webShowModel = webShowModel
                self.models.append(webShowModel)
            }
            self.initSizeArray()
            finishCallBack()
        }
    }
}

// MARK: - TSRecommendPresent DataSource
extension TSRecommendPresent{

    func numOfSection() -> Int{
        return 1
    }
    
    func numOfItemsInSection(section:Int) -> Int{
        return models.count
    }
    
    func cellForItemAt(collectionView: UICollectionView , indexPath:IndexPath) -> UICollectionViewCell{
        
//        let section = indexPath.section
        let row = indexPath.row
        let model = models[row]
        if model is TSWebShowModel {
            //TSWebShowCell 包含一个轮播图
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSWebShowCell.TSWebShowCellKey, for: indexPath) as! TSWebShowCell
            cell.contentModels = (model as! TSWebShowModel).data
            return cell
        }
        else if model is TSDingContentModel{
            //TSDingCell 包含一个 UICollectionView展示各个区的具体数据
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSDingContentCell.tsDingContentCellKey, for: indexPath) as! TSDingContentCell
            cell.contentModel = model as? TSDingContentModel
            return cell
        }
        else{
            fatalError(" model 类型异常 ")
        }
//        
//        if section == 0 {
//            //TSWebShowCell 包含一个轮播图
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSWebShowCell.TSWebShowCellKey, for: indexPath) as! TSWebShowCell
//            cell.contentModels = webShowModel.data
//            return cell
//        }
//        else{
//            //TSDingCell 包含一个 UICollectionView展示各个区的具体数据
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSDingCell.tsDingCellKey, for: indexPath) as! TSDingCell
//            cell.contentModels = dingModel.contentModelsAt(index: indexPath.row)
//            cell.dingCellPresent.recommendPresent = self
//            return cell
//            
//        }
    }
}


// MARK: - TSRecommendPresent FlowLayoutDelegate
extension TSRecommendPresent{

    func itemSize(indexPath:IndexPath) -> CGSize {        
        let row = indexPath.row
        return self.itemSizeArray[row]
    }
    
    func itemInset(section: Int) -> UIEdgeInsets{
//        let row = indexPath.row
//        return self.itemInsetArray[row]
        return UIEdgeInsetsMake(tsCollectionViewLineSpace, tsCollectionViewItemSpace, 0, tsCollectionViewItemSpace)
    }
    
    func initSizeArray(){
        for model in models {
            if model is TSWebShowModel {
                let width:CGFloat = tsScreenWidth
                let height:CGFloat = tsScreenWidth * 100 / 320
                self.itemSizeArray.append( CGSize.init(width: width, height: height))
                
//                self.itemInsetArray.append(UIEdgeInsetsMake(tsCollectionViewLineSpace, 0, 0, 0))
            }
            else if model is TSDingContentModel{
                let width:CGFloat = (tsScreenWidth - 3 * tsCollectionViewItemSpace)/2
                let height:CGFloat = (tsScreenWidth * 352 / 320 - 3 * tsCollectionViewItemSpace)/2
                self.itemSizeArray.append( CGSize.init(width: width, height: height))
//                
//                self.itemInsetArray.append(UIEdgeInsetsMake(tsCollectionViewLineSpace, tsCollectionViewItemSpace, 0, tsCollectionViewItemSpace))
            }
            else{
                fatalError(" model 类型异常 ")
            }
            
        }
    }
}
