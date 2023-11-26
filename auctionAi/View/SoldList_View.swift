//
//  BuyList_View.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import SwiftUI

struct SoldList_View: View {
    
    var genders = ["man","woman"]
    @State var soldauctions : [CompletedAuctionModel] = []
    
    var body: some View {
        
        VStack(alignment:.center){
                Text("내 구매 목록")
                .font(.system(size: 24, weight: .bold))
                .padding(20)

            List {
                ForEach(soldauctions, id:\.self){auction in
                    EachSection(title: auction.biddeddate, auctionId: auction.auctionid, text01: auction.address, text02: "", text03: "\(String(format: "%.1f 만원", auction.biddedprice/10000))", img: "판매완료")
                }//ForEach
            }//List
            
            .onAppear {
                print("onAppeart실행됨?")
                var getSoldList = GetSoldList_VM()
                getSoldList.delegate = self
                getSoldList.downloadItems()
            }//onAppear
            //        List{
            //            ForEach(1...20, id:\.self){i in
            //            EachSection()
            //            }
            //        }
        }//Vstack
    
    }//body
        
}//BuyList_View end



//#Preview {
//    EacSection()
//}




extension SoldList_View : GetSoldListProtocol{
    func getSoldList(item: (String, [CompletedAuctionModel])) {
        let rs = item.0
        let datas = item.1
        if rs != "Auction Loaded successfully"{ // 로그인 실패시 실행 코드
            print("구매완료 리스트 가져오기 실패")
        }else{
            for auction in datas{
                self.soldauctions.append(auction)
            }//for auction in datas
            print("판매완료 리스트 가져오기 성공!!!")
        }//else
    }// getSoldList
}//SoldList_View


#Preview {
    SoldList_View()
}
