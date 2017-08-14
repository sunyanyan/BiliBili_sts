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
    
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
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
        
        let headViewHeight = TSCommentTableCellHeadView.requiredHeight(model: self.model)
        headView.snp.updateConstraints { (make ) in
            make.left.top.equalTo(contentView)
            make.width.equalTo(contentView)
//            make.height.equalTo(headView.requiredHeight(model: self.model))
            make.height.equalTo(headViewHeight)
        }
        
        var y = headViewHeight
        if let midViewsT = midViews {
            for modelIndex in 0..<midViewsT.count {
                guard let allModelsT = self.model?.replies else {return}
                guard let modelT = TSCommon.modelAt(index: modelIndex, models: allModelsT) as? TSPlayerCommentReplyModel else{ return}
                guard let midView = TSCommon.modelAt(index: modelIndex, models: midViewsT) as? TSCommentTableCellMidView else { return  }
                
                
                let midViewHeight = TSCommentTableCellMidView.requiredHeight(model: modelT)
                midView.snp.updateConstraints({ (make ) in
                    make.left.equalTo(contentView)
                    make.top.equalTo(contentView).offset(y)
                    make.width.equalTo(contentView)
                    make.height.equalTo(midViewHeight)
                })
                y  = y + midViewHeight
                
            }

//            TSLog(message: " oid:\(String(describing: model?.oid)) height:\(y)")
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
        self.model = model
        setupMidBottomViews(model: model)
        headView.setupModel(model: model)
        setupUI()
    }
    //MARK:- property
    var model:TSPlayerCommentReplyModel?
    lazy var headView: TSCommentTableCellHeadView = {
        let v = TSCommentTableCellHeadView()
        return v
    }()
    var midViews:[TSCommentTableCellMidView]?
    var bottomView:TSCommentTableCellBottomView?
    
    //MARK:- Event
//    func requiredHeight() -> CGFloat {
//        return 76
//    }
    class func requiredHeight(model:TSPlayerCommentReplyModel)->CGFloat{
        var height = TSCommentTableCellHeadView.requiredHeight(model: model)
        if let replies = model.replies {
            let count = replies.count
            var endIndex = 0
            //最多显示五条
            if count >= 5 { endIndex = 4 }
            else { endIndex = count - 1}
            var startIndex = 0

            for replyModel in replies {
                
                height = TSCommentTableCellMidView.requiredHeight(model: replyModel) + height
                 
                startIndex = startIndex + 1
                if startIndex > endIndex {
                    break
                }
            }
            if count > 5 {
                height = height + 20
            }
            
        }
//        TSLog(message: " oid:\(String(describing: model.oid)) height:\(height)")
        return height
    }
    
    func setupMidBottomViews(model:TSPlayerCommentReplyModel ) {
        if let replies = model.replies {
            let count = replies.count
            var endIndex = 0
            //最多显示五条
            if count >= 5 { endIndex = 4 }
            else { endIndex = count - 1}
            var startIndex = 0
            midViews = [TSCommentTableCellMidView]()
            for replyModel in replies {
                
                let midView = TSCommentTableCellMidView()
                midView.setupModel(model: replyModel)
                midViews?.append(midView)
                
                startIndex = startIndex + 1
                if startIndex > endIndex {
                    break
                }
            }
            if count > 5 {
                bottomView = TSCommentTableCellBottomView()
                bottomView?.setupModel(totalCount: count)
            }
            
        }
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
//        self.backgroundColor = UIColor.red
        addSubview(headView)
        addSubview(vipIV)
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
            make.width.equalTo(80)
            make.top.height.equalTo(headView)
        }
        vipIV.snp.updateConstraints { (make ) in
            make.centerY.equalTo(headView)
            make.left.equalTo(nameLbl.snp.right)
            make.height.equalTo(headView).multipliedBy(0.6)
            make.width.equalTo(40)
        }
//        contentLbl.snp.updateConstraints { (make ) in
//            make.left.equalTo(nameLbl)
//            make.right.equalTo(timeLbl)
//            make.top.equalTo(nameLbl.snp.bottom)
////            make.height.equalTo(contentLblHeight)
//        }
        inputIV.snp.updateConstraints { (make ) in
            make.left.equalTo(nameLbl)
            make.bottom.equalTo(self).offset(-8)
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
            make.left.right.top.equalTo(self)
            make.height.equalTo(1)
        }
        contentLbl.snp.updateConstraints { (make ) in
            make.left.equalTo(nameLbl)
            make.right.equalTo(timeLbl)
            make.top.equalTo(nameLbl.snp.bottom)
            //            make.height.equalTo(contentLblHeight)
            make.bottom.equalTo(inputIV.snp.top)
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
    fileprivate class func contentLblRequiredHeight(model:TSPlayerCommentReplyModel) -> CGFloat {
        
        if let content = model.content {
            if let message = content.message {
                let w = tsScreenWidth - 44
                let height = message.tsHeightWithConstrainedWidth(width: w, font: UIFont.systemFont(ofSize: 12))
                return height + 6
                
            }
        }
        return 20
    }
    class func requiredHeight(model:TSPlayerCommentReplyModel?) -> CGFloat {
        
        if let modelT = model {
            var  height = self.contentLblRequiredHeight(model: modelT)
            height = height + 56
            return height
        }
        
        return 76
    }
    
    //MARK:- property
    lazy var headView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "default")
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    lazy var vipIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage.init(named: "LV3")
        return iv
    }()
    lazy var inputIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "comment")
        return iv
    }()
    lazy var voteUpIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "like")
        return iv
    }()
    lazy var voteDownIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "dislike")
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
        lbl.numberOfLines = 20
        lbl.font = .systemFont(ofSize: 12)
        lbl.text = "这是一个不可爱的评论~"
        return lbl
    }()
    lazy var lineView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.lightGray
        return v
    }()
//    var contentLblHeight:CGFloat = 20
//    var requiredHeight:CGFloat = 76

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
//        self.backgroundColor = UIColor.green
        addSubview(nameLbl)
        addSubview(timeLbl)
        addSubview(contentLbl)
        addSubview(lineView)
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
            make.bottom.equalTo(self)
        }
        lineView.snp.updateConstraints { (make ) in
            make.right.top.equalTo(self)
            make.left.equalTo(nameLbl.snp.left)
            make.height.equalTo(1)
        }
        
        
    }
    func setupModel(model:TSPlayerCommentReplyModel){
        if let member = model.member {
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
    lazy var lineView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hexString(hex: "e6e6e6")
        return v
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
        lbl.numberOfLines = 100
        lbl.text = "这也是一个不可爱的评论~"
        return lbl
    }()
//    var contentLblHeight:CGFloat = 20
//    var requiredHeight:CGFloat = 56
    //MARK: - event
    fileprivate class func contentLblRequiredHeight(model:TSPlayerCommentReplyModel) -> CGFloat {
        
        if let content = model.content {
            if let message = content.message {
                let w = tsScreenWidth - 44
                let height = message.tsHeightWithConstrainedWidth(width: w, font: UIFont.systemFont(ofSize: 12))
                return height + 6
                
            }
        }
        return 20
    }
    class func requiredHeight(model:TSPlayerCommentReplyModel?) -> CGFloat {
        
        if let modelT = model {
            var  height = self.contentLblRequiredHeight(model: modelT)
            height = height + 36
            return height
        }
        
        return 56
    }
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
//        self.backgroundColor = UIColor.blue 
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
    func setupModel(totalCount:Int){
        let str = String.init(format: "共有%d条回复 >>", totalCount)
        contentLbl.text = str
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
    let requiredHeight:CGFloat = 20
}
