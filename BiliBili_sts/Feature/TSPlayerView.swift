//
//  TSPlayerView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/6/20.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage
//import ZFPlayer
import BMPlayer

protocol TSPlayerViewDelegate:NSObjectProtocol {
    func tsPlayerViewBackBtnClick()
}

class TSPlayerView:UIView{
    //MARK: - life cycle / init UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        
    }
    //MARK: - property
//    public var backBtnClickBlock:(()->())?
    weak var delegate:TSPlayerViewDelegate?
    
    lazy var maskPreView: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var startBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"player_start"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named:"player_start"), for: UIControlState.highlighted)
        btn.addTarget(self , action: #selector(maskPreViewStartBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"video_info_back"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named:"video_info_back"), for: UIControlState.highlighted)
        btn.frame = CGRect.init(x: 8, y: 28, width: 30, height: 30)
        btn.addTarget(self, action: #selector(backBtnClick), for: UIControlEvents.touchUpInside)
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
    lazy var thumbnailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.image = #imageLiteral(resourceName: "default")
        return iv
    }()
    //模糊效果
    lazy var effectView:UIVisualEffectView = {
        let ev = UIVisualEffectView.init(effect: UIBlurEffect.init(style: UIBlurEffectStyle.extraLight))
        ev.alpha = 0.85
        return ev
    }()
    
    //播放器
    lazy var bmPlayer : BMPlayer = {
        let controlView = TSCustomBMPlayerControlView()
        controlView.backBtnClickBlock = {()->() in
            self.backBtnClick()
        }
        let p = BMPlayer.init(customControlView: controlView)
        
        
        //        let url = URL.init(string: "http://tx.acgvideo.com/c/60/18950093-1.mp4?txTime=1498121786&platform=html5&txSecret=8a3b5a3efd7d5041fc97b19b3012d0d6&oi=3078728740&rate=110000")
        //        let asset = BMPlayerResource.init(url: url!, name: "AV001234", cover: nil, subtitle: nil)
        //        p.setVideo(resource: asset)
        
        return p
    }()
    
    weak var updateFrameDelegate:TSUpdateFrameDelegate?
    
}
//MARK:- TSPlayerView setup UI & add Constraints
extension TSPlayerView{
    
    func setupUI(){
        backgroundColor = UIColor.lightGray
        
        addSubview(bmPlayer)
        addSubview(maskPreView)
        
        maskPreView.addSubview(thumbnailImageView)
        maskPreView.addSubview(effectView)
        maskPreView.addSubview(moreBtn)
        maskPreView.addSubview(startBtn)
        maskPreView.addSubview(titleLabel)
        maskPreView.addSubview(backBtn)

    }
    
    func setupConstraints(){
    
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
    
        bmPlayer.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        maskPreView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        thumbnailImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        effectView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(maskPreView.snp.right).offset(-8)
            make.top.equalTo(15)
            make.width.height.equalTo(40)
        }
        let h = self.tsH / 180 * 50
        let x = self.tsH / 180 * self.tsW - h - 15
        let y = self.tsH - h - 15
        startBtn.snp.updateConstraints { (make) in
//            make.bottom.equalTo(maskPreView.snp.bottom).offset(-15)
            make.top.equalTo(y)
//            make.right.equalTo(maskPreView.snp.right).offset(-15)
            make.left.equalTo(x)
            make.width.height.equalTo(h)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(maskPreView.snp.centerX)
            make.top.equalTo(15)
            make.width.equalTo(maskPreView.snp.width).multipliedBy(0.8)
            make.height.equalTo(40)
        }
        backBtn.snp.makeConstraints { (make ) in
            make.top.equalTo(15)
            make.width.height.equalTo(40)
            make.left.equalTo(maskPreView.snp.left)
        }
    }
    
}

//MARK:- TSPlayerView event
extension TSPlayerView{
    func setupTitle(aid:String){
        let title = "av" + aid
        self.titleLabel.text = title
    }
    func setupImage(url:String){
        let nsURL = URL.init(string: url)
        
        SDWebImageManager.shared().downloadImage(with: nsURL, options: .retryFailed, progress: { (receivedSize, expectedSize) in
            
        }) { (image, error, SDImageCacheTypeNone, finished, imageURL) in
            guard let resultImg = image else {return}
            self.thumbnailImageView.image = resultImg
            self.setNeedsLayout()
        }
    }
    func setBMPlayerVideo(url:String , aid:String) {
        if let nsurl = URL.init(string: url){
            let name = "AV" + aid
            let asset = BMPlayerResource.init(url: nsurl, name: name, cover: nil, subtitle: nil)
            bmPlayer.setVideo(resource: asset)
            bmPlayer.pause()
        }
    }
    //隐藏遮盖图
    func maskPreViewStartBtnClick(){
        maskPreView.isHidden = true
        bmPlayer.play()
    }
    //返回按钮点击
    func backBtnClick(){
    
        if let del  = updateFrameDelegate {
            if let action  = del.tsUpdateHeight {
                action(self,0)
            }
        }
    
        if let d  = delegate {
            d.tsPlayerViewBackBtnClick()
        }
    }
}

/// 修改原有播放器样式
class TSCustomBMPlayerControlView:BMPlayerControlView{

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
