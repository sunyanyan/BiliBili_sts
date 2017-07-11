//
//  TSPlayerIntroductionViewController.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/11.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit


class TSPlayerIntroductionViewController:UIViewController{
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    //MARK: - property
}

//MARK:- 简介 + 分享 投币 收藏 缓存 按钮
class TSPIInfoView: UIView {
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - property
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.text = "【剧情/恐怖/惊悚/神话】克鲁斯 生肉 (2007)高清"
        return lbl
    }()
    lazy var playIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "play_cout_grey"))
        return iv
    }()
    lazy var playCountLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.lightText
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "15.2万"
        return lbl
    }()
    lazy var reviewIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "review_cout_grey"))
        return iv
    }()
    lazy var reviewCountLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.lightText
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "2397"
        return lbl
    }()
    lazy var detailTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    lazy var lineView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black
        return v
    }()
    
    lazy var shareBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"share"), for: UIControlState.normal)
        return btn
    }()
    
    
}

/// 左边按钮 右边文字
class TSButtonLabelView:UIView{
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- property
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"share"), for: UIControlState.normal)
        return btn
    }()
    
    lazy var detailLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.white
        lbl.font = .systemFont(ofSize: 12)
        return lbl
    }()
    //MARK: - setup UI
    func setupUI () {
        addSubview(btn)
        addSubview(detailLbl)
        addConstraints()
    }
    func addConstraints() {
        btn.snp.makeConstraints { (make ) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
        }
        detailLbl.snp.makeConstraints { (make ) in
            make.right.top.bottom.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
        }
    }
    //MARK: - event
    func setupImage(image:UIImage, title:String){
        btn.setImage(image, for: UIControlState.normal)
        detailLbl.text = title
    
        image.getPaletteImageColor { (recommendColorModel, allModeColorDic, error) in
            if let colorHexString:String = recommendColorModel?.imageColorString {
                self.detailLbl.textColor = UIColor.hexString(hex: colorHexString)
            }
        }
    }
    
}
