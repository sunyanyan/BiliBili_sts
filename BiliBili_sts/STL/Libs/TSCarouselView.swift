//
//  TSCarouselView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/24.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

@objc protocol TSCarouselViewDelegate {
    @objc optional func didSelectAtIndex(index:Int , imgUrl:String?)
}

class TSCarouselView :UIView{
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        addSubview(mainCollectionView)
        addSubview(pageControl)
        
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame:CGRect , imageUrlStrs:[String],
                     selectedAction:((_ index: Int , _ imgUrl:String?)->())? = nil) {
        self.init(frame: frame)
        
        selectedBlock = selectedAction
        imageUrlStrings = imageUrlStrs
        
        
        mainCollectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainCollectionView.frame = self.bounds
        
        guard let count = imageUrlStrings?.count else {
            return
        }
        pageControl.numberOfPages = count
        let pageSize = pageControl.size(forNumberOfPages: count)
        pageControl.frame = CGRect(x: frame.size.width - pageSize.width - 10, y: frame.size.height - pageSize.height + 10, width: pageSize.width, height: pageSize.height)
        
        // 添加timer
        repeatTimer?.invalidate()
        repeatTimer = nil
        if repeatTimer == nil{
            addTimer()
        }
    }
    
    //MARK:- property
    weak var carouselSelectdelegate: TSCarouselViewDelegate?
    var imageUrlStrings:[String]?{
        didSet{
            setupUI()
        }
    }
    var timeInterval:Int = 5
    fileprivate var repeatTimer: Timer?
    
    /// 选中的action
    public var selectedBlock:((_ index: Int , _ imgUrl:String?)->())?
    
    lazy var placeHolderImage: UIImage = {
        let image = #imageLiteral(resourceName: "default")
        return image
    }()
    
    fileprivate lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = tsNavTintColor
        pc.pageIndicatorTintColor = UIColor.white
        return pc
    }()
    fileprivate lazy var mainCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = self.frame.size
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let contentCollectonView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        contentCollectonView.backgroundColor = UIColor.white
        contentCollectonView.collectionViewLayout = flowLayout
        contentCollectonView.delegate = self
        contentCollectonView.dataSource = self
        contentCollectonView.register(TSCarouselViewCell.self, forCellWithReuseIdentifier: TSCarouselViewCell.TSCarouselViewCellId)
        contentCollectonView.isPagingEnabled = true
        contentCollectonView.showsVerticalScrollIndicator = false
        contentCollectonView.showsHorizontalScrollIndicator = false
        return contentCollectonView
    }()
    
}

extension TSCarouselView{
    
    fileprivate func setupUI(){
        guard let count = imageUrlStrings?.count else {
            return
        }
        if count == 1 {
            removeTimer()
            pageControl.isHidden = true
            self.mainCollectionView.isScrollEnabled = false
        }
        else {
            self.mainCollectionView.isScrollEnabled = true
            pageControl.isHidden = false
            addTimer()
        }
        setNeedsLayout()
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
    
    
    @objc fileprivate func nextPage(){
        
        if imageUrlStrings != nil {
            let arrayCount = imageUrlStrings?.count
            var page = Int(mainCollectionView.contentOffset.x/mainCollectionView.frame.size.width)%arrayCount!
            page = (page + 1) % arrayCount!
            self.pageControl.currentPage = page;
            let indexPath = IndexPath.init(row: page, section: 0)
            mainCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
    fileprivate func removeTimer(){
        repeatTimer?.invalidate()
        repeatTimer = nil
    }
    fileprivate func addTimer(){
        if (repeatTimer != nil) {return}
        
        // 1. 数据少于2不添加timer
        guard let count = imageUrlStrings?.count else {
            return
        }
        if count < 2 {
            return
        }
        
        // 2. 添加tiemr
        repeatTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timeInterval), target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(repeatTimer!, forMode: .defaultRunLoopMode)
    }
}

extension TSCarouselView:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = indexPath.row
        var urlString:String?
        if imageUrlStrings != nil && index < (imageUrlStrings?.count)!{
            urlString = imageUrlStrings?[index]
        }
        
        if let action = selectedBlock {
            action(indexPath.row,urlString)
        }
        if let delegate = carouselSelectdelegate {
            if let method = delegate.didSelectAtIndex {
                method(indexPath.row,urlString)
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //只在滚动结束的时候调用
        perform(#selector(scrollViewDidEndScrollingAnimation(_:)), with: scrollView, afterDelay: 0.1)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        if imageUrlStrings != nil {
            let arrayCount = imageUrlStrings?.count
            let page = Int(scrollView.contentOffset.x/scrollView.frame.size.width)%arrayCount!
            self.pageControl.currentPage = page;
        }
    }
}

extension TSCarouselView:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if imageUrlStrings != nil {
            return imageUrlStrings!.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSCarouselViewCell.TSCarouselViewCellId, for: indexPath) as! TSCarouselViewCell
        
        if let urls = imageUrlStrings {
            let urlString = urls[indexPath.row]
            let url = URL.init(string: urlString)
            cell.contentImageView.sd_setImage(with: url, placeholderImage: placeHolderImage)
        }
        
        return cell
    }
}


fileprivate class TSCarouselViewCell: UICollectionViewCell  {
    
    static let TSCarouselViewCellId = "TSCarouselViewCellID"
    
    lazy var contentImageView: UIImageView = {
        let contentImageView = UIImageView()
        contentImageView.clipsToBounds = true
        contentImageView.contentMode = .scaleToFill
        contentImageView.backgroundColor = UIColor.clear
        return contentImageView
    }()
    
    lazy var placeHolder: UIImageView = {
        let placeHolder = UIImageView()
        placeHolder.image = UIImage(named: "default_img")
        placeHolder.contentMode = .center
        return placeHolder
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(placeHolder)
        self.addSubview(contentImageView)
        self.backgroundColor = UIColor.white
        placeHolder.backgroundColor = UIColor.white
    }
    
    fileprivate override func layoutSubviews() {
        super.layoutSubviews()
        contentImageView.frame = self.bounds
        placeHolder.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
