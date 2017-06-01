//
//  TSCommon.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/25.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

//MARK: - 随机数
class TSCommon {
    
    
    
    class func randomInRange(range: Range<Int>) -> Int {
        let count = UInt32(range.upperBound - range.lowerBound)
        return  Int(arc4random_uniform(count)) + range.lowerBound
    }
    
    class  func random4InRange(range: Range<Int>) -> [Int] {
        
        var random4 = [Int]()
        
        while random4.count < 4 {
            let i = randomInRange(range: range)
            if !random4.contains(i) {
                random4.append(i)
            }
        }
        
        return random4
    }
    
    /// 取 0..<index 四个不重复的随机数
    ///
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    class func random4ToIndex(index: Int) -> [Int] {
        
        let range  = Range.init(uncheckedBounds: (lower: 0, upper: index))
        
        return random4InRange(range: range)
    }
    
    
    

    
}
//MARK: - DataSource IndexPath
extension TSCommon {
    class func isVaild(indexPath:IndexPath , models:[[Any]])->Bool{
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section >= 0 && section < models.count {
            let sectionModels = models[section]
            if row >= 0 && row < sectionModels.count {
                return true
            }
        }
        
        return false
    }
    
    class func isVaild(section:Int , models:[[Any]])->Bool{
        
        if section >= 0 && section < models.count {
            return true
        }
        
        return false
    }
    
    class func modelAt(indexPath:IndexPath, models:[[Any]]) ->Any?{
        
        if isVaild(indexPath: indexPath, models: models){
            return models[indexPath.section][indexPath.row]
        }
        
        return nil
    }
}

// MARK: - UIViewContrller
extension TSCommon {
    
    class func stack()->[Any]{
        
        var stack:[Any] = [Any]()
        
        let keyWin = UIApplication.shared.keyWindow
        guard var win = keyWin else { return stack }
        
        stack.append(win)
        
        if win.windowLevel != UIWindowLevelNormal {
            for aWin in UIApplication.shared.windows {
                if aWin.windowLevel == UIWindowLevelNormal {
                    win = aWin
                    stack.append(win)
                    break
                }
            }
        }
        
        let fontView = win.subviews.first
        var topVC:UIViewController?
        if let vc = fontView?.next?.isKind(of: UIViewController.self) as? UIViewController {
            topVC = vc
        }
        else{
            topVC = win.rootViewController
        }
        
        guard let rootVC = topVC else { return stack }
        stack.append(rootVC)
        
        
        
        return stack
    }
    
    class func vcInStackWithClassName(className:String) -> UIViewController? {
        
        let keyWin = UIApplication.shared.keyWindow
        guard var win = keyWin else { return nil }
        
        if win.windowLevel != UIWindowLevelNormal {
            for aWin in UIApplication.shared.windows {
                if aWin.windowLevel == UIWindowLevelNormal {
                    win = aWin
                    break
                }
            }
        }
        
        
        
        return nil
    }

}

// MARK: - UIView
extension TSCommon{
    
    class func statusBarView() -> UIView {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tsScreenWidth, height: tsStatusBarHeight))
        v.backgroundColor = tsNavTintColor
        return v
    }
}
