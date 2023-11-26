//
//  BuyList_View.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import SwiftUI

struct BuyList_View: View {
    
    var genders = ["man","woman"]
    @State var buyauctions : [CompletedAuctionModel] = []
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        VStack(alignment:.center){
            HStack{
                ZStack{
                    HStack{
                        Button("Go Back", action: {
                            self.presentationMode.wrappedValue.dismiss()
                        })
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 10))
                        Spacer()
                    }
                    Text("내 구매 목록")
                        .font(.system(size: 24, weight: .bold))
                        .padding(20)
                }
            }
            List {
                ForEach(buyauctions, id:\.self){auction in
                    EachSection(title: auction.biddeddate, auctionId: auction.auctionid, text01: auction.address, text02: "", text03: "\(String(format: "%.1f 만원", Double(auction.biddedprice)/10000))", img: "구매완료")
                }//ForEach
            }//List
            .onAppear {
                print("onAppeart실행됨?")
                var getBuyList = GetBuyList_VM()
                getBuyList.delegate = self
                getBuyList.downloadItems()
            }//onAppear
        }//Vstack
        .navigationBarHidden(true)
    
    }//body
        
}//BuyList_View end







extension BuyList_View : GetBuyListProtocol{
    func getBuyList(item: (String, [CompletedAuctionModel])) {
        let rs = item.0
        let datas = item.1
        if rs != "Auction Loaded successfully"{ // 로그인 실패시 실행 코드
            print("구매완료 리스트 가져오기 실패")
        }else{
            for auction in datas{
                self.buyauctions.append(auction)
                print("가격1 : ", auction.biddedprice)
                print("가격2 : ", "\(String(format: "%.1f 만원", Double(auction.biddedprice)/10000))")
            }//for auction in datas
            print("구매완료 리스트 가져오기 성공!!!")
        }//else
    }// getBuyList
    
    
}//BuyList_View


#Preview {
    BuyList_View()
}
