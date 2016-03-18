//
//  ProductModel.swift
//  AlamofileDemo
//
//  Created by Zhangyao on 17/3/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import ObjectMapper

class ProductModel: Mappable {
    
    var categoryName: String?
    var depAddress: String?
    var depName: String?
    var depcode: String?
    var depid: String?
    var fleaNumber: String?
    var fleaPrice: Int?
    var isbn: String?
    var libid: String?
    var price: Int?
    var productId: String?
    var productName: String?
    var status: Int?
    var stockNumber: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        categoryName <- map["categoryName"]
        depAddress <- map["depAddress"]
        depName <- map["depName"]
        depcode <- map["depcode"]
        depid <- map["depid"]
        fleaNumber <- map["fleaNumber"]
        fleaPrice <- map["fleaPrice"]
        isbn <- map["isbn"]
        libid <- map["libid"]
        price <- map["price"]
        productId <- map["productId"]
        productName <- map["productName"]
        status <- map["productName"]
        stockNumber <- map["stockNumber"]
    }
}
