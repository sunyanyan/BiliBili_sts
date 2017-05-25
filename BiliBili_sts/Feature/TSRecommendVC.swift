//
//  TSRecommendVC.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/16.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSRecommendVC: UIViewController {
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainCollectionView)
        
        //下拉刷新
        mainCollectionView.tsAddPullToRefreshWithAction {
            self.reload()
        }
        
        mainCollectionView.tsStartPullToRefresh()
    }
    
    func reload(){
        recommendPresent.requestData {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
                self.mainCollectionView.tsStopPullToRefresh()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: - property
    lazy var preloadViewModel: TSPreloadViewModel = {
        return TSPreloadViewModel()
    }()
    
    lazy var mainCollectionView: UICollectionView = {
        
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing =  tsCollectionViewLineSpace// 横排单元格最小间隔
        flowLayout.minimumLineSpacing = tsCollectionViewItemSpace // 单元格最小行间距

        
        let frame = CGRect.init(x: 0, y: 0, width: tsScreenWidth, height: tsScreenHeight - tsTabbarHeight - tsStatusBarHeight - tsPageMenuHeight)
        let cv:UICollectionView = UICollectionView.init(frame: frame, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = tsBackgroundGreyColor
        
        self.recommendPresent.registerCellIn(collectionView: cv)
        
        return cv
    }()
    
    lazy var recommendPresent:TSRecommendPresent = TSRecommendPresent()
    
}
//MARK:- UICollectionViewDataSource
extension TSRecommendVC:UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendPresent.numOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendPresent.numOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return recommendPresent.cellForItemAt(collectionView:collectionView ,indexPath: indexPath)
        
    }

    
}

//MARK:- UICollectionViewDelegate
extension TSRecommendVC:UICollectionViewDelegate{

}

// MARK: - UICollectionViewDelegateFlowLayout
extension TSRecommendVC:UICollectionViewDelegateFlowLayout{
    // 每个item的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return recommendPresent.itemSize(indexPath:indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return recommendPresent.itemInset(section: section)
    }

}
