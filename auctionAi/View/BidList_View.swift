//
//  BidList_View.swift
//  auctionAi
//
//  Created by user on 2023/10/25.
//

import SwiftUI

struct BidList_View: View {
    var body: some View {
        // 경매 리스트 Tab---------- // 여기에 Json모델 만든것을 DB모델에 담아서 노출시켜준다.
        List {
            Section(header: Text("List").font(.system(size: 24, weight: .bold))){
                HStack(spacing: 180){
                    Image("AcanthopagrusSchlegelii_0001")
                        .resizable()
                        .frame(width: 260, height: 100)
                        .cornerRadius(10) // 이미지에 모서리 라운딩 적용
                }
                Text("HyporhamphusSajori")
                    .font(.system(size: 15, weight: .bold)) // 크기 및 무게를 조절
                    .lineLimit(2) // 한 줄로 표시
                Button(action: {
                    // "입찰하기" 버튼이 클릭되었을 때 실행할 코드
                }) {
                    Text("Go") // 버튼 완성되면 사라질 코드
                }
            }
        }//List
    }
}

#Preview {
    BidList_View()
}
