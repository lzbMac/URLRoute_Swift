//
//  IndexSearchViewController.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/10/16.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit

class IndexSearchViewController: UIViewController, URLRoutePushProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func routeWillPushController(param: [String : Any]) {
        let color = param["color"] as? String
        if color == "1"{
            view.backgroundColor = UIColor.cyan
        }
        let title = param["title"] as? String
        self.title = title
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
