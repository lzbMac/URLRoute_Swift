//
//  URLRouteConfigDelegate.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/10.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation

@objc protocol URLRouteConfigDelegate: class{
    func route_isLogin()    -> Bool
    func route_memberID()   -> String?
    func route_version()    -> String?
    @objc optional func route_deviceID()   -> String?
    
}
