//
//  Constant.swift
//  BiliBili
//
//  Created by sts on 2017/5/10.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

//MARK: - FRAME
let tsScreenWidth = UIScreen.main.bounds.width
let tsScreenHeight = UIScreen.main.bounds.height
let tsTabbarHeight:CGFloat = 49.0
let tsStatusBarHeight:CGFloat = 20.0
let tsNavBarHeight:CGFloat = 44.0

let tsPageMenuHeight:CGFloat = 30.0

let tsCollectionViewItemSpace:CGFloat = 12.0
let tsCollectionViewLineSpace:CGFloat = 0.0

//MARK: - COLOR
let tsNavTintColor = UIColor.hexString(hex: "ff6699")
let tsBackgroundGreyColor = UIColor.hexString(hex: "f4f4f4")

//MARK: - NETWORK
let tshttp = "http:"
let tsBilibiliHost = "http://m.bilibili.com"
let tsHeaders: [String : String] = [
    "Accept-Encoding":"gzip, deflate, sdch",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "Accept-Language":"zh-CN,zh;q=0.8,en;q=0.6",
    "User-Agent":"Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1"
]
let tsIndexUrl = tsBilibiliHost + "/index.html"
let tsDingUrl = tsBilibiliHost + "/index/ding.html"
let tsWebShowUrl = tsBilibiliHost + "/x/web-show/res/loc?jsonp=jsonp&pf=7&id=1695"

//MARK: - UserDefaults
let TSUserDefaults:UserDefaults = UserDefaults.standard
let tsLocalPreloadModelKey:String = "localPreloadModelKey"
