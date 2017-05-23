//
//  TSHomeNC.swift
//  BiliBili
//
//  Created by sts on 2017/5/11.
//  Copyright © 2017年 sts. All rights reserved.
//

import UIKit

class TSHomeNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: animated)
    }
}
