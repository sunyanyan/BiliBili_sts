//
//  AppDelegate.swift
//  BiliBili
//
//  Created by sts on 2017/5/10.
//  Copyright © 2017年 sts. All rights reserved.
//

import UIKit
import GDPerformanceView_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        initLaunchVC()
        openPFS()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
 
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
 
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
 
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
 
    }

    func applicationWillTerminate(_ application: UIApplication) {
        closePFS()
    }
    //MARK: - Private Method
    private func initLaunchVC(){
        
        let keyWindow =  UIWindow(frame: UIScreen.main.bounds)
        window = keyWindow
        window?.makeKeyAndVisible()
        let launchVC = TSLaunchVC()
        window?.rootViewController = launchVC
        
    }
    
    private func openPFS(){
        #if DEBUG
            GDPerformanceMonitor.sharedInstance.startMonitoring()
            GDPerformanceMonitor.sharedInstance.configure(configuration: { (textLabel) in
                textLabel?.backgroundColor = .black
                textLabel?.textColor = .white
                textLabel?.layer.borderColor = UIColor.black.cgColor
            })
            GDPerformanceMonitor.sharedInstance.appVersionHidden = true
            GDPerformanceMonitor.sharedInstance.deviceVersionHidden = true
        #endif
    }
    private func closePFS(){
        #if DEBUG
            GDPerformanceMonitor.sharedInstance.stopMonitoring()
        #endif
    }
 
}

