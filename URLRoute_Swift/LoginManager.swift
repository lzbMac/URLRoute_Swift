//
//  LoginManager.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/15.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit

class LoginManager: NSObject, URLRouteHoldLoginDelegate {
    func startLogin(successBlock: @escaping (Bool) -> (), options: [String : Any]) {
        if let viewCtl = options[kRouteHoldLastViewController] as? UIViewController{
            let login = LoginViewController.init()
            login.loginCompletion = successBlock
            viewCtl.present(login, animated: true, completion: nil)
        }
        
        
    }
}
