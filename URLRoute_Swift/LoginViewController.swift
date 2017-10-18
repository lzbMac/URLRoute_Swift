//
//  LoginViewController.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/15.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    var loginCompletion: ((Bool) -> ())?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClick(_ sender: Any) {
        loginCompletion?(true)
        dismiss(animated: true, completion: nil)
    }
    func startLogin(successBlock: @escaping (Bool) -> (), options: [String : Any]) {
        self.loginCompletion = successBlock
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
