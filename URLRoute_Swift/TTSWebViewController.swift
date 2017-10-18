//
//  TTSWebViewController.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/10/16.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit

class TTSWebViewController: UIViewController, URLRoutePushProtocol {

    @IBOutlet weak var webView: UIWebView!
    var url: URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = self.url else {
            return
        }
        self.webView.loadRequest(URLRequest.init(url: url))

        // Do any additional setup after loading the view.
    }
    func routeWillPushController(param: [String : Any]) {
        if let url = param[kRouteOriginalURLString] as? String {
            self.url = URL(string: url)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
