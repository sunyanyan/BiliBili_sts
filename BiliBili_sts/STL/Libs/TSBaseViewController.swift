//
//  TSBaseViewController.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/22.
//  Copyright © 2017年 sts. All rights reserved.
//

import UIKit
class TSViewController: UIViewController {
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        TSLog(message: self.description)
    }
    required init?(coder aDecoder: NSCoder) {
        TSLog(message: "")
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        TSLog(message: self.description)
    }
    
}

class TSTabBarController:UITabBarController{
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        TSLog(message: self.description)
    }
    required init?(coder aDecoder: NSCoder) {
        TSLog(message: "")
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        TSLog(message: self.description)
    }
}

class TSView:UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        TSLog(message: self.description)
    }
    
    required init?(coder aDecoder: NSCoder) {
        TSLog(message: "")
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        TSLog(message: self.description)
    }
}
