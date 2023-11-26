//
//  AuctionPageModel.swift
//  auctionAi
//
//  Created by user on 2023/10/30.
//

import Foundation

struct AuctionPageRsJSONModel:Codable{
    let message : String
    let result : AuctionPageJSONModel
    
}


struct AuctionPageJSONModel:Codable{
    
    let auctionid: Int
    let seller_id: String
    let title: String
    let content: String
    let pic: String
    let fish: String
    let view: Int
    let pricestart: Int
    let pricenow: Int
    let insertdate: String
    let deletedate: String?
    let issuccessed: Bool
}

struct AuctionPageModel : Hashable{
    let auctionid: Int
    let seller_id: String
    let title: String
    let content: String
    let pic: String
    let fish: String
    let view: Int
    let pricestart: Int
    let pricenow: Int
    let insertdate: String
    let deletedate: String?
    let issuccessed: Bool
    init(auctionid: Int, seller_id: String, title: String, content: String, pic: String, fish: String, view: Int, pricestart: Int, pricenow: Int, insertdate: String, deletedate: String?, issuccessed: Bool) {
        self.auctionid = auctionid
        self.seller_id = seller_id
        self.title = title
        self.content = content
        self.pic = pic
        self.fish = fish
        self.view = view
        self.pricestart = pricestart
        self.pricenow = pricenow
        self.insertdate = insertdate
        self.deletedate = deletedate
        self.issuccessed = issuccessed
    }
}
