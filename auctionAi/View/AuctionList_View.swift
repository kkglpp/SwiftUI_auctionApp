//
//  AuctionList_View.swift
//  auctionAi
//
//  Created by user on 2023/10/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage


struct AuctionList_View: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2) // grid 샘플 데이터
    var imgList:[Image] = [Image("배낚시01"), Image("배낚시02"), Image("배낚시03"), Image("배낚시04")]

    @State var auctionList : [AuctionModel] = []
    @State var combinedList : [AuctionImagePair] = []
    @State var isLoading : Bool = true
    @State private var image: Image? = Image("woman11")
    var body: some View {
        
        if isLoading  {
            ProgressView("Loading...")
                .onAppear{
                    print("onAppeart실행됨?")
                    var getAuctionList = GetAuctionList()
                    getAuctionList.delegate = self
                    getAuctionList.downloadItems()
                    
                }
        }else{
            ScrollView {
                Text("ILBsan")
                    .padding(20) // 아래쪽으로 30만큼의 패딩값 주기
                    .font(.system(size: 24, weight: .bold)) // 크기 및 무게를 조절
                
                NavigationLink(destination: AuctionPage_View(auctionid: auctionList[auctionList.count-1].auctionid), label:{
                    VStack{
                        Text("최근 올라온 경매")
                            .font(.system(size: 20, weight: .heavy)) // 크기 및 무게를 조절
                            .lineLimit(2) // 한 줄로 표시
                            .foregroundColor(.red)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        image!
                            .resizable()
                            .frame(width: 7*40, height: 4*40)
                            .padding(EdgeInsets(top: 5, leading: 40, bottom: 5, trailing: 40))
                        HStack{
                            Text(auctionList[auctionList.count-1].title)
                                .font(.system(size: 15, weight: .bold)) // 크기 및 무게를 조절
                                .lineLimit(2) // 한 줄로 표시
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: 40, bottom: 5, trailing: 0))
                            Spacer()
                        }
                        HStack{
                            Text("Present Price : " + String(auctionList[auctionList.count-1].pricenow))
                                .font(.system(size: 15, weight: .bold)) // 크기 및 무게를 조절
                                .lineLimit(2) // 한 줄로 표시
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: 40, bottom: 15, trailing: 0))
                            Spacer()
                        }
                    }//Vstack in NavigationLink
                    .background(Color(red: 0.7, green: 0.7, blue: 7, opacity: 0.5))
                    .cornerRadius(10) // 이미지에 모서리 라운딩 적용
                    
                })//NavigationLink 끝 (최근 올라온 경매)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                /* 경매 전체 목록 보여주는 GridView */
                LazyVGrid(columns: columns) { // 상단에 컬럼 Array 데이터를 미리 정의해준다.
                    //                    ForEach((0...5), id: \.self) { num in
                    //                        GridView(listIndex: 1, auctionID: "30", auctionTitle:"그리드 테스트 " , auctionContent: "그리드 테스트 입니다.", img:imgList[num%4] )
                    //                    }//ForEach _Test
                    
                    ForEach(auctionList, id:\.self){auction in
                        GridView(listIndex: Int.random(in: 0...4), auctionID: auction.auctionid, auctionTitle:auction.title , auctionContent: auction.content, img: auction.pic )
                    }//ForEach Real
                }//LazyVGrid
            }//scrollView
            .onAppear {
            }
            .navigationBarHidden(true)
        }
    }//View
    
    func downloadImageFromFirebase(name : String) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child(name) // 파일 경로
        
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
} //Struct

struct GridView: View {
    var listIndex : Int
    var auctionID : Int
    var auctionTitle : String
    var auctionContent : String
    var img : String

    @State private var image: Image?
//    [Image("배낚시01"), Image("배낚시02"), Image("배낚시03"), Image("배낚시04")]

    init(listIndex: Int, auctionID: Int, auctionTitle: String, auctionContent: String, img: String) {
        self.listIndex = listIndex
        self.auctionID = auctionID
        self.auctionTitle = auctionTitle
        self.auctionContent = auctionContent
        self.img = img
    
    }
    var body: some View {
        
        
        NavigationLink(destination: AuctionPage_View(
            auctionid: auctionID),
                       label:{
            VStack{
                Spacer()
                if let image = image {
                    image
                        .resizable()
                        .frame(width: 7*20,height: 4*20)
                }else{
                    Image("woman\(String(format: "%02d", auctionID%13))")
                        .resizable()
                        .frame(width: 7*20,height: 4*20)
                }
                HStack{
                    Spacer()
                    Text(auctionTitle)
                    Spacer()
                }
                .foregroundColor(.black)
                HStack{
                    Spacer()
                    Text(auctionContent)
                    Spacer()
                }
                Spacer()
            }
            .background(Color(red: .random(in: 0...0.5), green: .random(in: 0...0.5), blue: .random(in: 0...0.5),opacity: .random(in: 0...0.5)))
            .padding(3)
            
        })//label // NavigationLink
        .onAppear {
            downloadImageFromFirebase()
        }
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


extension AuctionList_View : GetAuctionListProtocol{
    func getauctionList(item: (String,[AuctionModel])){
        let rs = item.0
        let datas = item.1
       
        if rs != "Auction Loaded successfully"{ // 실패시 실행 코드
            
        }else{
            for auction in datas{
                self.auctionList.append(auction)
                
            }//for auction in datas

            print("성공!!!")
            self.downloadImageFromFirebase(name: auctionList[auctionList.count-1].pic)
            self.isLoading = false
        }//else
        
    }//getauctionList
}//extension AuctionList_view

//extension AuctionList_View : GetImgListProtocol{
//    func getImgList(item: [Image]) {
//        self.imageList = item
//        print("auctionList 길이 : ",auctionList.count )
//        print("imageList 길이 : ",imageList.count )
//    }
//    
//    
//}

#Preview {
//    GridView(listIndex: 1, auctionID: "30", auctionTitle:"그리드 테스트 " , auctionContent: "그리드 테스트 입니다.", img:Image("배낚시01") )
    AuctionList_View()
}
