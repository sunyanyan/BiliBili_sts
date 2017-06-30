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
        pv.frame = CGRect.init(x: 0, y: 0, width: tsScreenWidth, height: 0.3 * tsScreenHeight)
        return pv
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"video_info_back"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named:"video_info_back"), for: UIControlState.highlighted)
        btn.frame = CGRect.init(x: 8, y: 28, width: 30, height: 30)
        btn.addTarget(self, action: #selector(backBtnClick), for: UIControlEvents.touchUpInside)
        return btn
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
        view.addSubview(backBtn)
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
