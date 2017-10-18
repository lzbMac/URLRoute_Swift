//
//  URLRouteConfig+UserInfo.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/11.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation

extension URLRouteConfig {
    class func route_isLogin() -> Bool {
        guard let _ = URLRouteConfig.defaultRouteConfig.configDelegate else {
            return false
        }
        return URLRouteConfig.defaultRouteConfig.configDelegate!.route_isLogin()
    }
    
    class func route_memberID() -> String? {
        return URLRouteConfig.defaultRouteConfig.configDelegate?.route_memberID()
    }
    
    class func route_version() -> String? {
        return URLRouteConfig.defaultRouteConfig.configDelegate?.route_version()
    }
    
    class func route_deviceID() -> String? {
        if let deviceID = URLRouteConfig.defaultRouteConfig.configDelegate?.route_deviceID?() {
            return deviceID
        }
        
        return nil
    }
}
