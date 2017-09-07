//
//  TSBangumiPresent.swift
//  BiliBili_sts
//
//  Created by sts on 2017/9/7.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSBangumiPresent {
 
    var models:[[TSBangumiModel]] = [[TSBangumiModel]]()
    
    var itemSizeArray = [[CGSize]]()
    weak var weakBangumiVC:TSBangumiVC?
}

// MARK: - TSRecommendPresent Network
extension TSBangumiPresent{
    
    /// 刷新数据
    func requestData(finishCallBack:@escaping ()->()) {
 
        TSWebManager.requestBangumiData { (resultDic) in
            self.models = [[TSBangumiModel]]()
            if let bangumiModels = resultDic["bangumiRecommendModels"] as? [TSBangumiModel] {
                //番剧推荐
                let sectionModel = bangumiModels
                self.models.append(sectionModel)
            }
            if let bangumiModels = resultDic["bangumi32Models"] as? [TSBangumiModel] {
                //完结动画
                let sectionModel = bangumiModels
                self.models.append(sectionModel)
            }
            if let bangumiModels = resultDic["bangumi33Models"] as? [TSBangumiModel] {
                //连载动画
                let sectionModel = bangumiModels
                self.models.append(sectionModel)
            }
            if let bangumiModels = resultDic["bangumi51Models"] as? [TSBangumiModel] {
                //资讯
                let sectionModel = bangumiModels
                self.models.append(sectionModel)
            }
            if let bangumiModels = resultDic["bangumi152Models"] as? [TSBangumiModel] {
                //官方延伸
                let sectionModel = bangumiModels
                self.models.append(sectionModel)
            }
            self.initSizeArray()
            finishCallBack()
        }
    }
}

// MARK: - TSRecommendPresent UICollectionViewDelegate
extension TSBangumiPresent{
    ///点击cell 展示视频播放
    func didSelectAt(indexPath:IndexPath,viewcontroller:UIViewController){
        
    }
}

// MARK: - TSRecommendPresent UICollectionViewDataSource
extension TSBangumiPresent{
    
    func numOfSection() -> Int{
        return modelsSectionCount()
    }
    
    func numOfItemsInSection(section:Int) -> Int{
        return 1
    }
    
    func cellForItemAt(collectionView: UICollectionView , indexPath:IndexPath) -> UICollectionViewCell{
        
        guard let model = modelAt(indexPath: indexPath) else {
            fatalError(" indexPath \(indexPath) 错误 ")
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSBangumiSectionCell.tsKey, for: indexPath) as! TSBangumiSectionCell
        cell.model = model 
        return cell
    }
    
    
    //MARK:  对models的处理
    fileprivate func modelsSectionCount()->Int{
        
        return self.models.count
    }
 
    
    fileprivate func modelAt(indexPath:IndexPath) ->[TSBangumiModel]?{
        
        if let model =
            TSCommon.modelAt(index: indexPath.section, models: self.models) as?  [TSBangumiModel]{
            return model
        }
        return nil
    }
    //MARK:  注册cell、view
    func registerCellIn(collectionView:UICollectionView) {
        
        collectionView.register(TSBangumiSectionCell.self, forCellWithReuseIdentifier: TSBangumiSectionCell.tsKey)
 
    }
}


// MARK: - TSRecommendPresent FlowLayoutDelegate
extension TSBangumiPresent{
    
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
            let width:CGFloat = tsScreenWidth - 2 * tsCollectionViewItemSpace
            let height:CGFloat = tsScreenWidth * 230 / 290 - 3 * tsCollectionViewItemSpace + tsCollectionViewItemSpace + 20
            
            itemSizeSectionArray.append( CGSize.init(width: width, height: height))
            self.itemSizeArray.append(itemSizeSectionArray)
        }
        
    }
}

// MARK: - TSRecommendPresent - TSWebShowCellDelegate
//点击轮播图
extension TSBangumiPresent : TSWebShowCellDelegate{
    
    func didSelect(index: Int, linkUrl: String?, imgUrl: String?) {
        if let linkUrlT = linkUrl {
            
        }
    }
}

// MARK: - takeVideoBtnClick
extension TSBangumiPresent {
    func takeVideoBtnClick(sender:UIButton)  {
        //点击后展示 相簿 直播 小视频
        let view = UIApplication.shared.windows.first
        let takeVideoView = TSTakeVideoView.init(frame: UIScreen.main.bounds)
        view?.addSubview(takeVideoView)
    }
}

