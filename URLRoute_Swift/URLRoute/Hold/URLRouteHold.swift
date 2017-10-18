//
//  URLRouteHold.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/11.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit

class URLRouteHold {
    typealias URLRouteHoldCompleteBlock = (URLRouteResult, [String: Any]) ->()
    var wantLogin: Bool
    var holdController: String?
    
    var checkKeys: [String]?
    var passKeys: [String]?
    
    
    
    private(set) var routeResult: URLRouteResult?
    private(set) var completeBlock: URLRouteHoldCompleteBlock?
    
    
    init() {
        self.wantLogin = false
    }
    func dealHold(_ result: URLRouteResult, completeBlock: @escaping URLRouteHoldCompleteBlock) {
        let holdConfig = URLRouteHoldConfig.defaultHoldConfig
        if wantLogin {
            if let memberID = URLRouteConfig.route_memberID(), memberID.isEmpty{
                wantLogin = false
                dealHold(result, completeBlock: completeBlock)
            }else {
                let loginDelegate = holdConfig.loginDelegate
                let options = [kRouteHoldLastViewController:(result.lastViewController)! ] 
                loginDelegate?.startLogin(successBlock: { (isLogin) in
                    if isLogin {
                        self.wantLogin = false
                        self.dealHold(result, completeBlock: completeBlock)
                    }
                }, options: options)
            }
        }else {
            if let passKeyArr = passKeys {//检查passKeys
                for passKey in passKeyArr {
                    let lastViewController = result.lastViewController
                    let selector = Selector(passKey)
                    
                    if let lasVc = lastViewController, lasVc.responds(to: selector) {
                        let viewController = result.viewController
                        let propertyValue = lastViewController?.value(forKey: passKey)
                        if let vc = viewController, lasVc.responds(to: selector) {
                            vc.setValue(propertyValue, forKey: passKey)
                        }
                    }
                }
            }
            
            if let checkKeyArr = checkKeys {//检查属性
                for checkKey in checkKeyArr {
                    let param = result.parameter
                    assert(param[checkKey] != nil, "链接未提供页面\(checkKey)值")
                }
            }
            
            //自定义操作
            var dontHold = true
            if let holdCtl = self.holdController, !holdCtl.isEmpty{
                //方法 NSClassFromString 在Swift中已经不起作用了no effect，需要适当更改
                // 1.获取命名空间
                // 通过字典的键来取值,如果键名不存在,那么取出来的值有可能就为没值.所以通过字典取出的值的类型为AnyObject?
                guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
                    print("命名空间不存在")
                    return
                }
                // 2.通过命名空间和类名转换成类
                let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + holdCtl)
                // swift 中通过Class创建一个对象,必须告诉系统Class的类型
                guard let clsType = cls as? NSObject.Type else {
                    print("无法转换成Hold对象")
                    return
                }
                
                let holdObj = clsType.init()
                var param = [String: Any]()
                if let viewController = result.viewController {
                    param[kRouteHoldParameter] = viewController
                }
                
                if let lastViewController = result.lastViewController {
                    param[kRouteHoldLastViewController] = lastViewController
                }
                
                param[kRouteHoldParameter] = result.parameter
                
                dontHold = false
                if holdObj is URLRouteHoldProtocol {
                    (holdObj as! URLRouteHoldProtocol).hold(parameters: param)
                }
            }
            if dontHold  {
                completeBlock(result, result.parameter)
            }
            
        }
    }
    
}
