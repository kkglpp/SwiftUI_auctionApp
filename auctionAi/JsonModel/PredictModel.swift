//
//  PredictModel.swift
//  auctionAi
//
//  Created by user on 2023/10/29.
//

import Foundation


struct PredictModel : Hashable {
    var name : String
    var prob : String
    
    init(name: String, prob: String) {
        self.name = name
        self.prob = prob
    }
}

struct PredicJsonModel:Codable{
    var name : String
    var prob : String
}



struct PredictJSONModel: Codable{
    
    var result : [PredicJsonModel]
    
}



