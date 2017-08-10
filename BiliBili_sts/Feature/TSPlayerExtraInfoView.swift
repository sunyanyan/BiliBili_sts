//
//  TSPlayerExtraInfoView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/7.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
//import PageMenu

class TSPlayerExtraInfoView: UIView  {
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
    //MARK: property
    lazy var playerIntroductionView: TSPlayerIntroductionView = {
        let playerIntroductionView = TSPlayerIntroductionView()
        playerIntroductionView.aid = self.aid
        playerIntroductionView.delegate = self
        return playerIntroductionView
    }()
    
    
    lazy var playerCommentView: TSPlayerCommentView = {
        let playerCommentView = TSPlayerCommentView()
 
        return playerCommentView
    }()

    
    lazy var slideMenu: TSSlideMenuView = {
        // 1.frame
        let width:CGFloat = 150
        let height:CGFloat = tsSlideMenuViewHeight
        let x = (tsScreenWidth - width)/2
        let y:CGFloat = 0
        let rect = CGRect(x: x, y: y, width: width, height: height)
        
        // 2.平常的颜色
        let normalColor = TSSlideMenuView.slideMenuTitleColor(red: 197, green: 197, blue: 197)
        
        // 3.显示的颜色
        let hightLightColor = TSSlideMenuView.slideMenuTitleColor(red: 252, green: 101, blue: 146)
        
        // 4.生成slidemenu
        let menu = TSSlideMenuView(frame: rect, titles: ["简介","评论"], padding: 15, normalColr: normalColor, hightLightColor: hightLightColor, font: 16, sliderColor: tsNavTintColor, onlyHorizon: false, scrollView: self.contentScrollView, autoPadding: true)
        
        return menu
    }()
    
    lazy var contentScrollView: UIScrollView = {

        let v = UIScrollView()
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
 
//        v.isPagingEnabled = true
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        return v
    }()
    var aid:String = ""{
        didSet{
            playerIntroductionView.aid = aid
            playerCommentView.aid = aid 
        }
    }
    
    weak var updateFrameDelegate:TSUpdateFrameDelegate?
    
}
//MARK:- TSPlayerExtraInfoView setup UI & add Constraints
extension TSPlayerExtraInfoView{
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        addSubview(slideMenu)
        addSubview(contentScrollView)
        addContentScrollSubViews()
    }
    
    func addContentScrollSubViews(){
        contentScrollView.addSubview(playerIntroductionView)
        contentScrollView.bringSubview(toFront: playerIntroductionView)
        contentScrollView.addSubview(playerCommentView)
        contentScrollView.bringSubview(toFront: playerCommentView)
    }
    
    func setupConstraints(){
        
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
        
        slideMenu.snp.makeConstraints { (make ) in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.width.equalTo(150)
            make.height.equalTo(tsSlideMenuViewHeight)
        }
        let contentScrollViewHeight = self.tsH - tsSlideMenuViewHeight
        contentScrollView.snp.updateConstraints { (make ) in
            make.left.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(contentScrollViewHeight)
            make.top.equalTo(slideMenu.snp.bottom)
        }
        
        
        playerIntroductionView.snp.updateConstraints({ (make) in
            make.top.left.width.height.equalTo(contentScrollView)
        })
        
        playerCommentView.snp.updateConstraints({ (make) in
            make.top.width.height.equalTo(contentScrollView)
            make.left.equalTo(playerIntroductionView.snp.right)
        })
        
        contentScrollView.contentSize = CGSize(width: viewWidth * 2, height: contentScrollViewHeight)
    }
    

}

// MARK: - 滚动动画
extension TSPlayerExtraInfoView :UIScrollViewDelegate{

//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let scrollViewContentOffsetY = scrollView.contentOffset.y
////        TSLog(message: " scrollViewContentOffsetY: \(scrollViewContentOffsetY) ")
//    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //scrollview向上滚动时 缩小playerView的高度
        //scrollview向下滚动时 恢复playerView的高度
        let scrollViewContentOffsetY = scrollView.contentOffset.y
        let scrollViewContentOffsetX = scrollView.contentOffset.x
//        TSLog(message: " scrollViewContentOffsetY: \(scrollViewContentOffsetY) ")
        
        if let  del  = updateFrameDelegate {
            if let action = del.tsUpdateHeight {
                action(self , scrollViewContentOffsetY)
            }
            setNeedsLayout()
        }
    }
}



