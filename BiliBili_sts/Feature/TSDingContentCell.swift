import UIKit
import SnapKit

class TSDingContentCell: UICollectionViewCell {
    
    //MARK: - Property
    lazy var contentImage: UIImageView = {
        let iv = UIImageView()
        //圆角
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byCharWrapping
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
        
        self.addSubview(contentImage)
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentImage.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: self.tsW, height: 0.57 * self.tsH))
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: self.tsW, height: 0.26 * self.tsH))
            make.left.equalTo(self.snp.left)
            make.top.equalTo(contentImage.snp.bottom).offset(8)
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
    }
}


