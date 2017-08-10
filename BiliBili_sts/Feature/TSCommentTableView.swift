//
//  TSCommentTableView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/10.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit


class TSCommentTableView: UIView {
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
    
    //MARK: - setup UI
    func setupUI () {
        addSubview(contentTableView)
    }
    func setupConstraints(){
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
        
        contentTableView.snp.updateConstraints { (make ) in
            make.left.top.equalTo(self)
            make.width.height.equalTo(self)
        }
    }
    func reload(){
        commentPresent.requestData {
            self.contentTableView.reloadData()
            
//            if let del  = self.updateFrameDelegate  {
//                if let action = del.tsUpdateFrameHeight {
//                    action(self,0)
//                }
//            }
//            self.setNeedsLayout()
        }
    }
    //MARK: - property
    lazy var contentTableView: UITableView = {
        let v = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        v.delegate = self
        v.dataSource = self
        v.separatorStyle = .none
        return v
    }()
    var videoAid:String=""{
        didSet{
            commentPresent.aid = videoAid
            reload()
        }
    }
    lazy var commentPresent: TSCommentTableViewPresent = {
        let p = TSCommentTableViewPresent.init(aid: self.videoAid)
        return p
    }()
}

extension TSCommentTableView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.commentPresent.numberOfRowsInSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.commentPresent.cellForRowAt(indexPath: indexPath, tableView: tableView)
    }
}
extension TSCommentTableView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.commentPresent.cellHeight(indexPath: indexPath, tableView: tableView)
    }
}
class TSCommentTableCell:UITableViewCell{
    static let tsCommentTableCellKey = "tsCommentTableCellKey"
    //MARK: - life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    //MARK: - setup UI
    func setupUI () {
        contentView.addSubview(headView)
        
        if let midViewsT = midViews {
            for midView in midViewsT {
                contentView.addSubview(midView)
            }
        }
        if let bottomViewT = bottomView {
            contentView.addSubview(bottomViewT)
        }
    }
    func setupConstraints(){
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
        
        headView.snp.updateConstraints { (make ) in
            make.left.top.equalTo(contentView)
            make.width.equalTo(contentView)
            make.height.equalTo(headView.requiredHeight)
        }
        
        var y = headView.requiredHeight
        if let midViewsT = midViews {
            for midView in midViewsT {
                midView.snp.updateConstraints({ (make ) in
                    make.left.equalTo(contentView)
                    make.top.equalTo(contentView).offset(y)
                    make.width.equalTo(contentView)
                    make.height.equalTo(midView.requiredHeight)
                })
                y  = y + midView.requiredHeight
            }
        }
        if let bottomViewT = bottomView {
            bottomViewT.snp.updateConstraints({ (make ) in
                make.left.equalTo(contentView)
                make.top.equalTo(contentView).offset(y)
                make.width.equalTo(contentView)
                make.height.equalTo(bottomViewT.requiredHeight)
            })
        }
        
    }
    func setupModel(model:TSPlayerCommentReplyModel){
        headView.setupModel(model: model)
    }
    //MARK:- property
    lazy var headView: TSCommentTableCellHeadView = {
        let v = TSCommentTableCellHeadView()
        return v
    }()
    var midViews:[TSCommentTableCellMidView]?
    var bottomView:TSCommentTableCellBottomView?
    
    //MARK:- Event
    func requiredHeight() -> CGFloat {
        return 76
    }
}


