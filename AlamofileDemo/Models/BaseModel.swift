//
//  BaseModel.swift
//  AlamofileDemo
//
//  Created by Zhangyao on 17/3/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import ObjectMapper

class BaseModel: Mappable {
    
    var products:[ProductModel]?
    var totalCount:Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        products <- map["result"]
        totalCount <- map["totalCount"]
    }

}
