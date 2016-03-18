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
                if let baseModel:BaseModel = result as? BaseModel {
                    print(baseModel)
                }
            })
            { failureResult in
                print(failureResult)
        }
        print("do other task")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