class TSCommentTableCellHeadView:UIView{
    
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    //MARK: - setup UI
    func setupUI () {
        addSubview(headView)
        addSubview(inputIV)
        addSubview(voteUpIV)
        addSubview(voteDownIV)
        addSubview(nameLbl)
        addSubview(timeLbl)
        addSubview(contentLbl)
        addSubview(lineView)
    }
    func setupConstraints(){
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
        
        headView.snp.updateConstraints { (make ) in
            make.left.top.equalTo(self).offset(8)
            make.width.height.equalTo(20)
        }
        timeLbl.snp.updateConstraints { (make ) in
            make.top.height.equalTo(headView)
            make.right.equalTo(self).offset(-8)
            make.width.equalTo(50)
        }
        nameLbl.snp.updateConstraints { (make) in
            make.left.equalTo(headView.snp.right).offset(8)
            make.right.equalTo(timeLbl.snp.left)
            make.top.height.equalTo(headView)
        }
        contentLbl.snp.updateConstraints { (make ) in
            make.left.equalTo(nameLbl)
            make.right.equalTo(timeLbl)
            make.top.equalTo(nameLbl.snp.bottom)
            make.height.equalTo(contentLblHeight)
        }
        inputIV.snp.updateConstraints { (make ) in
            make.left.equalTo(nameLbl)
            make.top.equalTo(contentLbl.snp.bottom)
            make.width.height.equalTo(20)
        }
        voteUpIV.snp.updateConstraints { (make ) in
            make.left.equalTo(inputIV.snp.right).offset(20)
            make.top.equalTo(inputIV)
            make.width.height.equalTo(inputIV)
        }
        voteDownIV.snp.updateConstraints { (make ) in
            make.left.equalTo(voteUpIV.snp.right).offset(20)
            make.top.equalTo(inputIV)
            make.width.height.equalTo(inputIV)
        }
        lineView.snp.updateConstraints { (make ) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }
        
    }
    func setupModel(model:TSPlayerCommentReplyModel){
        if let member = model.member {
            if let avatar = member.avatar {
                if let nsUrl = URL.init(string: avatar) {
                    headView.sd_setImage(with: nsUrl, placeholderImage: UIImage.init(named: "default"))
                }
            }
            if let uname = member.uname {
                nameLbl.text = uname
            }
            if let content = model.content {
                if let message = content.message {
                    contentLbl.text = message
                }
            }
            
        }
    }
    //MARK:- property
    lazy var headView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "default")
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    lazy var inputIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "default")
        return iv
    }()
    lazy var voteUpIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "default")
        return iv
    }()
    lazy var voteDownIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "default")
        return iv
    }()
    lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.lightGray
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "孙同生"
        return lbl
    }()
    lazy var timeLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.textColor = UIColor.lightGray
        lbl.font = .systemFont(ofSize: 10)
        lbl.text = "五天前"
        return lbl
    }()
    lazy var contentLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "这是一个不可爱的评论~"
        return lbl
    }()
    lazy var lineView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hexString(hex: "FAFAFA")
        return v
    }()
    var contentLblHeight:CGFloat = 20
    var requiredHeight:CGFloat = 76
}


class TSCommentTableCellMidView:UIView{
    
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    //MARK: - setup UI
    func setupUI () {
        addSubview(nameLbl)
        addSubview(timeLbl)
        addSubview(contentLbl)
    }
    func setupConstraints(){
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
        
        nameLbl.snp.updateConstraints { (make) in
            make.left.equalTo(self).offset(36)
            make.top.equalTo(self).offset(8)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        
        timeLbl.snp.updateConstraints { (make ) in
            make.top.height.equalTo(nameLbl)
            make.left.equalTo(nameLbl.snp.right).offset(8)
            make.width.equalTo(50)
        }
        
        contentLbl.snp.updateConstraints { (make ) in
            make.left.equalTo(nameLbl)
            make.right.equalTo(self).offset(-8)
            make.top.equalTo(nameLbl.snp.bottom)
            make.height.equalTo(contentLblHeight)
        }
        
        
        
    }
    func setupModel(model:Any){
        
    }
    //MARK:- property
    
    lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.lightGray
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "孙同生"
        return lbl
    }()
    lazy var timeLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.lightGray
        lbl.font = .systemFont(ofSize: 10)
        lbl.text = "五天前"
        return lbl
    }()
    lazy var contentLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "这也是一个不可爱的评论~"
        return lbl
    }()
    var contentLblHeight:CGFloat = 20
    var requiredHeight:CGFloat = 56
}

class TSCommentTableCellBottomView:UIView{
    
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    //MARK: - setup UI
    func setupUI () {
        addSubview(contentLbl)
    }
    func setupConstraints(){
        let viewWidth = self.tsW
        if viewWidth == 0 {return}
        
        contentLbl.snp.updateConstraints { (make ) in
            make.left.right.equalTo(self)
            make.width.height.equalTo(self)
        }
    }
    func setupModel(model:Any){
        
    }
    //MARK:- property
    
    lazy var contentLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "共有5条回复 >>"
        return lbl
    }()
    var requiredHeight:CGFloat = 20
}
