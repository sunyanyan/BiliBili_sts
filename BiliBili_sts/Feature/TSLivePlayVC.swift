//
//  TSLivePlayVC.swift
//  BiliBili_sts
//
//  Created by sts on 2017/9/12.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class TSLivePlayVC : TSViewController {
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        reload()
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
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        // setupConstraints
    }
    
    //MARK: - property
    lazy var playView: TSPlayerView = {
        
        let customBmPlayComtroller = TSLiveCustomBMPlayerControlView()
        customBmPlayComtroller.backBtnClickBlock = {()->() in
            self.backBtnClick()
        }
    
        let pv = TSPlayerView.init(customBMPlayController: customBmPlayComtroller)
        pv.delegate = self
        return pv
    }()
    
}

// MARK: - Event
extension TSLivePlayVC {


    func setupUI() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.white
        
        view.addSubview(playView)
        playView.snp.makeConstraints { (make ) in
            make.left.right.top.equalTo(self.view)
            make.height.lessThanOrEqualTo(self.view.snp.height)
            make.height.equalTo(self.view.snp.width).multipliedBy(9.0 / 16.0)
            
        }

    }
    
    func reload(){
        let liveUrl = "http://localhost:8080/hls/abc.m3u8"
        self.playView.setBMPlayerVideo(url: liveUrl, title: "直播模拟")
    }

    func backBtnClick(){
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - TSPlayerViewDelegate
extension TSLivePlayVC:TSPlayerViewDelegate{
    func tsPlayerViewBackBtnClick() {
        self.backBtnClick()
    }
}
