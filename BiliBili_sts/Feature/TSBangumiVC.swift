//
//  TSBangumiVC.swift
//  BiliBili_sts
//
//  Created by sts on 2017/9/7.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSBangumiVC: TSViewController {
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
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
        
        self.bangumiPresent.registerCellIn(collectionView: cv)
        
        return cv
    }()
 
    lazy var bangumiPresent:TSBangumiPresent = {
        let present = TSBangumiPresent()
        //        present.weakRecommendVC = self
        return present
    }()
    
    
}
//MARK:- UICollectionViewDataSource
extension TSBangumiVC:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  bangumiPresent.numOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  bangumiPresent.numOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return  bangumiPresent.cellForItemAt(collectionView:collectionView ,indexPath: indexPath)
    }
    
}

//MARK:- UICollectionViewDelegate
extension TSBangumiVC:UICollectionViewDelegate{
    //点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
         bangumiPresent.didSelectAt(indexPath: indexPath, viewcontroller: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TSBangumiVC:UICollectionViewDelegateFlowLayout{
    // 每个item的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return  bangumiPresent.itemSize(indexPath:indexPath)
    }
    //间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  bangumiPresent.itemInset(section: section)
    }
}


// MARK: - EVENT
extension TSBangumiVC{
    
    func setupUI(){
        view.addSubview(mainCollectionView)
        //下拉刷新
        mainCollectionView.tsAddPullToRefreshWithAction {
            self.reload()
        }
        mainCollectionView.tsStartPullToRefresh()
 
    }
    
    func setupConstraints(){
        
        let contentView:UIView! = self.view
        
        mainCollectionView.snp.updateConstraints { (make ) in
            make.left.top.width.height.equalTo(contentView)
        }
    }
    
    func reload(){
         bangumiPresent.requestData {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
                self.mainCollectionView.tsStopPullToRefresh()
            }
        }
    }
 
}
