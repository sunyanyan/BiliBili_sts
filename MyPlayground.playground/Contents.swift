import UIKit
import PlaygroundSupport

let start = Date.init()

let format = DateFormatter.init()
format.dateFormat = "YYYY-MM-dd hh:mm:ss:SSS"

var DateStr = format.string(from: start)

sleep(2)

let end = Date.init()
DateStr = format.string(from: end)

let span:Double = end.timeIntervalSince(start)
//let spanInt = span.in


//let tmps = ["A","B","C","D","E"]
//var models = [String]()
//
//for str in tmps {
//    models.append(str)
//}
//
//for str in tmps {
//    models.insert(str, at: 0)
//}
//
//print(models)

//func randomInRange(range: Range<Int>) -> Int {
//    let count = UInt32(range.upperBound - range.lowerBound)
//    return  Int(arc4random_uniform(count)) + range.lowerBound
//}
//
//func random4InRange(range: Range<Int>) -> [Int] {
//    
//    var random4 = [Int]()
//    
//    while random4.count < 4 {
//        let i = randomInRange(range: range)
//        if !random4.contains(i) {
//            random4.append(i)
//        }
//    }
//    
//    return random4
//}
//
//func random4ToIndex(index: Int) -> [Int] {
//    
//    let range  = Range.init(uncheckedBounds: (lower: 0, upper: index))
//    
//    return random4InRange(range: range)
//}
//
//print(random4ToIndex(index: 12))
//print(random4InRange(range: 0..<15 ))





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


