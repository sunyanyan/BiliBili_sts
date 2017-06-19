//
//  TSPlayVC.swift
//  BiliBili_sts
//
//  Created by sts on 2017/6/2.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

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
    lazy var playView: TSPlayerView = {
        let pv = TSPlayerView()
        pv.frame = CGRect.init(x: 0, y: 0, width: tsScreenWidth, height: 0.3 * tsScreenHeight)
        return pv
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"video_info_back"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named:"video_info_back"), for: UIControlState.highlighted)
        btn.frame = CGRect.init(x: 8, y: 8, width: 40, height: 40)
        return btn
    }()
    
}

// MARK: - Event
extension TSPlayVC{
    
    func setupUI() {
        self.navigationController?.navigationBar.isHidden = true
        view.addSubview(playView)
        view.addSubview(backBtn)
    }
}


class TSPlayerView:UIView{
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        addSubview(moreBtn)
        addSubview(startBtn)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-8)
            make.top.equalTo(self.snp.top).offset(8)
            make.width.height.equalTo(40)
        }
        
        startBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
            make.width.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(40)
        }
    }
    //MARK: - property
    lazy var startBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"player_start"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named:"player_start"), for: UIControlState.highlighted)
        return btn
    }()
    
    lazy var moreBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"more_light"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named:"more_light"), for: UIControlState.highlighted)
        return btn
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = UIColor.white
        lbl.font = .systemFont(ofSize: 12)
        return lbl
    }()
}
