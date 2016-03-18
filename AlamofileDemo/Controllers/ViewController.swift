//
//  ViewController.swift
//  AlamofileDemo
//
//  Created by Zhangyao on 14/2/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = .Indeterminate
        hud.opacity = 0.6
        hud.labelText = "Loading"
        hud.removeFromSuperViewOnHide = true
        AFDataAccessRequest.fetchLibraries(success: { result in
                if let baseModel:BaseModel = result as? BaseModel {
                    print(baseModel)
                }
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            })
            { failureResult in
                print(failureResult)
                MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        print("do other task")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

