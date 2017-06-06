//
//  TSPlayVC.swift
//  BiliBili_sts
//
//  Created by sts on 2017/6/2.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSPlayVC: UIViewController {
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    lazy var titleView : UIView = {
        let v = UIView()
        return v
    }()

    lazy var backBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(#imageLiteral(resourceName: "video_info_back"), for: UIControlState.normal)
        btn.setImage(#imageLiteral(resourceName: "video_info_back"), for: UIControlState.highlighted)
        return btn
    }()
    
    lazy var moreBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"more_light"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named:"more_light"), for: UIControlState.highlighted)
        return btn
    }()
    
    lazy var <#btnName#>: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"<#imageName#>"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named:"<#imageName#>"), for: UIControlState.highlighted)
        return btn
    }()
    
    
    
    
}

// MARK: - Event
extension TSPlayVC{
    
    func setupUI() {
        
    }
}
