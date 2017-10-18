//
//  URLRoutePopProtocol.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/12.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation
@objc protocol URLRoutePopProtocol: NSObjectProtocol {
    
    /// 使用url路由返回时，对viewcontroller进行数据配置
    ///
    /// - Parameter param: 传入的url字典数据，包括页面具体参数
    @objc optional func routePopOut(param: [String: Any])
}
