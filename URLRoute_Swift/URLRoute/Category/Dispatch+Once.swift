//
//  Dispatch+Once.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/10.
//  Copyright © 2017年 李正兵. All rights reserved.
//
import Foundation
//objc_sync_enter,上锁
//objc_sync_exit,解锁

// defer 我们将objc_sync_exit(self)放在defer代码块里，这样即使在执行return,会先执行defer里的代码，这样就保证了不管发生什么，最后都会将文件关闭。

//需要注意的是, 虽然说defer的内容会在return之前执行, 但是如果defer定义在return之后, 那么还是不会执行defter的内容, 也就是说, defer关键字必须比return早出现

//拓展dispatch_once
public extension DispatchQueue {
    private static var _onceTracker = [String]()
    
    public class func once(token: String ,block:()->Void){
        objc_sync_enter(self)
        defer { objc_sync_exit(self)}
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
