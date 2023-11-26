//
//  GetBuyList_VM.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import Foundation

protocol GetBuyListProtocol{
    func getBuyList(item:(String,[CompletedAuctionModel]))
}

struct GetBuyList_VM{
    var delegate: GetBuyListProtocol!
    let urlPath = "\(HOST)/bidded/user/buying" //Login_Func 파일에서 선언해두었음.
    
    
    func downloadItems() {
        if let url = URL(string: urlPath) {
            
            let access_token = UserDefaults.standard.value(forKey: "access_token")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
//            print("accept: ", "application/json")
//            print("Authorization: ", "Bearer \(access_token)")
//            print("buy's url은 완성")
//            print("request의 allheadFields", request.allHTTPHeaderFields)
//            print("request의 url",request.url)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("error 발생")
                    print(error)
                    return
                }
                if let data = data {
                    print("parseJson 실행직전")
                    print("data : " ,data)
                    
                    if let responseString = String(data: data, encoding: .utf8) {
                        DispatchQueue.main.async {
                            var responseData = responseString
                            print("data's String : ", responseData)
                        }
                    }
                    self.parseJSON(data)
                }
            }
            task.resume()
        }// if let url end
    }//DownloadItems end
    
    // 받아온 response을 JSON으로 parse
    func parseJSON(_ data: Data) {
        

        do {
            print("parsonJSON 왔을까?")
            print("data : ",data)

            let basicResult = try JSONDecoder().decode(BasicCompletedAuctionJSONmodel.self, from: data)
            
            
//            print("buy's basicResult result: )" , basicResult.result)
    //            let auctionData = try decoder.decode(AuctionJsonModel.self, from: basicResult.result) // 만들어놓은 Json모델과 연결
            var locations: [CompletedAuctionModel] = []
            let rsmessage : String = basicResult.message
//            print("rsmessage : ", rsmessage)

            for index in basicResult.result {
                var auid : Int = 0
                if let aidInt = Int(index.auctionid){
                    auid = aidInt
                }
                print("auctionID : ", auid)
                let query = CompletedAuctionModel(

                    biddedid: index.biddedid,
                    auctionid: auid,
                    buyerid: index.buyerid,
                    biddedprice: index.biddedprice,
                    biddeddate: index.biddeddate,
                    address: index.address,
                    deliverydate: index.deliverydate,
                    paymentdate: index.paymentdate
                )
                locations.append(query)
            }
            DispatchQueue.main.async {
                self.delegate.getBuyList(item: (rsmessage, locations))
                return
            }//dispatchQue
        } catch {
            print("Error decoding JSON: \(error)")
        }//catch
    }//parseJSON
}//struct end

