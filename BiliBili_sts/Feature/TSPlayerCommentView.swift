//
//  TSPlayerCommentViewController.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/11.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSPlayerCommentView: UIView  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- property
    lazy var someBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.system)
        btn.setImage(UIImage.init(named:"rank_entrance"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named:"rank_entrance"), for: UIControlState.highlighted)
        btn.addTarget(self , action: #selector(someBtnClick), for: .touchUpInside)
        return btn
    }()
    
    func someBtnClick(){
        print(" someBtnClick ")
    }
    
    //MARK:- setup UI & add Constraints
    func setupUI(){
        backgroundColor = UIColor.green
        addSubview(someBtn)
        addConstraints()
    }
    func addConstraints(){
        someBtn.snp.makeConstraints { (make ) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(150)
        }
    }
}
