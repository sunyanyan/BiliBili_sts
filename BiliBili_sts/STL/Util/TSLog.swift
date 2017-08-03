//
//  TSLog.swift
//  BiliBili_sts
//
//  Created by sts on 2017/5/17.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation

func TSLog<T>(message: T,
              file: String = #file,
              method: String = #function,
              line: Int = #line)
{
    
//    var string = "\n\nfile: \((file as NSString).lastPathComponent) \n"
//            +"  line:[\(line)], \n  method:\(method) \n  msg:\(message)"

    let dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd HH:mm:ss:SSS", options: 0, locale: NSLocale.current)
    let dateFormatter = DateFormatter.init()
    dateFormatter.dateFormat = dateFormat
    let dateStr = dateFormatter.string(from: Date.init())
    
    let timeInfo:String = "\(dateStr)"
    let fileInfo:String = " file: \((file as NSString).lastPathComponent) "
    let lineInfo:String = " line:[\(line)] method:[\(method)]"
    let msgInfo:String = "\nmsg:\(message)\n"
    let str = timeInfo + fileInfo + lineInfo + msgInfo
    print(str)
    
}
