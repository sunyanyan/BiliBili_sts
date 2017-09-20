//
//  TSFlodTextView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/25.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

///单行状态: 显示label 和 向下的箭头
///多行状态: 显示textView 和 向上的箭头
class TSFlodTextView:UIView{
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame:CGRect ,text : String!) {
        self.init(frame: frame)
        
        textContent = text
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    //MARK:- property
    var isMutiLineStatus = false{
        willSet(newValue) {
            singleLbl.isHidden = newValue
            mutiTextView.isHidden = !newValue
            if newValue {
                arrowBtn.setImage(UIImage.init(named:"arrow_up"), for: UIControlState.normal)
            }
            else{
                arrowBtn.setImage(UIImage.init(named:"arrow_down"), for: UIControlState.normal)
            }
        }
    }
    var textContent = "卡机SD卡就山东矿机哈萨克姐电话卡就十分框架还V领和vavh是的官方但是公司大公司都官方"{
        willSet(newValue){
            singleLbl.text = newValue
            mutiTextView.text = newValue
        }
    }
    lazy var singleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.lightGray
        lbl.font = .systemFont(ofSize: 10)
        lbl.text = self.textContent
        
        return lbl
    }()
    lazy var arrowBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named:"arrow_down"), for: UIControlState.normal)
        return btn
    }()
    
    lazy var mutiTextView: UITextView = {
        let v  = UITextView()
        v.isHidden = true
        v.textColor = UIColor.lightGray
        v.textAlignment = .left
        v.font = .systemFont(ofSize: 10)
        v.text = self.textContent
        let i = v.textContainerInset
        //        v.textContainerInset = UIEdgeInsets.init(top: 9, left: 0, bottom: 0, right: 0)
        v.isEditable = false
        return  v
    }()
    //MARK: - setup UI
    func setupUI(){
        addSubview(singleLbl)
        addSubview(mutiTextView)
        addSubview(arrowBtn)
        
    }
    func setupConstraints(){
    
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
    
        singleLbl.snp.makeConstraints { (make ) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(self).offset(-30)
        }
        mutiTextView.snp.makeConstraints { (make ) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(self).offset(-30)
        }
        arrowBtn.snp.makeConstraints { (make ) in
            make.bottom.right.equalTo(self)
            make.width.height.equalTo(30)
        }
    }
}
