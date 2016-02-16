//
//  AFDataAccessRequest.swift
//  AlamofileDemo
//
//  Created by Zhangyao on 15/2/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

//import UIKit
import Alamofire

class AFDataAccessRequest: NSObject {
    
    class func requestData(
        method: Method,
        _ URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        success:((AnyObject) -> Void)?,
        failure:((AnyObject) -> Void)?)
    {
        request(method, URLString, parameters:parameters , encoding: .URL, headers: nil).responseJSON(completionHandler: {
            response in
            guard let JSON = response.result.value else {
                if let failureHandler = failure {
                    failureHandler("error")
                }
                return
            }
            if let successHandler = success {
                successHandler(JSON)
            }
        })
    }
    
    // MARK: Private methods
    
    internal class func getJSONStringFromDictionary(dict: NSDictionary) -> String? {
        var jsonString:String? = nil
        do {
            let result = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
            jsonString = String(data: result, encoding: NSUTF8StringEncoding)?.stringByReplacingOccurrencesOfString(" ", withString: "")
        } catch { return jsonString }
        return jsonString
    }
}

