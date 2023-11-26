//
//  CompletedAuctionModel.swift
//  auctionAi
//
//  Created by user on 2023/10/27.
//

import Foundation


struct CompletedAuctionModel : Hashable{
    let biddedid : Int
    let auctionid : Int
    let buyerid : String
    let biddedprice : Int
    let biddeddate : String
    let address : String
    let deliverydate : String
    let paymentdate : String
    
    init(biddedid: Int, auctionid: Int, buyerid: String, biddedprice: Int, biddeddate: String, address: String, deliverydate: String, paymentdate: String) {
        self.biddedid = biddedid
        self.auctionid = auctionid
        self.buyerid = buyerid
        self.biddedprice = biddedprice
        self.biddeddate = biddeddate
        self.address = address
        self.deliverydate = deliverydate
        self.paymentdate = paymentdate
    }
    
}
