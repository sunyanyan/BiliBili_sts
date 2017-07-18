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
let tsSlideMenuViewHeight:CGFloat = 30.0

let tsPageMenuHeight:CGFloat = 30.0

let tsCollectionViewItemSpace:CGFloat = 12.0
let tsCollectionViewLineSpace:CGFloat = 8.0

//MARK: - COLOR
let tsNavTintColor = UIColor.hexString(hex: "ff6699")//粉色
let tsBackgroundGreyColor = UIColor.hexString(hex: "f4f4f4")



//MARK: - UserDefaults
let TSUserDefaults:UserDefaults = UserDefaults.standard
let tsLocalPreloadModelKey:String = "localPreloadModelKey"
