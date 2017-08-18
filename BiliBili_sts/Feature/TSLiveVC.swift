//
//  、.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/14.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSLiveVC: TSViewController {
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupUI()
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
    
    lazy var mainCollectionView: UICollectionView = {
        
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing =  tsCollectionViewLineSpace// 横排单元格最小间隔
        flowLayout.minimumLineSpacing = tsCollectionViewItemSpace // 单元格最小行间距
        
        
        let frame = CGRect.init(x: 0, y: 0, width: tsScreenWidth, height: tsScreenHeight - tsTabbarHeight - tsStatusBarHeight - tsSlideMenuViewHeight)
        let cv:UICollectionView = UICollectionView.init(frame: frame, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = tsBackgroundGreyColor
        
        self.livePresent.registerCellIn(collectionView: cv)
        
        return cv
    }()
    
    lazy var livePresent:TSLivePresent = {
        let present = TSLivePresent()
//        present.weakRecommendVC = self
        return present
    }()
    
    
}
//MARK:- UICollectionViewDataSource
extension TSLiveVC:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return livePresent.numOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return livePresent.numOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return livePresent.cellForItemAt(collectionView:collectionView ,indexPath: indexPath)
    }
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        return livePresent.headOrFooterViewOfKind(kind: kind, collectionView: collectionView, indexPath: indexPath)
//    }
    
    
}

//MARK:- UICollectionViewDelegate
extension TSLiveVC:UICollectionViewDelegate{
    //点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        livePresent.didSelectAt(indexPath: indexPath, viewcontroller: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TSLiveVC:UICollectionViewDelegateFlowLayout{
    // 每个item的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return livePresent.itemSize(indexPath:indexPath)
    }
    //间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return livePresent.itemInset(section: section)
    }
    //section head size
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return livePresent.headSize(section: section)
//    }
}


// MARK: - EVENT
extension TSLiveVC{
    
    func setupUI(){
        view.addSubview(mainCollectionView)
        
        //下拉刷新
        mainCollectionView.tsAddPullToRefreshWithAction {
            self.reload()
        }
        
        mainCollectionView.tsStartPullToRefresh()
    }
    
    func reload(){
        livePresent.requestData {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
                self.mainCollectionView.tsStopPullToRefresh()
            }
        }
    }
}
