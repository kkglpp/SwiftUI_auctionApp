//
//  SellList_Each_View.swift
//  auctionAi
//
//  Created by user on 2023/10/29.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct SellList_Each_View: View {
    var auctionId : Int
    var title : String
    var nowPrice : String
    var startTime : String
    var endTime : String
    var img : String
    
    @State private var image: Image? = Image(systemName: "hourglass.circle")
    init(auctionId: Int, title: String , nowPrice: String, startTime: String, endTime: String, img : String ) {
        self.auctionId = auctionId
        self.title = title
        self.nowPrice = nowPrice
        self.startTime = startTime
        self.endTime = endTime
        self.img = img
        
        downloadImageFromFirebase()
    }
    
    
    
    var body: some View {
        
        
        
        VStack{
            
            NavigationLink(destination: AuctionPage_View(auctionid: auctionId), label: {
                VStack{
                    Text(title)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .font(.system(size: 25, weight: .bold))
                    
                    HStack{
                        image!
                            .resizable()
                            .frame(width: 7*12, height: 4*12)
                        Spacer()
                        VStack{
                            Text(title)
                                .font(.system(size: 15, weight: .bold)) // 크기 및 무게를 조절
                            Text(nowPrice)
                            Text("\(startTime) / \(endTime)")
                        }
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
                        Spacer()
                        VStack{
                        }
                        .background(.red)
                        
                    } //HStack
                }//VStack
            })
            
        } //Vstack
        .onAppear {
            
        }
    }//body
    
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
    
}

//
//#Preview {
//    SellList_Each_View()
//}
