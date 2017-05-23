//
//  TSDingCell.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/18.
//  Copyright © 2017年 sts. All rights reserved.
//

import UIKit
import SnapKit


class TSDingCell: UICollectionViewCell {
    //MARK: - Property
    
    public lazy var dingCellPresent:TSDingCellPresent = TSDingCellPresent()
    
    lazy var mainCollectionView: UICollectionView = {
        
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing =   tsCollectionViewItemSpace// 横排单元格最小间隔
        flowLayout.minimumLineSpacing = tsCollectionViewLineSpace // 单元格最小行间距
        
        let frame = CGRect.init(x: 0, y: 0, width: tsScreenWidth, height: tsScreenHeight - tsTabbarHeight - tsStatusBarHeight - tsNavBarHeight)
        let cv:UICollectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor.white
        
        self.dingCellPresent.registerCellIn(collectionView:cv)
        
        return cv
    }()
    
    var contentModels:[TSDingContentModel]?{
        didSet{
            setupModel()
        }
    }
    
    //MARK: - override
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(mainCollectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    //MARK:- private method
    func setupModel(){
        if self.contentModels != nil {
            dingCellPresent.contentModels = self.contentModels!
        }
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension TSDingCell:UICollectionViewDelegate{

}

// MARK: - UICollectionViewDataSource
extension TSDingCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dingCellPresent.numOfItemsInSection(section: section)
 
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return dingCellPresent.cellForItemAt(collectionView:collectionView, indexPath:indexPath)
    }
}

extension TSDingCell :UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dingCellPresent.itemSize()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return dingCellPresent.itemInset()
    }
}

