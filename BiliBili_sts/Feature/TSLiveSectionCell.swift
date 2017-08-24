//
//  TSLiveSectionCell.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/22.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
class TSLiveSectionCell: UICollectionViewCell {
    static let tsKey = "TSLiveSectionCell"
    //title
    lazy var titleView : TSLiveSectionCellHeaderView = {
        let t = TSLiveSectionCellHeaderView.init(frame: CGRect.zero)
        return t
    }()
    //四个子cell
    lazy var subCells: [TSLiveContentCellView] = {
        var cells = [TSLiveContentCellView]()
        cells.append(TSLiveContentCellView.init(frame: CGRect.zero))
        cells.append(TSLiveContentCellView.init(frame: CGRect.zero))
        cells.append(TSLiveContentCellView.init(frame: CGRect.zero))
        cells.append(TSLiveContentCellView.init(frame: CGRect.zero))
        return cells
    }()
    //刷新按钮
    lazy var refreshBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"live_refresh"), for: UIControlState.normal)
        btn.addTarget(self , action: #selector(refreshBtnClick(sender:)), for: .touchUpInside)
        return btn
    }()
    //该sectionCell保存的数据
    var model:TSLivePartitionsModel?{
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
        addSubview(refreshBtn)
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
        refreshBtn.snp.updateConstraints { (make ) in
            make.right.bottom.equalTo(self)
            make.width.height.equalTo(50)
        }
    }
    fileprivate func setupModel()  {
        if let titleViewModel = model?.partition {
            titleView.model = titleViewModel
        }
        if let cellModels = model?.lives {
            if let cell4Model = cellModels.tsRandom4Arr() {
                for i in 0  ..< 4  {
                    let model = TSCommon.modelAt(index: i , models: cell4Model) as? TSLiveContentModel
                    let cellView = TSCommon.modelAt(index: i, models: subCells) as? TSLiveContentCellView
                    guard model != nil && cellView != nil else {
                        return
                    }
                    cellView?.contentModel = model
                }
            }
        }
    }
    
    func refreshBtnClick(sender:UIButton) {
        UIView.animate(withDuration: 0.8, animations: {
            sender.transform = sender.transform.rotated(by: 360.0)
            sender.transform = sender.transform.scaledBy(x: 1.2, y: 1.2)
        }) { (bool) in
            sender.transform = CGAffineTransform.identity
        }
    }
}

class TSLiveSectionCellHeaderView:UIView{
    lazy var titleImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "default")
        return iv
    }()
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "绘画专区"
        return lbl
    }()
    lazy var hintLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.textColor = UIColor.lightGray
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "当前729个直播,进去看看"
        return lbl
    }()
    lazy var rightArrowImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "right_arrow")
        return iv
    }()
    var model:TSLivePartitionModel?{
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
        
        addSubview(titleImg)
        addSubview(titleLbl)
        addSubview(hintLbl)
        addSubview(rightArrowImg)
    }
    func setupConstraints(){
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
        
        titleImg.snp.updateConstraints { (make ) in
            make.left.equalTo(self).offset(-2)
            make.top.bottom.equalTo(self)
            make.width.equalTo(20)
        }
        titleLbl.snp.updateConstraints { (make ) in
            make.left.equalTo(titleImg.snp.right).offset(4)
            make.top.bottom.equalTo(self)
            make.width.equalTo(60)
        }
        rightArrowImg.snp.updateConstraints { (make ) in
            make.top.bottom.equalTo(self)
            make.right.equalTo(self).offset(-4)
            make.width.equalTo(20)
        }
        hintLbl.snp.updateConstraints { (make ) in
            make.left.equalTo(titleLbl.snp.right).offset(4)
            make.top.bottom.equalTo(self)
            make.right.equalTo(rightArrowImg.snp.left).offset(-4)
            
        }
    }
    fileprivate func setupModel(){
        if let imgUrl = model?.sub_icon?.src {
            if let url = URL.init(string: imgUrl){
                titleImg.sd_setImage(with: url)
            }
        }
        if let title = model?.name {
            titleLbl.text = title
        }
        if let count = model?.count {
            let text = "当前\(count)个直播,进去看看"
            var mArrText = NSMutableAttributedString.init(string: text)
            let range = NSRange.init(location: 2, length: count.characters.count)
            mArrText.addAttribute(NSForegroundColorAttributeName, value: tsNavTintColor, range: range)
            hintLbl.attributedText = mArrText
        }
    }
}
