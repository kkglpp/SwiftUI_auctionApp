//
//  BuySold_Each_View.swift
//  auctionAi
//
//  Created by user on 2023/10/28.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct EachSection: View {
    var title : String
    var auctionId : Int
    var text01 :String
    var text02 :String
    var text03 :String
    var img : String
    @State private var image: Image? = Image("woman11")

    init(title: String = "Title " , auctionId: Int = 333, text01: String = "text01", text02: String = "text02", text03: String = "text03", img:String) {
        self.title = title
        self.auctionId = auctionId
        self.text01 = text01
        self.text02 = text02
        self.text03 = text03
        self.img = img
    }
    var body: some View {
        NavigationLink(destination: AuctionPage_View(auctionid: auctionId), label: {
            VStack{
                HStack{
                    Text(title.prefix(10) + "   " + title.suffix(8))
                        .font(.system(size: 20, weight: .heavy))
                    Spacer()
                }
                HStack{
                    if img == "구매완료"{
                        Image(systemName: "creditcard.circle")
                            .resizable()
                            .aspectRatio(contentMode:.fit)
                            .frame(width: 210, height: 120)
                            .background(.gray)
                            .foregroundColor(.red)
                            .cornerRadius(10) // 이미지에 모서리 라운딩 적용
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 25))
                        
                    }else{
                        Image(systemName: "banknote.fill")
                            .resizable()
                            .aspectRatio(contentMode:.fit)
                            .frame(width: 210, height: 120)
                            .background(.gray)
                            .foregroundColor(.blue)
                            .cornerRadius(10) // 이미지에 모서리 라운딩 적용
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 25))
                        
                    }

                            VStack{
                                Image(systemName: "play.fill")
                                    .resizable()
                            }
                            .frame(width: 50,height: 50,alignment: .trailing)

                }
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                HStack{
                    Text(text01)
                        .font(.system(size: 12, weight: .bold)) // 크기 및 무게를 조절
                        .lineLimit(1) // 두 줄로 표시
                        .frame(width: 200, alignment: .leading)
                    Text(text02)
                        .font(.system(size: 10, weight: .bold)) // 크기 및 무게를 조절
                        .lineLimit(1) // 두 줄로 표시
                        .frame(width: 10, alignment: .center)
                    Text(text03)
                        .font(.system(size: 15, weight: .bold)) // 크기 및 무게를 조절
                        .lineLimit(1) // 한 줄로 표시
                        .frame(width: 90, alignment: .trailing)
                }//HStack
            }//Vstack
        
        }) //NavigationLink
    }
    
    func downloadImageFromFirebase() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child(img) // 파일 경로
        
        imageRef.getData(maxSize: 1 * 350 * 200) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            } else {
                if let imageData = data, let uiImage = UIImage(data: imageData) {
                    let fetchedImage = Image(uiImage: uiImage)
                    self.image = fetchedImage
                }
            }
        }
    }
    
}//Struct

#Preview {
    EachSection(img: "구매완료")
}
