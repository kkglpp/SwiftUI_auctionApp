//
//  BidupModel.swift
//  auctionAi
//
//  Created by user on 2023/10/30.
//

import Foundation

struct BidupJSONModel:Codable{
    var message : String
    var result : String
}

struct BidupModel:Hashable{
    var message : String
    var result : String
    
    init(message: String, result: String) {
        self.message = message
        self.result = result
    }
}
