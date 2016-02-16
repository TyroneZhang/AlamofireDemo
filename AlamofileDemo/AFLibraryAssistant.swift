//
//  AFLibraryAssistant.swift
//  AlamofileDemo
//
//  Created by Zhangyao on 16/2/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import Foundation

extension AFDataAccessRequest {
    
    class func fetchLibraries(
        parameters: [String: AnyObject]? = nil,
        success:((AnyObject) -> Void)?,
        failure:((AnyObject) -> Void)?)
    {
        var para:Dictionary<String , AnyObject> = ["data" : self.getJSONStringFromDictionary(parameters == nil ? ["name": ""] : parameters!)!]
        para["pageNum"] = 7
        self.requestData(.GET, kBaseURL + kLibraryURLString, parameters: para, encoding: .URL, success: { result in
                print(result)
                if let successHandler = success {
                    successHandler("**************success")
                }
            }) { failureResult in
                if let failureHandler = failure {
                    failureHandler("**************failed")
                }
        }
    }
}