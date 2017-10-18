//
//  URLRouteHoldConfig.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/11.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit
protocol URLRouteHoldLoginDelegate: AnyObject {
    // 注册登录的类需要实现的协议方法
    func startLogin(successBlock: @escaping (Bool) -> (), options: [String: Any])
}

class URLRouteHoldConfig {
    
    private(set) var loginDelegate: URLRouteHoldLoginDelegate?
    
    static let defaultHoldConfig: URLRouteHoldConfig = URLRouteHoldConfig()
    
    /// 注册登录协议，由URLRoute默认实现
    ///
    /// - Parameter class: Hold登录类，类需实现TCTURLRouteHoldLoginDelegate协议
    static func registerURLRouteHoldLogin(loginClass: URLRouteHoldLoginDelegate.Type) {
        
        if let loginClass1 =  loginClass as? NSObject.Type{
            let login = loginClass1.init()
            URLRouteHoldConfig.defaultHoldConfig.loginDelegate = login as? URLRouteHoldLoginDelegate
        }
    }
}
