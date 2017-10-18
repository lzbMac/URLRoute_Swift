//
//  URLRoutePushProtocol.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/12.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation
@objc public protocol URLRoutePushProtocol {
    
    /// url路由跳转时，对viewcontroller进行数据配置
    ///
    /// - Parameter param: 传入的url字典数据，包括处理后url的key： kRouteConfigureFormatUrlKey 以及页面具体参数
    @objc optional func routeWillPushController(param: [String: Any])
    
    
    /// 页面push跳转后调用
    ///
    /// - Parameter param: 传入的url字典数据，包括处理后url的key： kRouteConfigureFormatUrlKey 以及页面具体参数
    @objc optional func routeDidPushController(param: [String: Any])
}
