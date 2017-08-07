//
//  TSTagsListView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/7/26.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit


class TSTagsListView:UIView{
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
        setupConstraints()
    }
    //MARK: - property
    var titles:[String] = ["电影","欧美电影","剧情","神话","无脑","阿特洛波斯","烂"]
    var btns:[UIButton] = [UIButton]()
    var btnWidths:[CGFloat] = [CGFloat]()
    var constantHeight:CGFloat = 30.0
    var leftPadding:CGFloat = 8.0
    var topPadding:CGFloat = 4.0
    var requiredViewheight:CGFloat = 38.0
    
}

extension TSTagsListView{
    
    func setupUI(){
        self.layer.masksToBounds = true
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
        
        for title in titles  {
            let aBtn = self.newBaseBtn()
            aBtn.setTitle(title, for: .normal)
            let fitWidth = title.tsWidthWithConstrainedHeight(height: constantHeight, font: (aBtn.titleLabel?.font)!)
            let width = fitWidth + 26
            btnWidths.append(width)
            btns.append(aBtn)
        }
        //add btns to view
        for view  in btns {
            addSubview(view)
        }
        
        
    }
    
    func setupConstraints(){
        if btns.count == 0 {return}
        let viewWidth = self.tsW
        if viewWidth <= 0 {
            return
        }
        var x:CGFloat = leftPadding
        var y:CGFloat = topPadding
        for index  in 0..<(btns.count) {
            let btnWidth = btnWidths[index]
            let btn = btns[index]
            btn.tag = index
            
            if (x + btnWidth ) > viewWidth {
                x = leftPadding
                y = y + constantHeight + topPadding
                requiredViewheight = y + constantHeight + topPadding
            }
            
            btn.snp.updateConstraints({ (make ) in
                make.left.equalTo(self).offset(x)
                make.top.equalTo(self).offset(y)
                make.width.equalTo(btnWidth)
                make.height.equalTo(constantHeight)
            })
            x = x + btnWidth + leftPadding
        }
    }
    
    func newBaseBtn()->UIButton{
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.borderColor = UIColor.hexString(hex: "C8C8C8").cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = constantHeight / 2.3
        return btn
    }
}
