//
//  PrepareAuction_View.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import SwiftUI

struct PrepareAuction_View: View {
    
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @State var imgName : String?
//    @State var picpath : String?
    
    @State var auctionTitle : String = ""
    @State var fishTitle: String = ""
    @State var startPrice: String = ""
    @State var content : String = ""
    @State var Date : String = ""
    @State var Location : String = ""
    @State var fileName : String = ""
    @State var showingAlert_fail = false
    @State var showingAlert_success = false
    @State var predictBool = false
    @State var predictRs : [PredictModel] = []
    @Environment(\.presentationMode) var presentationMode
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
        
    }
    
    var body: some View {
        
        VStack{
            
            Spacer()
            if let image = image {
                image
                    .resizable()
                    .frame(width: 280, height: 160)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                
            } else {
                Image(systemName: "fish")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 280, height: 160)
                    .scaleEffect(x: -1, y: 1)// 좌우반전
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            }
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Fish Picture")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
            }
            .sheet(isPresented: $showImagePicker, onDismiss: {
                loadImage()
                var getPredict = GetPredict_VM()
                getPredict.delegate = self
                getPredict.predictFish(paramName: "getpredict", fileName: imgName!, img: selectedUIImage!)
                
            }) {
                ImagePicker(image: $selectedUIImage, imgname: $imgName)
            }
            Divider()
                .frame(height: 2)
                .background(.red)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
            ScrollView{
                VStack{
                    
                    TextInsert_view(insertTitle: $auctionTitle, titleMessage: "Title ", preMessage: "Location")
                    TextInsert_view(insertTitle: $content, titleMessage: "Content ", preMessage: "Summary")
                    TextInsert_view(insertTitle: $fileName, titleMessage: "Pic ", preMessage: "FileName")
                    TextInsert_view(insertTitle: $fishTitle, titleMessage: "Fish Species ", preMessage: "Speceies")
                    TextInsert_view(insertTitle: $startPrice, titleMessage: "Start Prices ", preMessage: "Prices")
                
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // 사용자 정의 뒤로가기 동작
                        }) {
                            
                            Text("취소")
                                .font(.system(size: 25))// 사용자 정의 버튼 아이콘

                                .foregroundColor(.red)

                        }//Button
                        .padding(EdgeInsets(top: 50, leading: 40, bottom: 5, trailing: 40))

                        Button(action: {
                            var openAction = OpenAuction_VM()
                            openAction.delegate = self
                            openAction.OpenAuction_act(img: selectedUIImage!, title: fishTitle, content: content , fish: content, prices: String(startPrice))
   
                        }) {
                            Text("확인")
                                .font(.system(size: 25))// 사용자 정의 버튼 아이콘
                                .foregroundColor(.blue)
                        }//Button
                        .padding(EdgeInsets(top: 50, leading: 20, bottom: 5, trailing: 20))

                    }
                    Spacer()
                    
                }//VStack -> Vstack
            }//ScrollView
        }//Vstack
        .alert(isPresented: $showingAlert_fail){
            Alert(
                title: Text("Failed to Open Auction"),
                message: Text("Failed open Auction. Try again or leave Message."),
                dismissButton: .default(Text("confirm"))
            )}// Alert  //alert
        .alert(isPresented: $showingAlert_fail){
            Alert(
                title: Text("Success to Open Auction"),
                message: Text("Success to Open Auction. \n It will end 24hour later. "),
                dismissButton: .default(Text("confirm"))
            )}// Alert  //alert
        .alert(isPresented: $predictBool) {
            createAlert(items: predictRs)
        }
    }//body
    
    
    
    func createAlert(items: [PredictModel]) -> Alert {
        let alertContent = "예측결과입니다. \n 둘중 어떤 생선 인가요? "
        return Alert(title: Text("Predicted Result"),
                     message: Text(alertContent),
                     primaryButton: .default(Text(items[0].name),
                                            action: {
            self.fishTitle = items[0].name
            self.fileName = items[0].name
        }),
                     secondaryButton: .default(Text(items[1].name),
                                              action: {
            self.fishTitle = items[1].name
            self.fileName = items[1].name
        })
        )
    }
    
}//struct




extension PrepareAuction_View : GetPredictProtocol{
    func getpredict(item: [PredictModel]) {
        self.predictRs = item
        //print("predictRs : ", predictRs)
        self.predictBool = true
        //print("predictRs : ", predictRs)
        
        
    }
}

extension PrepareAuction_View : OpenAuctionProtocol{
    func OpenAuction(item: (String, OpendModel)) {
        let data = item
        if data.0 != "Auction created successfully"{
            self.showingAlert_fail = true
        }else{
            self.showingAlert_fail = true
        }
        presentationMode.wrappedValue.dismiss() // 사용자 정의 뒤로가기 동작
    }
}


struct TextInsert_view: View {
    
    @Binding var insertTitle : String
    var titleMessage : String
    var preMessage : String
    init(insertTitle: Binding<String> = .constant(" "), titleMessage: String, preMessage: String) {
        _insertTitle = insertTitle
        self.titleMessage = titleMessage
        self.preMessage = preMessage
    }
    
    
    var body: some View {
        HStack{
            Text(titleMessage)
                .frame(width: 100, height: 50, alignment: .leading)
            Text( ":")
                .frame(width:10,height:50)
            TextField(preMessage, text: $insertTitle)
                .frame(width: 200)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
        }
    }
}


#Preview {
    PrepareAuction_View()
}
