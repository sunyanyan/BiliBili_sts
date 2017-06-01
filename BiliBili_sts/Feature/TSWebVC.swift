//
//  TSWebView.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/27.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit
import WebKit

//@objc protocol TSPresentedViewControllerDelegate{
//    @objc optional func presentedViewControllerDidClickedDismissButton(presentedViewController:UIViewController)
//}

//TODO: 点击网页中链接

class TSWebVC :UIViewController{
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadUrl()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    //MARK:- Property
    
    lazy var webView: WKWebView = {
        let wv = WKWebView()
        wv.frame = self.view.bounds
        wv.navigationDelegate = self
        return wv
    }()
    
    lazy var backBtn: [UIBarButtonItem] = {
        
        let spacer = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spacer.width = -16
        
        let btn = UIButton()
        btn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        btn.setImage(#imageLiteral(resourceName: "arrow_back_white"), for: UIControlState.normal)
        btn.setImage(#imageLiteral(resourceName: "arrow_back_white"), for: UIControlState.highlighted)
        let btnItem = UIBarButtonItem.init(customView: btn)
        btn.addTarget(self, action: #selector(backBtnClick), for: UIControlEvents.touchUpInside)
        
        return [spacer,btnItem]
    }()
    
    lazy var rightBtn:[UIBarButtonItem] = {
        let spacer = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spacer.width = -20
        
        let btn = UIButton()
        btn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        btn.setImage(#imageLiteral(resourceName: "more_light"), for: UIControlState.normal)
        btn.setImage(#imageLiteral(resourceName: "more_light"), for: UIControlState.highlighted)
        let btnItem = UIBarButtonItem.init(customView: btn)
        btn.addTarget(self, action: #selector(moreBtnClick), for: UIControlEvents.touchUpInside)
        
        return [spacer,btnItem]
    }()
    
    
    public var webUrlStr:String?
//    public var presentedViewControllerDelegate:TSPresentedViewControllerDelegate?
    
}

// MARK: - WKNavigationDelegate
extension TSWebVC:WKNavigationDelegate{
    //页面开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        TSLog(message: "")
    }
    //获取到网页内容后返回
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        TSLog(message: "")
    }
    //页面加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        TSLog(message: "")
        
        setupTitle(webView: webView)
        hideWebViewTitle(webView: webView)
    }
    //页面加载失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        TSLog(message: "error : \(error)")
    }
}

// MARK: - Event
extension TSWebVC{
    
    func setupUI(){
        view.addSubview(webView)
        navigationItem.leftBarButtonItems = backBtn
        navigationItem.rightBarButtonItems = rightBtn
        navigationController?.navigationBar.barTintColor = tsNavTintColor
    }
    
    func loadUrl (){
        guard let url = webUrlStr else { return  }
        guard let nsUrl = URL.init(string: url) else { return }
        let request = URLRequest.init(url: nsUrl )
        webView.load(request)
        
    }
    
    func backBtnClick(){
        
//        if let delegate = presentedViewControllerDelegate {
//            if let method = delegate.presentedViewControllerDidClickedDismissButton {
//                method(self)
//            }
//        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func moreBtnClick(){
        
        let sheet = UIAlertController.init(title: nil, message: nil, preferredStyle:.actionSheet)
        let cancelBtn = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        let safariBtn = UIAlertAction.init(title: "在Safari中打开", style: .default) { (action) in
            //TODO: 在Safari中打开
            
        }
        let shareBtn = UIAlertAction.init(title: "分享", style: .default) { (action) in
            //TODO: 分享
        }
        sheet.addAction(cancelBtn)
        sheet.addAction(shareBtn)
        sheet.addAction(safariBtn)
        present(sheet, animated: true, completion: nil)
    }
    
    func setupTitle(webView:WKWebView){
        //设置标题
        let titleScript = "document.title"
        webView.evaluateJavaScript(titleScript) { (result, error) in
            let title = result as? String
            if title != nil {
                let titleLbl = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: tsScreenWidth * 0.5, height: 21))
                titleLbl.textColor = UIColor.white
                titleLbl.textAlignment = .center
                titleLbl.text = title
                titleLbl.font = .systemFont(ofSize: 12)
                self.navigationItem.titleView = titleLbl
            }
            
            
        }
    }
    
    /// 隐藏网页中的类似navigationBar的view
    func hideWebViewTitle(webView:WKWebView){
        let hideSctipt = "document.getElementById('act-fav-entry').style.display='none'"
        webView.evaluateJavaScript(hideSctipt, completionHandler: nil)
    }
}
