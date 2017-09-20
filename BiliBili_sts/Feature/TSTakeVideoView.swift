//
//  TSTakeVideoView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/24.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

@objc protocol TSTakeVideoViewDelegate{
    @objc optional func liveBtnClick()
}

class TSTakeVideoView: UIView {
    lazy var photoAlbumBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"live_home_follow_ico"), for: UIControlState.normal)
        btn.backgroundColor = UIColor.white
        return btn
    }()
    
    lazy var liveBtn : UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"home_bangumi_icon_13"), for: UIControlState.normal)
        btn.backgroundColor = UIColor.white
        btn.addTarget(self , action: #selector(liveBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var smallVideoBtn : UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"live_home_search_ico"), for: UIControlState.normal)
        btn.backgroundColor = UIColor.white
        return btn
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"circle_buy_vip_close"), for: UIControlState.normal)
        btn.backgroundColor = UIColor.white
        btn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        return btn
    }()
    
    weak var delegate:TSTakeVideoViewDelegate?
    
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //        setupConstraints()
    }
    //MARK: - setup UI
    func setupUI () {
        
        self.backgroundColor = UIColor.tsRGBA(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        addSubview(backBtn)
        addSubview(smallVideoBtn)
        addSubview(liveBtn)
        addSubview(photoAlbumBtn)
        
        setupConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.startAnimate(btn: self.smallVideoBtn, angle: CGFloat.pi * 4 / 6 )
            self.startAnimate(btn: self.liveBtn, angle: CGFloat.pi * 3 / 6)
            self.startAnimate(btn: self.photoAlbumBtn, angle: CGFloat.pi * 2 / 6)
        }
        
    }
    func setupConstraints(){
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
        let btnWH = 60.0
        backBtn.snp.updateConstraints { (make ) in
            make.right.equalTo(self).offset(-8)
            make.bottom.equalTo(self).offset(-28 - 49)
//            make.center.equalTo(self)
            make.width.height.equalTo(btnWH)
        }
        backBtn.layer.cornerRadius = CGFloat(btnWH / 2)
        //        btnWH = 60.0
        smallVideoBtn.snp.updateConstraints { (make ) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(btnWH)
 
            make.width.height.equalTo(btnWH)
        }
        smallVideoBtn.layer.cornerRadius = CGFloat(btnWH / 2)
        
        liveBtn.snp.updateConstraints { (make ) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(btnWH)
 
            make.width.height.equalTo(btnWH)
        }
        liveBtn.layer.cornerRadius = CGFloat(btnWH / 2)
        
        photoAlbumBtn.snp.updateConstraints { (make ) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(btnWH)
 
            make.width.height.equalTo(btnWH)
        }
        photoAlbumBtn.layer.cornerRadius = CGFloat(btnWH / 2)
        
    }
    
    
}
//MARK: - animate
extension TSTakeVideoView : CAAnimationDelegate{
    
    func startAnimate (btn:UIButton , angle:CGFloat)  {
        let point = btn.center
        let centerPoint = backBtn.center
        let radius = TSCommon.radius(point1: point, point2: centerPoint)

        
        let path = UIBezierPath.init()
        path.move(to: point)
        let startAngle =  TSCommon.bezierAngle(point: point, centerPoint: centerPoint)
        path.addArc(withCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: startAngle + angle, clockwise: true)
 
        
        let pathKeyFrame = CAKeyframeAnimation.init(keyPath: "position")
        pathKeyFrame.delegate = self
        pathKeyFrame.path = path.cgPath
        let duration = (angle / CGFloat.pi * 2) / 3
        pathKeyFrame.duration = CFTimeInterval(duration)

        pathKeyFrame.fillMode = kCAFillModeForwards
        pathKeyFrame.isRemovedOnCompletion = false
        btn.layer.add(pathKeyFrame, forKey: "pathKeyFrame")
    }
    
    func endAnimate(btn:UIButton){
        
        var originPoint = btn.center
        if let presentLayer = btn.layer.presentation() {
            originPoint = presentLayer.tsCenter
        }

        let point = originPoint
        
        let centerPoint = backBtn.center
        let radius = TSCommon.radius(point1: point, point2: centerPoint)

        
        
        let path = UIBezierPath.init()
        path.move(to: point)
        let startAngle = TSCommon.bezierAngle(point: point, centerPoint: centerPoint)
        path.addArc(withCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: startAngle + CGFloat.pi   , clockwise: true)
        
        
        let pathKeyFrame = CAKeyframeAnimation.init(keyPath: "position")
        pathKeyFrame.path = path.cgPath
        let duration = 0.8 / 3
        pathKeyFrame.duration = CFTimeInterval(duration)

        pathKeyFrame.fillMode = kCAFillModeForwards
        pathKeyFrame.isRemovedOnCompletion = false
        btn.layer.add(pathKeyFrame, forKey: "pathKeyFrame")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        let btns = [self.liveBtn,self.photoAlbumBtn,self.smallVideoBtn]
        for btn:UIButton  in btns  {
            let btnAnim = btn.layer.animation(forKey: "pathKeyFrame")
            if btnAnim == anim {
                if let presentFrame = btn.layer.presentation()?.frame {
                    btn.frame = presentFrame
                }
            }
        }
    }

}
//MARK: - Event
extension TSTakeVideoView {
    
    func backBtnClick(){
        
        DispatchQueue.main.async {
            self.endAnimate(btn: self.smallVideoBtn )
            self.endAnimate(btn: self.liveBtn)
            self.endAnimate(btn: self.photoAlbumBtn)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8 / 3) {
            self.removeFromSuperview()
        }
    }
    
    func liveBtnClick(){
    
        self.removeFromSuperview()
    
        if let del = self.delegate {
            if let action = del.liveBtnClick {
                action()
            }
        }
    }
}


