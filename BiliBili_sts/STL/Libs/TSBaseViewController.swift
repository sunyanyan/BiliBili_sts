//
//  TSBaseViewController.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/22.
//  Copyright © 2017年 sts. All rights reserved.
//

import UIKit
class TSBaseViewController: UIViewController {
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        TSLog(message: "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        TSLog(message: "")
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    deinit {
        TSLog(message: self.description)
    }
    
}

