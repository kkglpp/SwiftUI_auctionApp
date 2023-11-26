//
//  BaseSimpleModel.swift
//  auctionAi
//
//  Created by user on 2023/10/30.
//

import Foundation

struct BaseSimpleJSONModel : Codable{
    var result :String
    var Amount : String
    
}


struct BaseSimpleModel : Hashable{
    var message :String
    var amount : String
    init(message: String, amount: String) {
        self.message = message
        self.amount = amount
    }
    
}

struct PointJSONModel : Codable{
    var message : String
    var result : String
}

struct PointModel : Hashable{
    var message : String
    var result : String
    
    init(message: String, result: String) {
        self.message = message
        self.result = result
    }
}
