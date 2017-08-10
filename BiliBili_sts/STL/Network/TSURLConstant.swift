//
//  TSURLConstant.swift
//  BiliBili_sts
//
//  Created by sts on 2017/6/20.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation

//MARK: - NETWORK
let tshttp = "http:"
let tsBilibiliHost = "http://m.bilibili.com"
let tsBilibiliApiHost = "http://api.bilibili.com"
let tsBilibiliCommentHost = "http://comment.bilibili.com"
let tsHeaders: [String : String] = [
    "Accept-Encoding":"gzip, deflate, sdch",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "Accept-Language":"zh-CN,zh;q=0.8,en;q=0.6",
    "User-Agent":"Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1"
]
let tsIndexUrl = tsBilibiliHost + "/index.html"
let tsDingUrl = tsBilibiliHost + "/index/ding.html"
let tsWebShowUrl = tsBilibiliApiHost + "/x/web-show/res/loc?jsonp=jsonp&pf=7&id=1695"
let tsWebInterfaceDynamicUrl = tsBilibiliApiHost + "/x/web-interface/dynamic/index?jsonp=jsonp"

func tsVideoUrl(aid:String) -> String {
    let tsVideoUrlPrefix = tsBilibiliHost + "/video/av"
    let url = tsVideoUrlPrefix + aid + ".html"
    return url
}

func tsPlayUrl(aid:String)->String{
    let tsPlayUrlPrefix = tsBilibiliApiHost + "/playurl?callback=callbackfunction&aid="
    let tsPlayUrlSuffix = "&page=1&platform=html5&quality=1&vtype=mp4&type=jsonp"
    let url = tsPlayUrlPrefix + aid + tsPlayUrlSuffix
    return url
}

func tsPlayedVideoRelatedUrl(aid:String ) -> String  {
    let urlPrefix = tsBilibiliCommentHost + "/recommendnew,"
    let url = urlPrefix + aid
    return url 
}

func tsPlayedVideoCommentUrl(aid:String ) -> String  {
    let urlPrefix = tsBilibiliApiHost + "/x/v2/reply?jsonp=jsonp&type=1&sort=2&oid="
    let urlSuffix = "&pn=1&nohot=1"
    let url = urlPrefix + aid + urlSuffix
    return url
}
