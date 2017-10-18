//
//  URLRouteResult.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/11.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit
enum URLRouteOpenType {
    case undefine
    case web
    case native
    case external
}
let kRouteResultNative     = "ttsclient"
let kRouteResultExternal   = "external"
let kRouteResultWeb        = "http"
let kRouteResultSECWeb     = "https"
let kRouteResultFile       = "file"
let kRouteResultClient     = "tticar" //外部浏览器启动客户端（自己app的Scheme）

let kRouteResultLastViewController = "kRouteResultLastViewController"
let kRouteResultUseableURL = "kRouteResultUseableURL"
let kRouteResultOriginalURL = "kRouteResultOriginalURL"
let kRouteOriginalURLString = "kRouteOriginalURLString"

class URLRouteResult: NSObject {
    
    var openType: URLRouteOpenType = .undefine
    
    var viewController: UIViewController?
    
    var lastViewController: UIViewController?
    
    var parameter = [String: Any]()
    
    
    convenience init(scheme: String?) {
        self.init()
        if let scheme = scheme {
            switch scheme {
            case kRouteResultNative:
                self.openType = .native
            case kRouteResultExternal:
                self.openType = .external
            case kRouteResultWeb,kRouteResultFile,kRouteResultSECWeb:
                self.openType = .web
            default: break
            }
        }
    }
}
