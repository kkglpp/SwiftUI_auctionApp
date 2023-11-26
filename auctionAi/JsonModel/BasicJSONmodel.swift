//
//  BasicJSONmodel.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import Foundation


struct AuctionJsonModel: Codable{
    let auctionid: Int
    let seller_id: String
    let buyer_id: String?
    let title: String
    let content: String
    let pic: String
    let fish: String
    let view: Int
    let pricestart: Int
    let pricenow: Int
    let insertdate: String
    let deletedate: String?
    let endeddate: String?
    let issuccessed: Bool
}


struct CompletedAuctionJSONModel: Codable{
    
    let biddedid : Int
    let auctionid : String
    let buyerid : String
    let biddedprice : Int
    let biddeddate : String
    let address : String
    let deliverydate : String
    let paymentdate : String
    
}

struct BasicJSONmodel: Codable {
    let message: String
    let result: [AuctionJsonModel]
}


struct BasicJSONmodel_each: Codable {
    let message: String
    let result: AuctionJsonModel
}

struct BasicCompletedAuctionJSONmodel : Codable{
    let message: String
    let result : [CompletedAuctionJSONModel]
}


struct OpendJsonModel: Codable {
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

struct OpendResultJSONModel : Codable{
    var message : String
    var result : OpendJsonModel
    
}

struct OpendModel : Hashable {
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
