//
//  TSRecommendCustomBMPlayerControlView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/9/12.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
import BMPlayer

/// 推荐页播放器样式
class TSLiveCustomBMPlayerControlView:BMPlayerControlView{
    
    lazy var bPlayBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"player_start"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named:"player_pause"), for: UIControlState.selected)
        btn.tag = BMPlayerControlView.ButtonType.play.rawValue
        btn.addTarget(self, action: #selector(onButtonPressed(_:)), for: .touchUpInside)
        return btn
    }()
    func backBtnClick(){
        
        if !isFullScreen {
            if let block = backBtnClickBlock {
                block()
            }
        }
        onButtonPressed(backButton)
    }
    public  var backBtnClickBlock:(()->())?
    
    //MARK: override
    override func customizeUIComponents() {
        //修改backBtn的图片
        self.backButton.setImage(UIImage.init(named: "video_info_back"), for: .normal)
        self.backButton.removeTarget(self , action: #selector(onButtonPressed(_:)), for: .touchUpInside)
        self.backButton.addTarget(self, action: #selector(backBtnClick), for: UIControlEvents.touchUpInside)
        
        //添加bilibilli的播放按钮
        mainMaskView.addSubview(bPlayBtn)
        bPlayBtn.snp.makeConstraints { (make ) in
            make.right.equalTo(mainMaskView).offset(-8)
            make.bottom.equalTo(bottomMaskView.snp.top)
            make.width.height.equalTo(50)
        }
        
        //隐藏 时间进度条
        self.timeSlider.isHidden = true
        self.currentTimeLabel.isHidden = true
        self.totalTimeLabel.isHidden = true
        
    }
    override func playStateDidChange(isPlaying: Bool) {
        super.playStateDidChange(isPlaying: isPlaying)
        bPlayBtn.isSelected = isPlaying
    }
    
    override func playerStateDidChange(state: BMPlayerState) {
        super.playerStateDidChange(state: state)
        
        if state == BMPlayerState.playedToTheEnd {
            bPlayBtn.isSelected = false
        }
    }
    override func controlViewAnimation(isShow: Bool) {
        super.controlViewAnimation(isShow: isShow)
        
        let alpha:CGFloat = isShow ? 1.0: 0.0;
        UIView.animate(withDuration: 0.3) {
            self.bPlayBtn.alpha = alpha;
        }
    }
    
    fileprivate var isFullScreen:Bool {
        get {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
}
