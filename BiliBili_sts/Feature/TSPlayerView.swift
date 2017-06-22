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
import ZFPlayer

class TSPlayerView:UIView{
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        
        addSubview(zfPlayerView)
        addSubview(maskPreView)
        maskPreView.addSubview(thumbnailImageView)
        maskPreView.addSubview(effectView)
        maskPreView.addSubview(moreBtn)
        maskPreView.addSubview(startBtn)
        maskPreView.addSubview(titleLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        zfPlayerView.snp.makeConstraints { (make) in
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
            make.top.equalTo(maskPreView.snp.top).offset(8)
            make.width.height.equalTo(40)
        }
        
        startBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(maskPreView.snp.bottom).offset(-15)
            make.right.equalTo(maskPreView.snp.right).offset(-15)
            make.width.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(maskPreView.snp.centerX)
            make.top.equalTo(maskPreView.snp.top).offset(8)
            make.width.equalTo(maskPreView.snp.width).multipliedBy(0.8)
            make.height.equalTo(40)
        }
    }
    //MARK: - property
    lazy var maskPreView: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var startBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.setImage(UIImage.init(named:"player_start"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named:"player_start"), for: UIControlState.highlighted)
        btn.addTarget(self , action: #selector(maskPreViewStartBtnClick), for: UIControlEvents.touchUpInside)
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
        let ev = UIVisualEffectView.init(effect: UIBlurEffect.init(style: UIBlurEffectStyle.dark))
        ev.alpha = 0.95
        return ev
    }()
    
    //播放器
    lazy var zfplayerModel: ZFPlayerModel = {
        let m = ZFPlayerModel()
        let url = URL.init(string: "http://tx.acgvideo.com/7/b6/18824192-1.mp4?txTime=1498102965&platform=html5&txSecret=1c45a3a39761a804116a1bb5018e6fa8&oi=3078728740&rate=110000")
        m.videoURL = url
        m.title = "AV0000001"
        m.fatherView = self
        return m
    }()
    
    lazy var zfPlayerViewControlView: ZFPlayerControlView = {
        let vc = ZFPlayerControlView()
        return vc
    }()
    
    lazy var zfPlayerView: ZFPlayerView = {
        let p = ZFPlayerView()
        p.playerControlView(self.zfPlayerViewControlView, playerModel: self.zfplayerModel)
        return p
    }()
    
}
//MARK:EVENT
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
    //隐藏遮盖图
    func maskPreViewStartBtnClick(){
        maskPreView.isHidden = true
    }
}
