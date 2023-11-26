//
//  BidUp_VM.swift
//  auctionAi
//
//  Created by user on 2023/10/30.
//

import Foundation

protocol BidUpProtocol{
    func bidUpRS(item : BidupModel)
}


struct BidUp_VM{
    var delegate : BidUpProtocol!
    
    //urlPath = urlPath +actionID +"/"+newPrice

    func bidUpAction(auctionID : String , newPrice : String){
        var urlPath = "\(HOST)/auctions/" //Login_Func 파일에서 선언해두었음.
        urlPath = urlPath + auctionID + "/" + newPrice
        if let url = URL(string: urlPath) {
            let access_token = UserDefaults.standard.value(forKey: "access_token")!
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")

    //        print("Authorization: ", "Bearer \(access_token)")
            print("open's url은 완성")

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
        
    }//func BidupAction

    
    
    
    func parseJSON(_ data: Data) {
//        let decoder = JSONDecoder()
        do {
//            print("parsonJSON 왔을까?")
//            print("data : ",data)
            
            let basicResult = try JSONDecoder().decode(BidupJSONModel.self, from: data)
            
            
            //print("basicResult result: )" , basicResult.result)
//            let auctionData = try decoder.decode(AuctionJsonModel.self, from: basicResult.result) // 만들어놓은 Json모델과 연결\
            let rsmessage : String = basicResult.message
            print("rsmessage : ", rsmessage)

            let location = BidupModel(
                message: basicResult.message,
                result: basicResult.result
            )
            DispatchQueue.main.async {
                self.delegate.bidUpRS(item: location)
                return
            }//dispatchQue
        } catch {
            print(error)
            print("Error decoding JSON: \(error)")
        }//catch
    }//pa
} //struct BidUP_VM Ended
