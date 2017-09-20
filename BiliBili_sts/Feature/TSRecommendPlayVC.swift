//
//  TSRecommendPlayVC.swift
//  BiliBili_sts
//
//  Created by sts on 2017/6/2.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation



class TSRecommendPlayVC: TSViewController {
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reload()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TSLog(message: "")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TSLog(message: "")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        TSLog(message: "")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        TSLog(message: "")
    }
    
    //MARK: - property
    lazy var playView: TSPlayerView = {
        
        let customBmPlayComtroller = TSRecommendCustomBMPlayerControlView()
        customBmPlayComtroller.backBtnClickBlock = {()->() in
            self.backBtnClick()
        }
        
        let pv = TSPlayerView.init(customBMPlayController: customBmPlayComtroller)
        pv.delegate = self
        pv.updateFrameDelegate = self
        return pv
    }()
    
    lazy var playExtensionView: TSPlayerExtraInfoView = {
        let v = TSPlayerExtraInfoView()
        let y = self.view.tsW * 9.0 / 16.0
        let h = self.view.tsH - y
        v.aid  = self.aid
        v.updateFrameDelegate = self
        return v
    }()
    
    //初始化的时候赋值
    var aid:String=""
    
    lazy var recommendPlayPresent: TSRecommendPlayPresent = {
        let p = TSRecommendPlayPresent.init(aid: self.aid)
        return p
    }()
    let playViewHeight:CGFloat = tsScreenWidth * 9.0 / 16.0
}

// MARK: - Event
extension TSRecommendPlayVC{
    
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
            make.top.equalTo(playView.snp.bottom)
            make.left.right.bottom.equalTo(view)
            
        }
        
    }
    
    func reload(){
        recommendPlayPresent.requestData {
            if let url = self.recommendPlayPresent.playerThumbnailUrl {
                self.playView.setupImage(url: url)
            }
            self.playView.setupTitle(aid: self.aid)
            if let videoUrl = self.recommendPlayPresent.videoUrl{
                let title = "AV" + self.aid
                self.playView.setBMPlayerVideo(url:videoUrl,title:title)
            }
        }
    }
    
    func backBtnClick(){
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - TSPlayerViewDelegate
extension TSRecommendPlayVC:TSPlayerViewDelegate{
    func tsPlayerViewBackBtnClick() {
        self.backBtnClick()
    }
}

extension TSRecommendPlayVC:TSUpdateFrameDelegate{
    func tsUpdateHeight(targetView: UIView, addHeight: CGFloat) {
        TSLog(message: "下部滚动高度 :\(addHeight)  ")
        if playView.maskPreView.isHidden {
            return
        }
        let litmitAddHeight = playViewHeight - 65
        //刚好定为 [0,litmitAddHeight] 时快速滚动会出现动画不正常
        if addHeight < -0.5 * litmitAddHeight || addHeight > 1.5 * litmitAddHeight {
            return
        }
        var height = playViewHeight
        
        if addHeight >= 0 && addHeight <= litmitAddHeight {
            height = playViewHeight - addHeight
        }
        else if addHeight < 0 {
            height = playViewHeight
        }
        else{
            height = playViewHeight - litmitAddHeight
        }
        TSLog(message: "播放器高度 \(height)")
        playView.frame = CGRect.init(x: 0, y: 0, width: tsScreenWidth, height: height)
        playExtensionView.frame = CGRect.init(x: 0, y: height, width: tsScreenWidth, height: tsScreenHeight - height)
    }
}
