//
//  TSPlayerIntroductionViewController.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/11.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSPlayerIntroductionView:UIScrollView{
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
//    override func updateConstraints() {
//        super.updateConstraints()
////        TSLog(message: "")
//    }
    
    //MARK: - property
    var aid:String = ""{
        didSet{
            videoReleadtedView.videoAid = aid
        }
    }
    lazy var infoView : TSPIInfoView = {
        let v = TSPIInfoView()
        v.updateFrameDelegate = self
        return v
    }()
    
    lazy var authorAndTagsView: TSPIAuthorAndTagsView = {
        let v = TSPIAuthorAndTagsView()
        v.updateFrameDelegate = self
        return v
    }()
    
    lazy var videoReleadtedView:TSVideoReleadView = {
        let v = TSVideoReleadView()
        v.updateFrameDelegate = self
        return v
    }()
    weak var updateFrameDelegate:TSUpdateFrameDelegate?
    
    //MARK:- setup UI & add Constraints
    func setupUI(){
        backgroundColor = UIColor.hexString(hex: "FAFAFA")
        addSubview(infoView)
        addSubview(authorAndTagsView)
        addSubview(videoReleadtedView)
        
        self.contentSize = CGSize.init(width: 0, height: self.requiredViewHeight())
        
    }
    func setupConstraints(){
    
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
    
        infoView.snp.updateConstraints { (make ) in
            make.left.equalTo(self)
            make.top.equalTo(self).offset(10)
            make.width.equalTo(self)
            make.height.equalTo(infoView.requiredViewHeight)
            
        }
        authorAndTagsView.snp.updateConstraints { (make ) in
            make.top.equalTo(infoView.snp.bottom).offset(8)
            make.left.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(authorAndTagsView.requiredViewHeight)
            
        }
        videoReleadtedView.snp.updateConstraints { (make ) in
            make.top.equalTo(authorAndTagsView.snp.bottom).offset(8)
            make.left.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(videoReleadtedView.requiredViewHeight())
        }
        
        self.contentSize = CGSize.init(width: 0, height: self.requiredViewHeight())
    }
    
    /// 当前视图合适的高度
    ///
    /// - Returns: <#return value description#>
    func requiredViewHeight()->CGFloat{
        var height = infoView.requiredViewHeight + authorAndTagsView.requiredViewHeight + videoReleadtedView.requiredViewHeight()
        let padding:CGFloat = 10 + 8 + 8
        height = height + padding
        return  height
    }

    
}

extension TSPlayerIntroductionView:TSUpdateFrameDelegate{
    func tsUpdateFrameHeight(targetView: UIView, newHeight: CGFloat) {
        if let del  = updateFrameDelegate {
            if let action = del.tsUpdateFrameHeight {
                action(self,requiredViewHeight())
            }        }
        setNeedsLayout()
    }
}


