//
//  TTSURLRouteConfigDelegate.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/4/19.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation
@objc protocol TTSURLRouteConfigDelegate {
    
    @objc optional func route_isLogin() -> Bool
    
    @objc optional func route_externalMemberID() -> String
    
    @objc optional func route_version() -> String
    
    @objc optional func route_versionType() -> String
    
    @objc optional func route_refid() -> String
    
    @objc optional func route_deviceID() -> String

}
