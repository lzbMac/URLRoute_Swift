//
//  ViewController.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/4/19.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func gotoSearch(_ sender: Any) {
        openRoute(urlString: "ttsclient://index/search?color=1&title=%E6%90%9C%E7%B4%A2", options: nil)
    }
    
    @IBAction func gotobaidu(_ sender: Any) {
        openRoute(urlString: "https://www.baidu.com", options: ["baidu": "11"])
    }
    
    @IBAction func login(_ sender: Any) {
        openLogin { (isLogin, options) in
            print("登录成功-----------------------")
        }
    }
}

