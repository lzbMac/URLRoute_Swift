//
//  URLRouteCallBackProtocol.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/12.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation
@objc protocol URLRouteCallBackProtocol: NSObjectProtocol {
    
    /// route回调数据，A->URLRoute[->Hold]->B，则A需要实现
    ///
    /// - Parameter param: B页面回传的数据
    @objc optional func routeCallBack(param: [String: Any])
}
