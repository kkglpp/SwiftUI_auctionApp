//
//  AudctionModel.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import Foundation
import SwiftUI

struct AuctionImagePair: Hashable {
    let auction: AuctionModel
    let image: Image

    func hash(into hasher: inout Hasher) {
        hasher.combine(auction)
        // 이미지는 SwiftUI의 Image이기 때문에 직접 해시될 수 없습니다.
        // 이미지 URL 또는 다른 고유한 값으로 대체해야 할 수도 있습니다.
        // 예를 들어, 이미지의 URL을 문자열로 변환하여 사용할 수 있습니다.
        // hasher.combine(image.urlString)
    }
}

struct AuctionModel:Hashable{
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
    let endeddate: String
    let issuccessed: Bool
    
    init(auctionid: Int, seller_id: String, buyer_id: String?, title: String, content: String, pic: String, fish: String, view: Int, pricestart: Int, pricenow: Int, insertdate: String, deletedate: String?, endeddate: String, issuccessed: Bool) {
        self.auctionid = auctionid
        self.seller_id = seller_id
        self.buyer_id = buyer_id
        self.title = title
        self.content = content
        self.pic = pic
        self.fish = fish
        self.view = view
        self.pricestart = pricestart
        self.pricenow = pricenow
        self.insertdate = insertdate
        self.deletedate = deletedate
        self.endeddate = endeddate
        self.issuccessed = issuccessed
    }
    

}
