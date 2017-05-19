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
    print("file: \((file as NSString).lastPathComponent) line:[\(line)], method:\(method) msg:\(message)")
}
