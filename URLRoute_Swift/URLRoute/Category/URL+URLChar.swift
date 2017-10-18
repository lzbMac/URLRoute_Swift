//
//  URL+URLWithStringEncode.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/7/14.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation

public extension URL {
    static let kURLRouteCharacherWebViewLogin = "ttsneedlogin"  //链接里需要登录拦截
    
    var isRouteScheme: Bool {
        get {
            return self.scheme?.lowercased() == scheme
        }
    }
    
    var isNeedLogin: Bool {
        get {
            if let _ = self.absoluteString.range(of: URL.kURLRouteCharacherWebViewLogin){
                return true
            }
            return false
        }
    }
    
    
}
