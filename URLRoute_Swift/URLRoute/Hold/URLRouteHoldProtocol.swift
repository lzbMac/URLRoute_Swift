//
//  URLRouteHoldProtocol.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/11.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation
//堆栈的最后一个页面控制器
let kRouteHoldLastViewController = "TCTURLRouteHoldLastViewController"
//URL生成的ViewController
let kRouteHoldViewController = "kRouteHoldViewController"
//URL生成的属性参数
let kRouteHoldParameter = "kRouteHoldParameter"
protocol URLRouteHoldProtocol: AnyObject {
    /// 拦截URLRoute，自定义Hold
    ///
    /// - Parameter parameters: 你所能得到的参数
    func hold(parameters: [String: Any])
}
