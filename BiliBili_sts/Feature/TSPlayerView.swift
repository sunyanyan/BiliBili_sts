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
    init(customBMPlayController:BMPlayerControlView) {
        self.customBMPlayController = customBMPlayController
        super.init(frame:CGRect.zero)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        
    }
    //MARK: - property
//    public var backBtnClickBlock:(()->())?
    weak var delegate:TSPlayerViewDelegate?
    
    var customBMPlayController:BMPlayerControlView?
    
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
    
//        customBmPlayComtroller = TSRecommendCustomBMPlayerControlView()
//        customBmPlayComtroller.backBtnClickBlock = {()->() in
//            self.backBtnClick()
//        }
 
        let p = BMPlayer.init(customControlView: self.customBMPlayController)
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
        TSLog(message: " tsW \(self.tsW) tsH\(self.tsH)")
        
        bmPlayer.snp.updateConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        maskPreView.snp.updateConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        thumbnailImageView.snp.updateConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        effectView.snp.updateConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        moreBtn.snp.updateConstraints { (make) in
            make.right.equalTo(maskPreView.snp.right).offset(-8)
            make.top.equalTo(15)
            make.width.height.equalTo(40)
        }
        let h = self.tsH / 180 * 50
        let x = self.tsH / 180 * self.tsW - h - 15
        let y = self.tsH - h - 15

        startBtn.snp.updateConstraints { (make) in
            make.top.equalTo(y)
            make.left.equalTo(x)
            make.width.height.equalTo(h)
        }
        
        titleLabel.snp.updateConstraints { (make) in
            make.centerX.equalTo(maskPreView.snp.centerX)
            make.top.equalTo(15)
            make.width.equalTo(maskPreView.snp.width).multipliedBy(0.8)
            make.height.equalTo(40)
        }
        backBtn.snp.updateConstraints { (make ) in
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
    
    
    
    func setBMPlayerVideo(url:String , title:String="") {
        if let nsurl = URL.init(string: url){
            let name = title
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
