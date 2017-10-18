//
//  UIViewController+URLRoute.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/12.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation
import UIKit

let URLRouteHandleErrorNotification = "URLRouteHandleErrorNotification"
let URLRouteHandleCompleteNotification = "URLRouteHandleCompleteNotification"

let kURLRouteOpenAnimated = "kURLRouteOpenAnimated"           //是否需要动画
let kURLRouteOpenAnimatedTransition = "kURLRouteOpenAnimatedTransition" //动画形式
let kURLRouteOpenCompletion = "kURLRouteOpenCompletion"         //完成后回调操作
let p_route_URLRoute = URLRoute()

enum URLRouteOpenAnimatedTransition {
    case push
    case present
}

extension UIViewController {
    
    func openRoute(_ url: URL, options: [String: Any]) {
        if url.absoluteString.isEmpty {
            return
        }
        let newURL = url
        var dictionary = [String: Any]()
        if let vc = p_route_lastViewController() {
            dictionary[kRouteResultLastViewController] = vc
        }
        dictionary[kRouteResultUseableURL] = newURL
        for (key, value) in options {
            dictionary[key] = value
        }
        p_route_openRoute(routeURL: newURL, dict: dictionary)
    }
    
    private func p_route_lastViewController() -> UIViewController? {
        var viewController: UIViewController? = nil
        if self.isKind(of: UINavigationController.self) {
            viewController = (self as! UINavigationController).topViewController
        }else if self.isKind(of: UIViewController.self) {
            viewController = self
        }else {
            assert(false,"CTURLRoute Tip:缺少Nav")
        }
        return viewController
    }
    
    private func p_route_openRoute(routeURL: URL, dict: [String: Any]) {
        let success = p_route_URLRoute.route(routeURL, options: dict) { (result, otherOptions) in
            var options: [String: Any]
            if otherOptions != nil {
                options = otherOptions!
            }else {
                options = dict
            }
            switch result.openType {
            case .web, .native:
                let viewController = result.viewController
                let lastVc = result.lastViewController
                
                viewController?.routeCallBackViewController = lastVc
                let parm = result.parameter
                
                if let _ = lastVc, let viewCtl = viewController {
                    if viewCtl is URLRoutePushProtocol {
                        (viewCtl as? URLRoutePushProtocol)?.routeWillPushController?(param: parm)
                    }
                    let allOpenKeys = options.keys
                    
                    var animated = true
                    if allOpenKeys.contains(kURLRouteOpenAnimated) {
                        animated = (options[kURLRouteOpenAnimated] as? String) == "0"
                    }
                    
                    var completion: (() -> ())?
                    if allOpenKeys.contains(kURLRouteOpenCompletion) {
                        completion = (options[kURLRouteOpenCompletion] as? () -> ())!
                    }
                    
                    var openType: URLRouteOpenAnimatedTransition = .push
                    
                    if allOpenKeys.contains(kURLRouteOpenAnimatedTransition) {
                        openType = options[kURLRouteOpenAnimatedTransition] as! URLRouteOpenAnimatedTransition;
                    }
                    
                    switch openType {
                        case .push:
                            lastVc?.navigationController?.pushViewController(viewCtl, animated: animated)
                        case .present:
                            lastVc?.present(viewCtl, animated: animated, completion: completion)
                    }
                    
                    if viewCtl is URLRoutePushProtocol {
                        (viewCtl as? URLRoutePushProtocol)?.routeDidPushController?(param: parm)
                    }
                    
                }
                break
                
            case .external:
                if let URL = options[kRouteResultUseableURL] as? URL {
                    UIApplication.shared.open(URL, options: [String : Any](), completionHandler: nil)
                }
                break
                
            default:break
            }
        
        }
        
        if success {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: URLRouteHandleCompleteNotification), object: dict)
        }else {
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: URLRouteHandleErrorNotification), object: routeURL)
        }
    }
    
    func openLogin(completion: ((Bool , [String: Any]) -> ())?) {
        let options = [kRouteHoldLastViewController: self]
        if URLRouteConfig.route_isLogin() {
            if let completions = completion {
                completions(true, options)
            }
        }else {
            let loginDelegate = URLRouteHoldConfig.defaultHoldConfig.loginDelegate;
            if let loginDelegate = loginDelegate {
                loginDelegate.startLogin(successBlock: { (isLogin) in
                    if let completions = completion {
                        completions(isLogin, options)
                    }
                }, options: options)
            }
        }
    }
            
}

extension UIViewController{
    func openRoute(urlString: String, options:[String: Any]?) {
        guard urlString.characters.count > 0 else {
            return
        }
        let url = URL.routeURL(URLString: urlString)
        var dictionary = [String: Any]()
        dictionary[kRouteOriginalURLString] = urlString
        if let pramas = options {
            for (key, value) in pramas {
                dictionary[key] = value
            }
        }
        if url != nil {
            openRoute(url!, options: dictionary)
        }
        
    }
}

private let key = UnsafeRawPointer(bitPattern: "holdObject".hashValue)

extension UIViewController {
    
    var holdObject: AnyObject? {
        get {
            return objc_getAssociatedObject(self, key) as AnyObject
        }
        
        set {
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
}
