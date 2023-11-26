//
//  SellList_View.swift
//  auctionAi
//
//  Created by user on 2023/10/25.
//

import SwiftUI

struct SellList_View: View {
    @State var name: String = "" // 경맥등록탭에서 텍스트필드에 사용할 변수
    @State var sellingAuctions : [AuctionModel] = []
    var body: some View {
        // 내가 판매하는 경매 리스트 Tab-----
            ZStack{
                List {
                    ForEach(sellingAuctions, id:\.self){auction in
                        if auction.seller_id == UserDefaults.standard.value(forKey: "user_email") as! String{
                            SellList_Each_View(auctionId: auction.auctionid, title: auction.title, nowPrice: String(auction.pricenow), startTime: auction.insertdate, endTime: auction.endeddate, img: auction.pic)
                        }
                    }//ForEach
                }//List
                .onAppear {
                    print("onAppeart실행됨?")
                    var getSellingdList = GetSellingList_VM()
                    getSellingdList.delegate = self
                    getSellingdList.downloadItems()
                }
                VStack(alignment: .trailing){
                    Spacer()
                    HStack{Spacer()
                        NavigationLink(destination: PrepareAuction_View(),
                                       label:{ Image(systemName: "plus.rectangle")
                                .resizable()
                                .frame(width: 50,height: 50,alignment: .trailing)
                                .foregroundColor(.red)
                                .background(.white)
                        }
                        )//NavigationLink
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
                        
   
                    }
                }//Vstack
            }//Zstack
    }//View


    
    
}//SoldList_View



extension SellList_View : GetSellingListProtocol{
    func getSellingList(item: (String, [AuctionModel])) {
        let rs = item.0
        let datas = item.1
        if rs != "Auction Loaded successfully"{ // 로그인 실패시 실행 코드
            print("구매완료 리스트 가져오기 실패")
        }else{
            self.sellingAuctions = datas
//            for auction in datas{
//                self.sellingAuctions.append(auction)
//            }//for auction in datas
            print("판매중인 리스트 가져오기 성공!!!")
            print("기기에 저장된 user Email : ",UserDefaults.standard.value(forKey: "user_email")! )
        }//else
    }// getSoldList
}


#Preview {
    SellList_View()
}
