//
//  TSRefresh.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/23.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
import Refresher

class TSRefreshAnimator: UIView,PullToRefreshViewDelegate {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(refreshGIF)
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        refreshGIF.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: self.tsW, height: 0.8 * self.tsH))
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: self.tsW, height: 0.2 * self.tsH))
            make.left.equalTo(self.snp.left)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    //MARK: - property
    lazy var refreshGIF: UIImageView = {
        let GIF = UIImageView.refreshLogoGif()
        return GIF
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .center
        return lbl
    }()
    
    //MARK: - PullToRefreshViewDelegate
    func pullToRefreshAnimationDidStart(_ view: PullToRefreshView){
        refreshGIF.startAnimating()
    }
    func pullToRefreshAnimationDidEnd(_ view: PullToRefreshView){
        refreshGIF.stopAnimating()
    }
    func pullToRefresh(_ view: PullToRefreshView, progressDidChange progress: CGFloat){}
    func pullToRefresh(_ view: PullToRefreshView, stateDidChange state: PullToRefreshViewState){
        switch state {
        case .loading:
            titleLabel.text = "刷啊,刷啊,好累啊,喵^w^"
        case .pullToRefresh:
            titleLabel.text = "再拉,再拉就刷给你看"
        case .releaseToRefresh:
            titleLabel.text = "够了啦,松开人家嘛"
        }
    }
}

extension UIScrollView{

    public func tsAddPullToRefreshWithAction(_ action:@escaping (() -> ())){
        
        let frame = CGRect.init(x: 0, y: 0, width: tsScreenWidth, height: 80)
        let refreshAnimator = TSRefreshAnimator.init(frame: frame)
        
        addPullToRefreshWithAction({
            action()
        }, withAnimator: refreshAnimator)
        
    }
    
    public func tsStopPullToRefresh(){
        stopPullToRefresh()
    }
    
    public func tsStartPullToRefresh(){
        startPullToRefresh()
    }

}
