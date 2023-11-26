//
//  OpenAuction_View.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import SwiftUI

struct OpenAuction_View: View {
    @State var name: String = "" // 경맥등록탭에서 텍스트필드에 사용할 변수

    var body: some View {
        NavigationView {
            ScrollView {
                Text("Auction registration")
                    .padding(.bottom, 30)
                    .font(.system(size: 24, weight: .bold))
                    .alignmentGuide(.leading) { _ in
                        return -10
                    }

                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                           Text("Name of fish")
                               .font(.system(size: 15, weight: .bold))
                        Spacer() // 공간 확보
                        Text("Please fill out the correct name")
                            .font(.system(size: 13))
                            .foregroundColor(.gray) // 그레이 색상
                       }
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color(uiColor: .secondarySystemBackground))
                    Text("width")
                        .font(.system(size: 15, weight: .bold))
                    TextField("Please fill in the correct widht", text: $name)
                        .padding()
                        .background(Color(uiColor: .secondarySystemBackground))
                    Text("height")
                        .font(.system(size: 15, weight: .bold))
                    TextField("Please fill in the correct height", text: $name)
                        .padding()
                        .background(Color(uiColor: .secondarySystemBackground))
                        .padding(.bottom, 30) // 아래쪽으로 30만큼의 패딩값 주기
                    Text("If you add a picture, it will be filled out automatically.")
                        .font(.system(size: 13))
                        .foregroundColor(.gray) // 그레이 색상
                    Image("AcanthopagrusSchlegelii_0001") // 사진이 추가되면 노출할 이미지
                        .resizable()
                        .frame(width: 360, height: 150)
                        .cornerRadius(10)
                        .offset(x: 20) // 상단 가운데로 이동, y 값은 조절 가능
                }
            }

            
        }    }
}

#Preview {
    OpenAuction_View()
}
