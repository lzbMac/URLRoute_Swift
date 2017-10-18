//
//  UIViewController+URLRouteCallBack.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/15.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit
import ObjectiveC

let URLRouteCallBackSourceClass = "URLRouteCallBackSourceClass"

private let key = UnsafeRawPointer(bitPattern: "routeCallBackViewController".hashValue)

extension UIViewController {
    weak var routeCallBackViewController: UIViewController? {
        set {
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, key) as? UIViewController
        }
    }
    
    func route(callback: [String: Any]) {
        if let lastViewController = routeCallBackViewController {
            if lastViewController is URLRouteCallBackProtocol {
                (lastViewController as! URLRouteCallBackProtocol).routeCallBack?(param: callback)
            }
        }
    }
}
