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
let tsScreenWidth = Double.init(UIScreen.main.bounds.width)
let tsScreenHeight = Double.init(UIScreen.main.bounds.height)
let tsTabbarHeight = 49.0
let tsStatusBarHeight = 20.0

//MARK: - COLOR
let tsNavTintColor = UIColor.hexString(hex: "ff6699")

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

//MARK: - UserDefaults
let tsUserDefaults:UserDefaults = UserDefaults.standard
let tsLocalPreloadModelKey:String = "localPreloadModelKey"
