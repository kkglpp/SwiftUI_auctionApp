//
//  MyPage_View.swift
//  auctionAi
//
//  Created by user on 2023/10/25.
//

import SwiftUI

struct MyPage_View: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2) // grid 샘플 데이터

    var body: some View {
        // My Page Tab-----
        
            
            VStack{
            
                Text("My Page")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.bottom, 50) // 아래쪽 패딩
                    
                    LazyVGrid(columns: columns) {
                        VStack {
                            NavigationLink(destination: UserInfo_View(), label:{
                                Image(systemName: "person.circle") // 이미지 이름
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                    .foregroundColor(.black)
                                
                            })
                            Text("MyInfo") // 이미지 아래에 표시할 텍스트
                                .padding(.bottom, 30) // 아래쪽으로 30만큼의 패딩값 주기
                            
                        }
                        VStack {
                            NavigationLink(destination: MyPoint_View(), label:{
                                
                                Image(systemName: "banknote") // 이미지 이름
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                    .foregroundColor(Color(red: 1, green: 215/255, blue: 0))
                            })
                            Text("MyPoint") // 이미지 아래에 표시할 텍스트
                                .padding(.bottom, 30) // 아래쪽으로 100만큼의 패딩값 주기
                            
                        }
                        VStack {
                            NavigationLink(destination: BuyList_View(), label:{
                                Image(systemName: "basket") // 이미지 이름
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                    .foregroundColor(.red)
                            })
                            Text("Buy List") // 이미지 아래에 표시할 텍스트
                                .padding(.bottom, 30) // 아래쪽으로 100만큼의 패딩값 주기
                            
                        }
                        VStack {
                            NavigationLink(destination: SoldList_View(), label:{
                                Image(systemName: "creditcard.circle") // 이미지 이름
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                    .foregroundColor(.green)
                            })
                            Text("Sell List") // 이미지 아래에 표시할 텍스트
                                .padding(.bottom, 30) // 아래쪽으로 100만큼의 패딩값 주기
                            
                        }
                        .padding()
                        
                    }//LazyGrid
                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Spacer()
                    
                    //                Text("Conditions applicable to the purchase of goods and rendering of services to allnex (specific legal entity further identified in the order confirmation), hereafter to be referred to as Buyer.")
                    //                    .font(.system(size: 13))
                    //                    .foregroundColor(.gray) // 그레이 색상
                
            }//Vstack
            .navigationBarHidden(true)
        
    }//body
}//struct

#Preview {
    MyPage_View()
}
