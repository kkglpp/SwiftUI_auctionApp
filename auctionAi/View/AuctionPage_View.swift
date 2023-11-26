//
//  AuctionPage_View.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct AuctionPage_View: View {
    
    var auctionid : Int
    @State var title : String = "test Title"
    @State var content : String = "Fish's Selling Point is Just Taste. Eat with me honey?"
    @State var pic : String = ""
    @State var fishName : String = "Test Fish Name"
    @State var priceNow : Int = 10000
    @State var newPrice : String = ""
    @State var issuccessed : Bool = false
    @State var showingAlert_bidSuccess  : Bool = false
    @State var showingAlert_bidFail : Bool = false
    @State private var image: Image? = Image("woman11")    
    @State var isLoading : Bool = true
    
    init(auctionid: Int) {
        self.auctionid = auctionid
 
    }
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        if isLoading  {
            ProgressView("Loading...")
                .onAppear{
                    var getAuctionpage = GetAuctionPage_VM()
                    getAuctionpage.delegate = self
                    getAuctionpage.getAuctionPage(auctionID: String(auctionid))
                    downloadImageFromFirebase(name: pic)
                }
        }else{
            ZStack{
                ScrollView{
                    VStack(alignment:.center){
                        HStack{
                            Text("")
                                .font(.system(size: 30, weight: .heavy))
                        } // VStack > HStack01헤드에 넣을 요소
                        .padding(EdgeInsets(top: 30, leading: 20, bottom: 10, trailing: 20))
                        
                        Divider()
                            .frame(height: 0)
                            .background(.white)
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
                        HStack{
                            Text(fishName)
                                .font(.system(size: 26, weight: .bold))
                                .frame(width:300, height: 30)
                            Spacer()
                        }
                        //                    .background(.purple)
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                        
                        HStack{
                            Spacer()
                            image!
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }
                        .frame(width: 350, height : 200)
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                        
                        HStack{
                            Text(content)
                                .font(.system(size: 20, weight: .bold))
                                .frame(width:300, height: 100)
                                .lineLimit(3) // 최대 줄 수 지정
                                .multilineTextAlignment(.leading) // 왼쪽 정렬
                            
                            Spacer()
                            
                        }
                        //                    .background(.cyan)
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                        
                        HStack{
                            Text("Present Price :        \(String(priceNow))")
                                .font(.system(size: 24, weight: .bold))
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                        
                        Divider()
                            .frame(height: 2)
                            .background(.gray)
                            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                        
                        
                        Spacer()
                        
                        
                    }//VStack
                } //ZStack01 : scrollView
                VStack{
                    HStack(){
                        Spacer()
                        Text(title)
                            .font(.system(size: 30, weight: .heavy))
                        Spacer()
                    } // VStack > HStack01헤드에 넣을 요소
                    .padding(EdgeInsets(top: 30, leading: 20, bottom: 10, trailing: 20))
                    .background(.white)
                    
                    Divider()
                        .frame(height: 2)
                        .background(.red)
                        .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
                    
                    Spacer()
                    HStack{
                        Text("New Price :  ")
                            .font(.system(size: 20, weight: .bold))
                        RoundedRectangle(cornerRadius: 3) // 상자의 모서리를 둥글게 함
                            .fill(Color.gray.opacity(0.4)) // 상자의 배경 색상과 투명도 조정
                            .frame(width:150, height: 30) // 상자의 크기 설정
                            .padding() // 상자 주위에 여백 추가
                            .overlay(
                                VStack{
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        TextField(String(priceNow), text: $newPrice) // TextField 추가
                                            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 30))
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            )
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 30, trailing: 30))
                    .background(.white)
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Cancle")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.red)
                        })
                        Spacer()
                        
                        Button(action: {
                            var bidUP = BidUp_VM()
                            bidUP.delegate = self
                            bidUP.bidUpAction(auctionID: String(auctionid), newPrice: newPrice)
                            
                            var getAuctionpage = GetAuctionPage_VM()
                            getAuctionpage.delegate = self
                            getAuctionpage.getAuctionPage(auctionID: String(auctionid))
                            
                        }, label: {
                            Text("Bided")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.blue)
                        })
                        Spacer()
                    }//Button's HStack
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 40, trailing: 30))
                    .background(.white)
                    
                } //ZStack02 : VStack
                
            }//Zstack
            .onAppear{

            }//Zstack's OnAppear
            .alert(isPresented: $showingAlert_bidSuccess){
                Alert(
                    title: Text("Success "),
                    message: Text("Success to Bid. Good Luck"),
                    dismissButton: .default(Text("confirm"),
                                            action: {
                                                var getAuctionpage = GetAuctionPage_VM()
                                                getAuctionpage.delegate = self
                                                getAuctionpage.getAuctionPage(auctionID: String(auctionid))
                                                showingAlert_bidSuccess = false
                                                self.presentationMode.wrappedValue.dismiss()

                                            })
                )}// Alert  //alert
            .alert(isPresented: $showingAlert_bidFail){
                Alert(
                    title: Text("Fail "),
                    message: Text("Failed to Bid. \n Try bid up "),
                    dismissButton: .default(Text("confirm"),
                                            action: {
                                                showingAlert_bidFail = false
                                            })
                )}// Alert  //alert
        }//else
        
        
    }//body
    
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
    
    
}

extension AuctionPage_View : GetAuctionPageProtocol{
    func getAuctionPage(item: AuctionPageModel) {
        self.title = item.title
        self.content = item.content
        self.pic = item.pic
        self.fishName = item.fish
        self.priceNow = item.pricenow
        self.issuccessed = item.issuccessed
        self.image = Image("woman\(String(format: "%02d", self.auctionid%13))")
        self.downloadImageFromFirebase(name: item.pic)
        self.isLoading = false
    }
}


extension AuctionPage_View : BidUpProtocol{
    func bidUpRS(item: BidupModel) {
        self.showingAlert_bidSuccess.toggle()

    }
}

#Preview {
    AuctionPage_View(auctionid:333)
}
