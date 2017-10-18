//
//  URLRoute.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/11.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit

class URLRoute: NSObject {
    typealias URLRouteCompleteBlock = (URLRouteResult, [String: Any]?) -> ()
    
    static let defaultURLRoute: URLRoute = URLRoute.init()
    
    private var routeDictionary = URLRouteConfig.routeDictionary()
    
    func route(_ url: URL, options: [String: Any], completeBlock: @escaping URLRouteCompleteBlock) -> Bool {
        let isStandard = URLRouteScheme.isStandard(url: url)
        if isStandard {
            var blockParam = [String: Any]()
            options.forEach({ (key, value) in
                blockParam[key] = value
            })
            
            let routeScheme = URLRouteScheme.init(url)
            routeScheme.parameter?.forEach({ (key, value) in
                blockParam[key] = value
            })
            blockParam[kRouteResultUseableURL] = routeScheme.useableURL;
            blockParam[kRouteResultOriginalURL] = routeScheme.originalURL;
            
            let routeResult = URLRouteResult.init(scheme: routeScheme.scheme)
            if let vc = blockParam[kRouteResultLastViewController] {
                routeResult.lastViewController = (vc as! UIViewController)
            }
                
            routeResult.parameter = blockParam;
            
            switch routeResult.openType {
            case .native:
                //根据这个对象在routeDictionary里获取对应的ViewController类
                guard let schemeDictionary = self.routeDictionary[routeScheme.scheme!]  else {
                    return false
                }
                guard let moduleDictionary = (schemeDictionary as! [String: Any])[routeScheme.module!]  else {
                    print("TCTURLRoute module值错误：“\(routeScheme.module!)”不存在")
                    return false
                }
                
                guard let pageDictionary = (moduleDictionary as! [String: Any])[routeScheme.page!]  else {
                    print("TCTURLRoute module值错误：“\(routeScheme.page!)”不存在")
                    return false
                }
                
                let bundleName = (pageDictionary as! [String: Any])[kRouteConfigBundle]
                routeResult.viewController = target_viewController(pageDictionary: pageDictionary as! [String: Any], bundleName: bundleName as? String)

                let rHold = routeHold(pageDictionary: (pageDictionary as! [String: Any]))
                let needLogin = url.isNeedLogin
                if needLogin {
                 rHold?.wantLogin = true
                }
                if rHold != nil {
                    rHold?.dealHold(routeResult, completeBlock: completeBlock)
                }else {
                    completeBlock(routeResult, blockParam)
                }
                
            case .web:
                guard let pageDictionary = routeDictionary[routeScheme.scheme!] else{
                    assertionFailure("URLRoute page值错误：“\(routeScheme.scheme!)”不存在")
                    return false
                }
                routeResult.viewController = target_viewController(pageDictionary: pageDictionary as! [String: Any], bundleName: nil)
                routeResult.parameter = blockParam
                let rHold = routeHold(pageDictionary: (pageDictionary as! [String: Any]))
                let needLogin = url.isNeedLogin
                if needLogin {
                    rHold?.wantLogin = true
                }
                if rHold != nil {
                    rHold?.dealHold(routeResult, completeBlock: completeBlock)
                }else {
                    completeBlock(routeResult, blockParam)
                }

                
            case .external:
                completeBlock(routeResult, blockParam)
                
                
            default: break
                
            }
        }else {//20160307 错误规则直接跳转外部
            let scheme = "http"
            let routeResult = URLRouteResult.init(scheme: scheme)
            routeResult.lastViewController = options[kRouteResultLastViewController] as? UIViewController
            routeResult.parameter = options
            
            let pageDictionary = self.routeDictionary[scheme]
            routeResult.viewController = target_viewController(pageDictionary: pageDictionary as! [String : Any], bundleName: nil)
            routeResult.parameter = options
            
            let rHold = routeHold(pageDictionary: (pageDictionary as! [String: Any]))
            if rHold != nil {
                rHold?.dealHold(routeResult, completeBlock: completeBlock)
            }else {
                completeBlock(routeResult, options)
            }
        }
        
        return false
    }
    
    func target_viewController(pageDictionary: [String: Any], bundleName: String?) -> UIViewController? {
        if let pageClassName = pageDictionary[kRouteConfigClass] {
            var pageBundleName = bundleName
            if let page = pageDictionary[kRouteConfigBundle] {
                pageBundleName = page as? String
            }
            let pageNibName = pageDictionary[kRouteConfigNib] ?? pageClassName
            
            //方法 NSClassFromString 在Swift中已经不起作用了no effect，需要适当更改
            // 1.获取命名空间
            // 通过字典的键来取值,如果键名不存在,那么取出来的值有可能就为没值.所以通过字典取出的值的类型为AnyObject?
            guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
                print("命名空间不存在")
                return nil
            }
            // 2.通过命名空间和类名转换成类
            let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + (pageClassName as! String))
            // swift 中通过Class创建一个对象,必须告诉系统Class的类型
            guard let clsType = cls as? UIViewController.Type else {
                print("无法转换成UIViewController")
                return nil
            }
            var bundle: Bundle? = nil
            if (pageBundleName != nil) {
                bundle = Bundle(path: Bundle.main.path(forResource: pageBundleName, ofType: "bundle")!)
            }
            var retObj: UIViewController?
            
            if let _ = bundle{
                retObj = clsType.init(nibName: (pageNibName as? String), bundle: bundle)
                return retObj
            }else {
                return clsType.init()
            }
        }
        return nil
    }
    
    func routeHold(pageDictionary: [String: Any]) -> URLRouteHold? {
        let pageHoldDictionary = pageDictionary[kRouteConfigHold] as? [String : Any]
        
        if let pageHoldDict = pageHoldDictionary {
            let routeHold = URLRouteHold()
            routeHold.holdController = pageHoldDict[kRouteConfigClass] as? String;    //类最后处理
            routeHold.wantLogin = pageHoldDict[kRouteConfigWantLogin] as? Bool ?? false;
            routeHold.passKeys = pageHoldDict[kRouteConfigPassKeys] as? [String];
            routeHold.checkKeys = pageHoldDict[kRouteConfigCheckKeys] as? [String];
            return routeHold
        }
        return nil
    }
}
