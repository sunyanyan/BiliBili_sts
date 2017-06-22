//
//  File.swift
//  BiliBili
//
//  Created by sts on 2017/5/10.
//  Copyright © 2017年 sts. All rights reserved.
//

import UIKit

class TSLaunchVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bg)

        self.splashAnimate {
            self.presentMainTabVC()
        }
        
    }
    
    //MARK: - private method

//    private func loadData(completionHandler:@escaping ()->()){
//        preloadViewModel.requestData {
//            completionHandler()
//        }
//    }
    
    private func splashAnimate(completionHandler:@escaping ()->()){
        let splashView:UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.image = #imageLiteral(resourceName: "splash_default")
            iv.center = CGPoint.init(x: self.view.tsCenterX, y: self.view.tsCenterY - 60)
            iv.bounds = CGRect.init(x: 0, y: 0, width: tsScreenWidth - 60, height: tsScreenHeight - 60)
            iv.transform = iv.transform.scaledBy(x: 0.01, y: 0.01)
            return iv
        }()
        bg.addSubview(splashView)
        UIView.animate(withDuration: 1, animations: {
            splashView.transform = CGAffineTransform.identity
        }) { (true) in
            let deadline = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
                completionHandler()
            })
        }
        
    }
    
    private func presentMainTabVC(){
        //切换根控制器
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController = TSMainTabbarVC()
            UIApplication.shared.keyWindow?.sendSubview(toBack: (UIApplication.shared.keyWindow?.rootViewController?.view)!)
        };
    }
    
    //MARK: - PROPERTY
//    lazy var preloadViewModel: TSPreloadViewModel = {
//        return TSPreloadViewModel()
//    }()
    lazy var bg:UIImageView = {
        let rect = self.view.bounds
        let iv = UIImageView.init(frame: rect)
        iv.image = #imageLiteral(resourceName: "splash_bg")
        return iv
    }()
}
