//
//  TSButtonLabelView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/24.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

/// 左边按钮 右边文字
class TSButtonLabelView:UIView{
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- property
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"share"), for: UIControlState.normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    lazy var detailLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.red
        lbl.font = .systemFont(ofSize: 10)
        return lbl
    }()
    //MARK: - setup UI
    func setupUI () {
        addSubview(btn)
        addSubview(detailLbl)
        addConstraints()
    }
    func addConstraints() {
        btn.snp.makeConstraints { (make ) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
        }
        detailLbl.snp.makeConstraints { (make ) in
            make.right.top.bottom.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
            
        }
    }
    //MARK: - event
    func setupImage(image:UIImage, title:String){
        btn.setImage(image, for: UIControlState.normal)
        detailLbl.text = title
        
        //        image.getPaletteImageColor { (recommendColorModel, allModeColorDic, error) in
        //            if let colorHexString:String = recommendColorModel?.imageColorString {
        //                self.detailLbl.textColor = UIColor.hexString(hex: colorHexString)
        //            }
        //        }
    }
    
}
