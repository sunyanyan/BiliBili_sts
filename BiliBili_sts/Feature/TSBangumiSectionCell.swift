//
//  TSBangumiSectionCell.swift
//  BiliBili_sts
//
//  Created by sts on 2017/9/7.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
class TSBangumiSectionCell: UICollectionViewCell {
    static let tsKey = "TSBangumiSectionCell"
    //title
    lazy var titleView : TSBangumiSectionCellHeaderView = {
        let t = TSBangumiSectionCellHeaderView.init(frame: CGRect.zero)
        return t
    }()
    //四个子cell
    lazy var subCells: [TSBangumiContentCellView] = {
        var cells = [TSBangumiContentCellView]()
        cells.append(TSBangumiContentCellView.init(frame: CGRect.zero))
        cells.append(TSBangumiContentCellView.init(frame: CGRect.zero))
        cells.append(TSBangumiContentCellView.init(frame: CGRect.zero))
        cells.append(TSBangumiContentCellView.init(frame: CGRect.zero))
        return cells
    }()
 
    //该sectionCell保存的数据
    var model:[TSBangumiModel]?{
        didSet{
            setupModel()
        }
    }
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    //MARK: - setup UI
    func setupUI () {
        
        addSubview(titleView)
        for view  in subCells {
            addSubview(view)
        }
 
    }
    func setupConstraints(){
        let viewWidth = self.tsW
        let viewHeight = self.tsH
        if viewWidth == 0 {return}
        
        titleView.snp.updateConstraints { (make ) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(20)
        }
        for i  in 0..<4 {
            let w = (viewWidth - tsCollectionViewItemSpace)/2
            let h = (viewHeight - tsCollectionViewItemSpace - 20)/2
            let x = ( i % 2 == 0 ) ? 0 : w + tsCollectionViewItemSpace
            let y = ( i < 2 ) ? 24 : h + tsCollectionViewItemSpace + 24
            let cell = subCells[i]
            cell.snp.updateConstraints({ (make ) in
                make.left.equalTo(self).offset(x)
                make.top.equalTo(self).offset(y)
                make.width.equalTo(w)
                make.height.equalTo(h)
            })
        }
 
    }
    fileprivate func setupModel()  {
 
        if let cellModels = self.model {
            if let cell4Model = cellModels.tsRandom4Arr() {
                for i in 0  ..< 4  {
                    let cellModel = TSCommon.modelAt(index: i , models: cell4Model) as? TSBangumiModel
                    let cellView = TSCommon.modelAt(index: i, models: subCells) as? TSBangumiContentCellView
                    guard cellModel != nil && cellView != nil else {
                        return
                    }
                    cellView?.contentModel = cellModel
                }
            }
        }
    }
 
 
}

class TSBangumiSectionCellHeaderView:UIView{
 
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "番剧"
        return lbl
    }()
    lazy var hintLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.textColor = UIColor.lightGray
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "查看更多>>"
        return lbl
    }()
 
 
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    
    //MARK: - setup UI
    func setupUI () {
 
        addSubview(titleLbl)
        addSubview(hintLbl)
 
    }
    func setupConstraints(){
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
 
        titleLbl.snp.updateConstraints { (make ) in
            make.left.equalTo(self.snp.left).offset(4)
            make.top.bottom.equalTo(self)
            make.width.equalTo(60)
        }
 
        hintLbl.snp.updateConstraints { (make ) in
            make.left.equalTo(titleLbl.snp.right).offset(4)
            make.top.bottom.equalTo(self)
            make.right.equalTo(self.snp.right).offset(-4)
            
        }
    }
}
