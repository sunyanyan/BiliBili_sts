import UIKit
import SnapKit

class TSDingContentCell: UICollectionViewCell {
    
    //MARK: - Property
    static let tsDingContentCellKey = "TSDingContentCellKey"
    
    lazy var cornerView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        //圆角
        v.layer.cornerRadius = 5.0
        v.layer.masksToBounds = true

        return v
    }()
//
//    lazy var shadowView : UIView = {
//        let v = UIView()
//        
//        //阴影
//        v.layer.shadowColor = UIColor.black.cgColor
//        v.layer.shadowPath = UIBezierPath.init(rect: self.bounds).cgPath
//        v.layer.shadowOffset = CGSize.init(width: 1, height: 1)
//        v.layer.shadowOpacity = 0.8
//        v.layer.shadowRadius = 1
//        
//        return v
//    }()
    
    lazy var contentImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.red
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.font = .systemFont(ofSize: 12)
        lbl.lineBreakMode = .byCharWrapping
        return lbl
    }()
    
    lazy var tagLabel:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 10)
        lbl.lineBreakMode = .byCharWrapping
        lbl.textColor = UIColor.lightGray
        return lbl
    }()
    
    lazy var moreMenuBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(#imageLiteral(resourceName: "more_menu"), for: UIControlState.normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
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
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(cornerView.snp.bottom)
            make.width.equalTo(tagLabel.snp.height)
            
        }
        
    
    }
    
    
    //MARK:- private method
    func setupModel(){
        if let urlString = contentModel?.pic{
            let url = URL.init(string: urlString)
            contentImage.sd_setImage(with: url)
        }
        if let title = contentModel?.title{
            let str = "\(title)\n\n\n"
            titleLabel.text = str
        }
        if let tags = contentModel?.formedTagStr() {
            tagLabel.text = tags
        }
    }
}


