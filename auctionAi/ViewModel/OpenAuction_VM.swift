//
//  OpenAuction_VM.swift
//  auctionAi
//
//  Created by user on 2023/10/27.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Firebase
import FirebaseStorage


protocol OpenAuctionProtocol {
    func OpenAuction(item: (String,OpendModel))
}

struct OpenAuction_VM{
    
    
    
    func OpenAuction_act(img: UIImage, title: String, content: String, fish:String, prices: String ){
        print("OPenAuction_VM 왔니?")
        upLoadImage(img: img, fish: fish){ imgPath in
            print("imgUploads 는 끝났나?")
            AuctionOpen(title: title, content: content, fish: fish, pic: imgPath, prices: prices)
        }
    }
    
    

    var delegate : OpenAuctionProtocol!
    let urlPath = "\(HOST)/auctions/"
    var tokens = ""
    
    func AuctionOpen(title: String,content: String, fish:String, pic:String ,prices: String ){
print("auctionOPEN 함수 시작")
        let url: URL = URL(string: urlPath)!
        var request = URLRequest(url: url)
        let access_token = UserDefaults.standard.value(forKey: "access_token")!
        //var refresh_token = UserDefaults.standard.value(forKey: "refresh_token")!
        //print("loginCheck 실행")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        

        
        let postData : [String: Any] = [
            "title" : title,
            "content" :content,
            "pic" : pic,
            "fish" : fish,
            "pricestart" : prices,
            //"refreshKey" : UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        ]
print("postData : ",postData)
        do{
            // JSON 형식으로 인코딩
print("리퀘스트의 : JSON 인코딩 시작전")
            let jsonData = try JSONSerialization.data(withJSONObject: postData)
print("리퀘스트의 JSON 인코딩 되었음")
            
            request.httpBody = jsonData // body 데이터
print("바디 선언 끝")
            //application의 json 형태 선언
            // Type 을 forHTTPHeaderField
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") //application의 json 형태 선언
print("SetValue 끝")
        }catch{
            print("Json으로 바꾸기 실패. : \(error)" )
            return // Json 으로변환 실패
        }
        print("accept: ", "application/json")
//        print("Authorization: ", "Bearer \(access_token)")
        print("open's url은 완성")
        print("request의 allheadFields", request.allHTTPHeaderFields)
        print("request의 url",request.url)
        print("request의 httpBody : ", request.httpBody)
        
        
        request.httpMethod = "POST"  // Post 방식 설정
        //URLSession request하고 response 받아오기.
        let task = URLSession.shared.dataTask(with: request) {
            (data,response, error) in
            if let error = error  {
                print("error 발생")
                print(error)
                return
            }
            // 서버로부터의 응답을 처리.
            if let data = data {
                // 데이터를 사용하거나 파싱.
                print("data = data 실행")
                print("data : ", data)
                
                if let responseString = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        let rs = responseString
                        print("data's String : ", rs)
                    }// if let responseData
                }
                
                self.parseJSON(data)
            }
        }
        task.resume()
    }
    
    
    
    func parseJSON(_ data: Data) {
//        let decoder = JSONDecoder()
        
        do {
//            print("parsonJSON 왔을까?")
//            print("data : ",data)
            
            let basicResult = try JSONDecoder().decode(OpendResultJSONModel.self, from: data)
            
            
            //print("basicResult result: )" , basicResult.result)
//            let auctionData = try decoder.decode(AuctionJsonModel.self, from: basicResult.result) // 만들어놓은 Json모델과 연결
            let locations: OpendJsonModel = basicResult.result
            let rsmessage : String = basicResult.message
            print("rsmessage : ", rsmessage)

            let location = OpendModel(
                auctionid: locations.auctionid,
                seller_id: locations.seller_id,
                title: locations.title,
                content: locations.content,
                pic: locations.pic,
                fish: locations.fish,
                view: locations.view,
                pricestart: locations.pricestart,
                pricenow: locations.pricenow,
                insertdate: locations.insertdate,
                deletedate: locations.deletedate ?? "진행중",
                issuccessed: locations.issuccessed
            )
            
            DispatchQueue.main.async {
                self.delegate.OpenAuction(item: (rsmessage,location))
                
                return
            }//dispatchQue
        } catch {
            print(error)
            print("Error decoding JSON: \(error)")
        }//catch
    }//parseJSON
    
    
    
    
    
    
    
    
    
    
    func upLoadImage(img: UIImage, fish : String, completion: @escaping (String) -> Void){
//        var db = Firestore.firestore()
        let storage = Storage.storage() //인스턴스 생성
        
        var data = Data()
        data = img.jpegData(compressionQuality: 1)! //지정한 이미지를 포함하는 데이터 개체를 JPEG 형식으로 반환, 0.8은 데이터의 품질을 나타낸것 1에 가까울수록 품질이 높은 것
        let filePath = "\(fish)"
        let metaData = StorageMetadata() //Firebase 저장소에 있는 개체의 메타데이터를 나타내는 클래스, URL, 콘텐츠 유형 및 문제의 개체에 대한 FIRStorage 참조를 검색하는 데 사용
        metaData.contentType = "image/png" //데이터 타입을 image or png 팡이
        let storageRef = storage.reference().child(filePath)
        
        storageRef.putData(data, metadata: metaData){
            (metaData,error) in if let error = error { //실패
                print(error)
                return
            }else{ //성공
                print("이미지 파이어 베이스에 업로드 성공")
                
                let fileName = storageRef.name
                completion(fileName)
                
//                storageRef.downloadURL { (url, error) in
////                    if let downloadURL = url {
////                        let imageURL = downloadURL.absoluteString
////                        print("이미지 경로: \(imageURL)")
////                        completion(imageURL) // 이미지 URL 반환
////
////                        
//////                        // 이미지 경로를 fileInfo에 저장하거나 다른 사용 목적으로 활용
//////                        let fileInfo = ["fish": fish, "imageURL": imageURL]
//////                        imgurl = fileInfo["imageURL"]!
////                    } else {
////                        print("이미지 경로를 가져오는데 실패했습니다: ",error!)
////                        return
////                    } //iflet
//                    
//                    
//                }//storageRef.downlaodURL
            } //else //성공
        }//storageRef.putData
        
        
    } //UPloadimage 끝
        
        
        
    
}// Struct End
