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
    
    let string = "\n\nfile: \((file as NSString).lastPathComponent) \n  line:[\(line)], \n  method:\(method) \n  msg:\(message)"
    print(string)
    
}
