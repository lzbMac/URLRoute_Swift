//
//  URLRouteConfig.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/9.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation
class URLRouteConfig {
    static let kRouteConfigClass: String = "_class"
    static let kRouteConfigBundle: String = "_budle"
    static let kRouteConfigNib: String = "_nib"
    
    static let kRouteConfigHold: String = "_hold"
    static let kRouteConfigWantLogin: String = "_login"
    static let kRouteConfigWantHybrid: String = "_hybrid"
    static let kRouteConfigCheckKeys: String = "_checkKeys"
    static let kRouteConfigPassKeys: String = "_passKeys"
    static let kRouteConfigWantLocation: String = "_location"
    
    var p_routeDictionary = [String: Any]()
    var configDelegate: URLRouteConfigDelegate?
    
    init() {
        
    }
    
    static let defaultRouteConfig: URLRouteConfig  = URLRouteConfig()
    
    class func addRoute(dictionary: NSDictionary) {
        let routeConfig = URLRouteConfig.defaultRouteConfig
        let keys = [kRouteResultNative, kRouteResultWeb, kRouteResultFile, kRouteResultSECWeb]
        for  key in keys {
            var oldDict = routeConfig.p_routeDictionary[key] as? Dictionary ?? [String: Any]()
            
            if let newDict = dictionary[key] as? NSDictionary {
                for (key1, value1) in newDict {
                    oldDict[key1  as! String] = value1
                }
            }
            
            if !oldDict.isEmpty {
                routeConfig.p_routeDictionary[key] = oldDict
            }
            
        }
    }
    
    class func addRoute(plistPath: String) {
        let dict = NSDictionary(contentsOfFile: plistPath)
        
        if dict != nil {
            addRoute(dictionary: dict!)
        }
        
        
//        let path = URL(string: plistPath)
        
//        if let plistPath = path {
        
//            do {
//                let plistData = try Data(contentsOf: plistPath)
//
//                do {
//                    let dictionary = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainers, format: nil)
//                    addRoute(dictionary: dictionary as! [String : Any])
//                } catch {
//                    print(error)
//                }
//
//            } catch  {
//                print(error)
//            }
//    }
    }

    class func addRoute(plistPaths: [String]) {
        for plistPath in plistPaths {
            addRoute(plistPath: plistPath)
        }
    }
    //MARK:--
    class func routeDictionary() -> [String: Any] {
        let routeConfig = URLRouteConfig.defaultRouteConfig
        let routeDictionary = routeConfig.p_routeDictionary
        return routeDictionary
    }
    
    class func registerURLRouteConfig(configClass: URLRouteConfigDelegate.Type?) {
        precondition(configClass != nil, "\(String(describing: configClass)) Class：不存在")
        let cls = configClass as! NSObject.Type
        URLRouteConfig.defaultRouteConfig.configDelegate = cls.init() as? URLRouteConfigDelegate
    }
}
