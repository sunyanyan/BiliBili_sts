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
    var models:[[TSBaseModel]] = [[TSBaseModel]]()
    
    var itemSizeArray = [[CGSize]]()
//    var itemInsetArray =  [UIEdgeInsets]()
    
    weak var weakRecommendVC:TSRecommendVC?
    

}

// MARK: - TSRecommendPresent Network 
extension TSRecommendPresent{

    func requestData(finishCallBack:@escaping ()->()) {
        
        TSWebManager.requestRecommandData { (resultDic) in
            
            var sectionModels = [TSBaseModel]()
            
            if let webShowModel:TSWebShowModel = resultDic["webShowModel"] as? TSWebShowModel{
                self.webShowModel = webShowModel
                if self.models.count <= 1 {
                    sectionModels.append(webShowModel)
                }
            }
            if let dingModel:TSDingModel =  resultDic["dingModel"] as? TSDingModel{
                self.dingModel = dingModel
                if self.models.count <= 1 {//第一次获取数据往后插入
                    for model in dingModel.random4ContentModels(){
                        sectionModels.append(model)
                    }
                }
                else{//获取数据往后插入
                    for model in dingModel.random4ContentModels(){
                        sectionModels.insert(model, at: 0)
                    }
                }
                
            }
            if sectionModels.count >= 1 {
                self.models.insert(sectionModels, at: 0)
            }
            
            self.initSizeArray()
            finishCallBack()
        }
    }
}

// MARK: - TSRecommendPresent UICollectionViewDelegate
extension TSRecommendPresent{
    func didSelectAt(indexPath:IndexPath,viewcontroller:UIViewController){
        
        guard let model = modelAt(indexPath: indexPath) else {
            fatalError(" indexPath \(indexPath) 错误 ")
        }
        
        if model is TSWebShowModel {
            
        }
        else if model is TSDingContentModel{
            
        }
        else{
            fatalError(" model 类型异常 ")
        }
    }
}

// MARK: - TSRecommendPresent UICollectionViewDataSource
extension TSRecommendPresent{

    func numOfSection() -> Int{
        return modelsSectionCount()
    }
    
    func numOfItemsInSection(section:Int) -> Int{
        return modelItemCountAt(section:section)
    }
    
    func cellForItemAt(collectionView: UICollectionView , indexPath:IndexPath) -> UICollectionViewCell{
        
        guard let model = modelAt(indexPath: indexPath) else {
            fatalError(" indexPath \(indexPath) 错误 ")
        }
 
        if model is TSWebShowModel {
            //TSWebShowCell 包含一个轮播图
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSWebShowCell.TSWebShowCellKey, for: indexPath) as! TSWebShowCell
            cell.contentModels = (model as! TSWebShowModel).data
            cell.delegate = self
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
    }
    
    func headOrFooterViewOfKind(kind :String,collectionView:UICollectionView, indexPath:IndexPath) ->UICollectionReusableView{
        
        if kind == UICollectionElementKindSectionHeader {
            let head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: TSRecommendHeadView.tsRecommendHeadViewKey, for: indexPath)
            
            return head
        }
        else{
            fatalError(" 不应该有 footer view ")
        }
    
    }
    
    //MARK:  对models的处理
    fileprivate func modelsSectionCount()->Int{
        
        return self.models.count
    }
    
    fileprivate func modelItemCountAt(section:Int) ->Int{
        if TSCommon.isVaild(section: section, models: self.models) {
            return self.models[section].count
        }
        return 0
    }
    
    fileprivate func modelAt(indexPath:IndexPath) ->TSBaseModel?{
        
        if let model =
            TSCommon.modelAt(indexPath: indexPath, models: self.models) as?TSBaseModel {
            return model
        }
        return nil
    }
    //MARK:  注册cell、view
    func registerCellIn(collectionView:UICollectionView) {
        collectionView.register(TSDingCell.self, forCellWithReuseIdentifier: TSDingCell.tsDingCellKey)
        collectionView.register(TSDingContentCell.self, forCellWithReuseIdentifier: TSDingContentCell.tsDingContentCellKey)
        collectionView.register(TSWebShowCell.self, forCellWithReuseIdentifier: TSWebShowCell.TSWebShowCellKey)
        
        collectionView.register(TSRecommendHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: TSRecommendHeadView.tsRecommendHeadViewKey)
        
    }
}


// MARK: - TSRecommendPresent FlowLayoutDelegate
extension TSRecommendPresent{

    func itemSize(indexPath:IndexPath) -> CGSize {
        
        if let size = TSCommon.modelAt(indexPath: indexPath, models: self.itemSizeArray) as? CGSize{
            return size
        }
        
        return CGSize.zero

    }
    
    func itemInset(section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(tsCollectionViewLineSpace, tsCollectionViewItemSpace, 0, tsCollectionViewItemSpace)
    }
    
    func headSize(section: Int) -> CGSize {
        return CGSize.init(width: tsScreenWidth, height: 30)
    }
    
    /// 计算item size
    func initSizeArray(){
        self.itemSizeArray = [[CGSize]]()
        
        for sectionModels in models {
            var itemSizeSectionArray = [CGSize]()
            for model in sectionModels {
                if model is TSWebShowModel {
                    
                    let width:CGFloat = tsScreenWidth -  2 * tsCollectionViewItemSpace
                    let height:CGFloat = width * 100 / 320
                    
                    itemSizeSectionArray.append( CGSize.init(width: width, height: height))
                    
                }
                else if model is TSDingContentModel{
                    let width:CGFloat = (tsScreenWidth - 3 * tsCollectionViewItemSpace)/2
                    let height:CGFloat = (tsScreenWidth * 352 / 320 - 3 * tsCollectionViewItemSpace)/2
                    
                    itemSizeSectionArray.append( CGSize.init(width: width, height: height))
                }
                else{
                    fatalError(" model 类型异常 ")
                }
            }
            self.itemSizeArray.append(itemSizeSectionArray)
        }

    }
}

// MARK: - TSRecommendPresent - TSWebShowCellDelegate
//点击轮播图
extension TSRecommendPresent : TSWebShowCellDelegate{
    func didSelectAtIndex(index:Int ,model:TSWebShowContentModel, imgUrl:String?){
        TSLog(message: " index \(index) model \(model) imgUrl \(String(describing: imgUrl))")
        

        let url:String? = model.url
        let homeVc:TSHomeVC? = weakRecommendVC?.parent?.view.superview?.next as? TSHomeVC
        
        if (url != nil) && (homeVc != nil) {
            
            homeVc?.presentWebVC(url: url!)
            
        }
    }
}

