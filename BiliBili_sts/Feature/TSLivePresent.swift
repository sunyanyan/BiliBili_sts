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
    
    /// 包含 TSLiveBannerModel / TSLivePartitionsModel
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
                        var sectionModel = [TSBaseModel]()
                        sectionModel.append(liveSectionModel)
                        self.models.append(sectionModel)
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
    ///点击cell 展示直播播放
    func didSelectAt(indexPath:IndexPath,viewcontroller:UIViewController){
        weakLiveVC?.presentFakeLivePlayVC()
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
        else if model is TSLivePartitionsModel{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSLiveSectionCell.tsKey, for: indexPath) as! TSLiveSectionCell
            cell.model = model as? TSLivePartitionsModel
            return cell
        }
        else{
            fatalError(" model 类型异常 ")
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

        collectionView.register(TSLiveSectionCell.self, forCellWithReuseIdentifier: TSLiveSectionCell.tsKey)
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
                else if model is TSLivePartitionsModel{
                    let width:CGFloat = tsScreenWidth - 2 * tsCollectionViewItemSpace
                    let height:CGFloat = tsScreenWidth * 230 / 290 - 3 * tsCollectionViewItemSpace + tsCollectionViewItemSpace + 20
                    
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
            
        }
    }
}

// MARK: - takeVideoBtnClick
extension TSLivePresent: TSTakeVideoViewDelegate{
    func takeVideoBtnClick(sender:UIButton)  {
        //点击后展示 相簿 直播 小视频
        let view = UIApplication.shared.windows.first
        let takeVideoView = TSTakeVideoView.init(frame: UIScreen.main.bounds)
        takeVideoView.delegate = self
        view?.addSubview(takeVideoView)
    }
    
    func liveBtnClick() {
        weakLiveVC?.presentLiveRecordVC()
    }
}

