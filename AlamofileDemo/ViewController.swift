//
//  ViewController.swift
//  AlamofileDemo
//
//  Created by Zhangyao on 14/2/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AFDataAccessRequest.fetchLibraries(success: { result in
            print(result)
            }) { failureResult in
                print(failureResult)
        }
        
        print("do other task")
        
       UIView.animateWithDuration(1, animations: { () -> Void in
        
        }, completion: { (finished) -> Void in
            
       })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

