//
//  ContentView.swift
//  test
//
//  Created by AHNJAEWON1 on 2023/10/16.
//  Main Page

import SwiftUI

struct ContentView: View {
    
    let photoUploadView = PhotoUploadView() // PhotoUploadView는 이동하려는 뷰
    
    @State var name: String = "" // 경맥등록탭에서 텍스트필드에 사용할 변수
    
    var body: some View {
        /* 1.하단 탭바 구성*/
        /* TabView는 Storyboard에서 컨트롤러 역할을 하므로
         해당 탭안에 소스를 넣어준다. */
        TabView {
            // Home Tab-----

            AuctionList_View()
            .tabItem {
                Image(systemName: "1.square.fill")
                Text("경매 리스트")
            }
            // 경매 리스트 Tab---------- // 여기에 Json모델 만든것을 DB모델에 담아서 노출시켜준다.
  
            BuyList_View()
            .tabItem {
                Image(systemName: "2.square.fill")
                Text("나의 구매 목록")
            }

            SellList_View()
            .tabItem {
                Image(systemName: "3.square.fill")
                Text("판매 목록")
            }

            MyPage_View()
            .tabItem {
                Image(systemName: "4.square.fill")
                Text("My Page")
                
            }
        }
        
    }
}

#Preview {
    ContentView()
}

