//
//  TSPlayerCommentViewController.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/11.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSPlayerCommentView: UIScrollView  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
  
    //MARK:- setup UI & add Constraints
    func setupUI(){
        let tapGes = UITapGestureRecognizer.init(target: self , action: #selector(tapClick(ges:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGes)
        
        self.backgroundColor = UIColor.purple
        self.contentSize = CGSize.init(width: 0, height: 100)
    }
    func tapClick(ges:UITapGestureRecognizer){
        let point = ges.location(in: self)
        TSLog(message: "point is\(point)")
    }

}
