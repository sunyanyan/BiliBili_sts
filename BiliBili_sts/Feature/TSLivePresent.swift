//
//  TSLivePresent.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/14.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSLivePresent {
    
    /// 包含 [TSLiveBannerModel] / [TSLivePartitionsModel]
    var models:[[TSBaseModel]] = [[TSBaseModel]]()
    
    var itemSizeArray = [[CGSize]]()
    //    var itemInsetArray =  [UIEdgeInsets]()
    weak var weakLiveVC:TSLiveVC?
    
}

// MARK: - TSRecommendPresent Network
extension TSLivePresent{
    
    /// 刷新数据
    func requestData(finishCallBack:@escaping ()->()) {
        
        TSWebManager.requestLiveData { (resultDic) in
            self.models = [[TSBaseModel]]()
            if let liveModel = resultDic["liveModel"] as? TSLiveModel {
                //滚动推荐
                if let scrollModel = liveModel.data {
                    
                    var sectionModel = [TSBaseModel]()
                    sectionModel.append(scrollModel)
                    self.models.append(sectionModel)
                }
                //各个区直播
                if let liveSectionModels = liveModel.data?.partitions {
                    for liveSectionModel in liveSectionModels {
                        if let liveContentModels = liveSectionModel.lives {
                            var sectionModel = [TSBaseModel]()
                            for liveContentModel in liveContentModels {
                                sectionModel.append(liveContentModel)
                            }
                            self.models.append(sectionModel)
                        }
                    }
                }
            }
            self.initSizeArray()
            finishCallBack()
        }
    }
}

// MARK: - TSRecommendPresent UICollectionViewDelegate
extension TSLivePresent{
    ///点击cell 展示视频播放
    func didSelectAt(indexPath:IndexPath,viewcontroller:UIViewController){
        
//        guard let model = modelAt(indexPath: indexPath) else {
//            fatalError(" indexPath \(indexPath) 错误 ")
//        }
//        if model is TSDingContentModel{
//            guard let videoId = (model as! TSDingContentModel ).aid else { return }
////            weakLiveVC?.presentPlayVC(aid:videoId)
//        }
//        else{
//            fatalError(" model 类型异常 ")
//        }
    }
}

// MARK: - TSRecommendPresent UICollectionViewDataSource
extension TSLivePresent{
    
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
        
        if model is TSLiveDataModel {
            //TSLiveDataModel.banner 包含一个轮播图
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSWebShowCell.TSWebShowCellKey, for: indexPath) as! TSWebShowCell
            cell.contentModels = (model as! TSLiveDataModel).banner
            cell.webCellSelectDelegate = self
            return cell
        }
        else if model is TSLiveContentModel{
            //TSLiveContentModel 包含一个 UICollectionView展示各个区的具体数据
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSLiveContentCell.tsLiveContentCellKey, for: indexPath) as! TSLiveContentCell
            cell.contentModel = model as? TSLiveContentModel
            return cell
        }
        else{
            fatalError(" model 类型异常 ")
        }
    }
    
//    func headOrFooterViewOfKind(kind :String,collectionView:UICollectionView, indexPath:IndexPath) ->UICollectionReusableView{
//        
//        if kind == UICollectionElementKindSectionHeader {
//            fatalError(" 不应该有 header view ")
//        }
//        else{
//            fatalError(" 不应该有 footer view ")
//        }
//        
//    }
    
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

        collectionView.register(TSLiveContentCell.self, forCellWithReuseIdentifier: TSLiveContentCell.tsLiveContentCellKey)
        collectionView.register(TSWebShowCell.self, forCellWithReuseIdentifier: TSWebShowCell.TSWebShowCellKey)
    }
}


// MARK: - TSRecommendPresent FlowLayoutDelegate
extension TSLivePresent{
    
    func itemSize(indexPath:IndexPath) -> CGSize {
        if let size = TSCommon.modelAt(indexPath: indexPath, models: self.itemSizeArray) as? CGSize{
            return size
        }
        return CGSize.zero
        
    }
    
    func itemInset(section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(tsCollectionViewLineSpace, tsCollectionViewItemSpace, 0, tsCollectionViewItemSpace)
    }
    
    /// 计算item size
    func initSizeArray(){
        self.itemSizeArray = [[CGSize]]()
        
        for sectionModels in models {
            var itemSizeSectionArray = [CGSize]()
            for model in sectionModels {
                if model is TSLiveDataModel {
                    
                    let width:CGFloat = tsScreenWidth -  2 * tsCollectionViewItemSpace
                    let height:CGFloat = width * 100 / 320
                    
                    itemSizeSectionArray.append( CGSize.init(width: width, height: height))
                    
                }
                else if model is TSLiveContentModel{
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
extension TSLivePresent : TSWebShowCellDelegate{

    func didSelect(index: Int, linkUrl: String?, imgUrl: String?) {
        if let linkUrlT = linkUrl {
//            weakRecommendVC?.presentWebVC(url: linkUrlT)
        }
    }
}

