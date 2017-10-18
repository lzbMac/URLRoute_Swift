//
//  IndexSearchHold.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/10/16.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit

class IndexSearchHold: NSObject, URLRouteHoldProtocol {
    func hold(parameters: [String : Any]) {
        let lastVc = parameters[kRouteHoldLastViewController] as? UIViewController
        let vc = IndexSearchViewController.init()
        vc.view.backgroundColor = UIColor.white
        vc.routeCallBackViewController = lastVc;
        lastVc?.navigationController?.pushViewController(vc, animated: true)
    }
}
