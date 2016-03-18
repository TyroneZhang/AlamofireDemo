//
//  AFLibraryAssistant.swift
//  AlamofileDemo
//
//  Created by Zhangyao on 16/2/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import Foundation
import ObjectMapper

extension AFDataAccessRequest {
    
    class func fetchLibraries(
        parameters: [String: AnyObject]? = nil,
        success:((AnyObject?) -> Void)?,
        failure:((AnyObject?) -> Void)?)
    {
        var para:Dictionary<String , AnyObject> = ["data" : self.getJSONStringFromDictionary(parameters == nil ? ["name": ""] : parameters!)!]
        para["pageNum"] = 1
        self.requestData(.GET, kBaseURL + kLibraryURLString, parameters: para, encoding: .URL, success: { result in
                if let successHandler = success {
                    let dict = result as! NSDictionary
                    let baseModel = Mapper<BaseModel>().map(dict["obj"]!)
                    successHandler(baseModel)
                }
            }) { failureResult in
                if let failureHandler = failure {
                    failureHandler("**************failed")
                }
        }
    }
}