import UIKit
import SnapKit

class TSDingContentCell: UICollectionViewCell {
    
    //MARK: - Property
    static let tsDingContentCellKey = "TSDingContentCellKey"
    ///圆角视图
    lazy var cornerView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        //圆角
        v.layer.cornerRadius = 5.0
        v.layer.masksToBounds = true

        return v
    }()

    ///视频图片
    lazy var contentImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.white
        return iv
    }()
    ///标题
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.font = .systemFont(ofSize: 12)
        lbl.lineBreakMode = .byCharWrapping
        return lbl
    }()
    ///标签
    lazy var tagLabel:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 10)
        lbl.lineBreakMode = .byCharWrapping
        lbl.textColor = UIColor.lightGray
        return lbl
    }()
    ///更多按钮
    lazy var moreMenuBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(#imageLiteral(resourceName: "more_menu"), for: UIControlState.normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    
    lazy var playInfoView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "banner_bottom")
        return v
    }()
    
    lazy var playCountIV: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "play_count")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var playCountLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.white
        lbl.font = .systemFont(ofSize: 8)
        return lbl
    }()
    
    lazy var reviewCountIV: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "review_count")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var reviewCountLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor.white
        lbl.font = .systemFont(ofSize: 8)
        return lbl
    }()
    
    lazy var timeLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.textColor = UIColor.white
        lbl.font = .systemFont(ofSize: 8)
        return lbl
    }()
    
    
    
    var contentModel:TSDingContentModel?{
        didSet{
            setupModel()
        }
    }
    
    //MARK: - override
    override init(frame: CGRect) {
        super.init(frame: frame)

//        addSubview(shadowView)
        addSubview(cornerView)
        cornerView.addSubview(contentImage)
        cornerView.addSubview(titleLabel)
        cornerView.addSubview(tagLabel)
        cornerView.addSubview(moreMenuBtn)
        
        cornerView.addSubview(playInfoView)
        playInfoView.addSubview(playCountIV)
        playInfoView.addSubview(playCountLbl)
        playInfoView.addSubview(reviewCountIV)
        playInfoView.addSubview(reviewCountLbl)
        playInfoView.addSubview(timeLbl)
        
        backgroundColor = UIColor.white
        
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.init(width: 1, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        shadowView.snp.makeConstraints { (make) in
//            make.edges.equalTo(UIEdgeInsets.zero)
//        }
//        
        cornerView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    
        contentImage.snp.makeConstraints { (make) in
            make.left.equalTo(cornerView.snp.left)
            make.right.equalTo(cornerView.snp.right)
            make.top.equalTo(cornerView.snp.top)
            make.height.equalTo(cornerView).multipliedBy(0.6)
            
        }
        
        playInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(contentImage.snp.left)
            make.right.equalTo(contentImage.snp.right)
            make.bottom.equalTo(contentImage.snp.bottom)
            make.height.equalTo(contentImage).multipliedBy(0.2)
        }
        
        playCountIV.snp.makeConstraints { (make) in
            make.left.equalTo(playInfoView.snp.left).offset(8)
            make.bottom.equalTo(playInfoView.snp.bottom)
            make.height.equalTo(playInfoView)
            make.width.equalTo(playInfoView).multipliedBy(0.1)
        }
        
        playCountLbl.snp.makeConstraints { (make) in
            make.left.equalTo(playCountIV.snp.right).offset(8)
            make.bottom.equalTo(playInfoView.snp.bottom)
            make.height.equalTo(playInfoView)
            make.width.equalTo(playInfoView).multipliedBy(0.2)
        }
        
        reviewCountIV.snp.makeConstraints { (make) in
            make.left.equalTo(playCountLbl.snp.right)
            make.bottom.equalTo(playInfoView.snp.bottom)
            make.height.equalTo(playInfoView)
            make.width.equalTo(playInfoView).multipliedBy(0.1)
        }
        
        reviewCountLbl.snp.makeConstraints { (make) in
            make.left.equalTo(reviewCountIV.snp.right).offset(8)
            make.bottom.equalTo(playInfoView.snp.bottom)
            make.height.equalTo(playInfoView)
            make.width.equalTo(playInfoView).multipliedBy(0.2)
        }
        
        timeLbl.snp.makeConstraints { (make) in
            make.right.equalTo(playInfoView.snp.right).offset(-8)
            make.bottom.equalTo(playInfoView.snp.bottom)
            make.height.equalTo(playInfoView)
            make.width.equalTo(playInfoView).multipliedBy(0.2)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(cornerView.snp.left).offset(8)
            make.right.equalTo(cornerView.snp.right)
            make.top.equalTo(contentImage.snp.bottom)
            make.height.equalTo(cornerView).multipliedBy(0.25)
            
        }
        tagLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(cornerView.snp.left).offset(8)
            make.right.equalTo(moreMenuBtn.snp.left)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(cornerView).multipliedBy(0.15)
            
        }
        moreMenuBtn.snp.makeConstraints { (make) in
            
            make.right.equalTo(cornerView.snp.right)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalTo(cornerView.snp.bottom).offset(-5)
            make.width.equalTo(tagLabel.snp.height)
            
        }
        
    
    }
    
    
    //MARK:- private method
    func setupModel(){
        if let urlString = contentModel?.pic{
            let url = URL.init(string: urlString)
            contentImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "default"))
        }
        if let title = contentModel?.title{
            let str = "\(title)\n\n\n"
            titleLabel.text = str
        }
        if let tags = contentModel?.formedTagStr() {
            tagLabel.text = tags
        }
        if let playCount = contentModel?.stat?.view{
            playCountLbl.text = countString(count: playCount)
        }
        if let reviewCount = contentModel?.stat?.reply{
            reviewCountLbl.text = countString(count: reviewCount)
        }
        if let time = contentModel?.duration {
            timeLbl.text = timeString(time: time)
        }
        
    }
    
    private func countString(count:Int64)->String{
        if count < 10000 {
            return String.init(count)
        }
        else{
            return String.init(format: "%dw", count/10000)
        }
    }
    
    private func timeString(time:Int64)->String{
        let h = time / 3600
        let m =  (time - h * 3600) / 60
        let s = time - 3600 * h - 60 * m
        if h > 0 {
            return String.init(format: "%d:%d", h,m)
        }
        else{
            return String.init(format: "%d:%d", m,s)
        }
    }
}


