//
//  TSPlayVC.swift
//  BiliBili_sts
//
//  Created by sts on 2017/6/2.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation



class TSPlayVC: UIViewController {
    
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
    //MARK: - property
    lazy var playView: TSPlayerView = {
        let pv = TSPlayerView()
        pv.delegate = self
        return pv
    }()
    
    lazy var playExtensionView: TSPlayerExtraInfoView = {
        let v = TSPlayerExtraInfoView()
        return v
    }()
    
    //初始化的时候赋值
    var aid:String=""
    
    lazy var playPresent: TSPlayPresent = {
        let p = TSPlayPresent.init(aid: self.aid)
        return p
    }()
}

// MARK: - Event
extension TSPlayVC{
    
    func setupUI() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.white
        
        view.addSubview(playView)
        playView.snp.makeConstraints { (make ) in
            make.left.right.top.equalTo(self.view)
            make.height.lessThanOrEqualTo(self.view.snp.height)
            make.height.equalTo(self.view.snp.width).multipliedBy(9.0 / 16.0)
            
        }
        view.addSubview(playExtensionView)
        playExtensionView.snp.makeConstraints { (make ) in
            make.top.equalTo(playExtensionView.snp.bottom)
            make.left.right.bottom.equalTo(view)
            
        }
        
    }
    
    func reload(){
        playPresent.requestData {
            if let url = self.playPresent.playerThumbnailUrl {
                self.playView.setupImage(url: url)
            }
            self.playView.setupTitle(aid: self.aid)
            if let videoUrl = self.playPresent.videoUrl{
                self.playView.setBMPlayerVideo(url: videoUrl, aid: self.aid)
            }
        }
    }
    
    func backBtnClick(){
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - TSPlayerViewDelegate
extension TSPlayVC:TSPlayerViewDelegate{
    func tsPlayerViewBackBtnClick() {
        self.backBtnClick()
    }
}
