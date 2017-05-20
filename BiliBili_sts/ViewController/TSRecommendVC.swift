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
        
        _ = TSPreloadViewModel.localPreloadModel()
        self.view.addSubview(mainCollectionView)
        
        TSDingViewModel().requestData(finishCallBack: { 
            
        }, failueCallBack: {
            
            
        })
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
        flowLayout.minimumInteritemSpacing = tsCollectionViewItemSpace// 横排单元格最小间隔
        flowLayout.minimumLineSpacing = tsCollectionViewLineSpace // 单元格最小行间距
        
        let cv:UICollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        
        cv.register(TSDingCell.self, forCellWithReuseIdentifier: "TSDingCellKey")
        
        return cv
    }()
    
}
//MARK:- UICollectionViewDataSource
extension TSRecommendVC:UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TSDingCellKey", for: indexPath) as! TSDingCell
        return cell
        
    }
    
}

//MARK:- UICollectionViewDelegate
extension TSRecommendVC:UICollectionViewDelegate{

}
