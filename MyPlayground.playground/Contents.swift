import UIKit
import PlaygroundSupport

let str = "<meta property=\"og:type\" content=\"video\"/><meta property=\"og:title\" content=\"【王者荣耀】我还是很喜欢你\"/><meta property=\"og:image\" content=\"http://i0.hdslb.com/bfs/archive/8169bf3ce8a695b91a1ac294625afadb83998689.jpg\"/><meta property=\"og:url\" content=\"http://m.bilibili.com/video/av10835406.html\"/>"

let range1 = str.range(of: "og:image\" content=\"")
let range2 = str.range(of: "\"/><meta property=\"og:url\"")
let range = Range<String.Index>.init(uncheckedBounds: (lower: (range1?.upperBound)!, upper: (range2?.lowerBound)!))
let subStr = str.substring(with: range)


//
//class vc :UIViewController{
//    
//    lazy var shadowView: UIView = {
//        var view = UIView()
//        view.backgroundColor = UIColor.red
//        view.frame = CGRect.init(x: 100, y: 100, width: 200, height: 200)
//        view.layer.cornerRadius = 10
//        
//        view.layer.shadowOffset = CGSize.init(width: 1, height: 1)
//        view.layer.shadowOpacity = 0.75
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowRadius = 1
//        
//        return view
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor.white
//        view.addSubview(shadowView)
//    }
//}
//let someVC = vc()


//PlaygroundPage.current.liveView = someVC


