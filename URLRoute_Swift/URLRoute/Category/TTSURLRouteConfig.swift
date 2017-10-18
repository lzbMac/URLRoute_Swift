//
//  TTSURLRouteConfig.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/4/19.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation
import UIKit

let kRouteConfigClass = "_class"
let kRouteConfigBundle = "_bundle"
let kRouteConfigNib = "_nib"

let kRouteConfigHold = "_hold"
let kRouteConfigWantLogin = "_login"
let kRouteConfigCheckKeys = "_checkKeys"
let kRouteConfigPassKeys = "_passKeys"

//let kRouteResultNative     = "ttsclient";     //跳转native页面
//let kRouteResultExternal   = "external";      //跳转外部
//let kRouteResultWeb        = "http";          //跳转web
//let kRouteResultSECWeb     = "https";         //跳转web
//let kRouteResultFile       = "file";          //等价web
//let kRouteResultClient     = "ttsicar";      //外部浏览器启动客户端

class TTSURLRouteConfig: NSObject {
    
    private var p_routeDictionary: NSMutableDictionary?
    fileprivate var configDelegate: TTSURLRouteConfigDelegate?
    
    static var instance:TTSURLRouteConfig? = nil
    
    required override init() {
        
    }
    
    fileprivate class func defaultRouteConfig() -> TTSURLRouteConfig {
        DispatchQueue.once(token: "TTSURLRouteConfig_once_token") { 
            instance = self.init()
        }
        return instance!
    }
    
    
    
    class func addRoute(routeDictionary: NSDictionary) {
        if routeDictionary.allValues.count == 0 {
            return
        }
        let routeConfig = TTSURLRouteConfig.defaultRouteConfig()
        let dic = [kRouteResultNative,kRouteResultWeb, kRouteResultFile, kRouteResultSECWeb]
        for key in dic {
            let oldDict: NSMutableDictionary = routeConfig.p_routeDictionary?[key] as! NSMutableDictionary
            let newDict = routeDictionary[key]
            
            if let dict = newDict {
                oldDict.addEntries(from: (dict as! NSDictionary) as! [AnyHashable : Any])
            }
            
            routeConfig.p_routeDictionary?[key] = oldDict
        }
    }
    
    class func addRoute(path: String) {
        if path.characters.count == 0 {
            return
        }
        var listData: NSDictionary?
        let filePath = Bundle.main.path(forResource: path, ofType: "plist")
        listData = NSDictionary(contentsOfFile: filePath!)
        addRoute(routeDictionary: listData ?? [:])
        
    }
    
    class func addRoute(paths: [String]) {
        for path in paths {
            addRoute(path: path)
        }
        
    }
    
    class func routeDictionary() -> NSDictionary? {
        let routeConfig = self.defaultRouteConfig()
        let dict = routeConfig.p_routeDictionary?.copy()
        return dict as? NSDictionary
    }
    
    class func registerURLRouteConfig<T: TTSURLRouteConfigDelegate>(className: T.Type) {
        let routeConfig = self.defaultRouteConfig()
        let delagate = (className as! NSObject.Type).init()
        routeConfig.configDelegate = delagate as? TTSURLRouteConfigDelegate
    }
}


//MARK: Extension
extension TTSURLRouteConfig {
    static  var route_isLogin: Bool {
        get {
            let defaultInstance = self.defaultRouteConfig()
            return (defaultInstance.configDelegate?.route_isLogin!())!
        }
    }
}

