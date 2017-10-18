//
//  TTSURLBridge.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/4/19.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit

class TTSURLBridge: NSObject {
    static func routeURL(module: String, page: String, parameter:NSDictionary) -> NSURL {
        var paramString = ""
        for (key, value) in parameter {
             paramString.append("\(key)=\(value)&")
        }
        let param = paramString.substring(to: paramString.index(before: paramString.endIndex))
        let URLString = "ttsclient://\(module)/\(page)?\(param)"
        
        return NSURL(string: URLString)!
    }
}

protocol hhahhah {
    
}

class Haozi: NSObject, hhahhah {
    
}

class Bier {
    func heheheh<T: hhahhah>(classN: T.Type) {
        
    }
    
    func laia() {
        heheheh(classN: Haozi.self)
    }
}
 
