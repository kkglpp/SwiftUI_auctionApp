//
//  GetAuctionPage_VM.swift
//  auctionAi
//
//  Created by user on 2023/10/30.
//

import Foundation


protocol GetAuctionPageProtocol{
    func getAuctionPage(item:AuctionPageModel)
    
}

struct GetAuctionPage_VM{
    var delegate : GetAuctionPageProtocol!
    
    func getAuctionPage(auctionID : String){
        var urlPath = "\(HOST)/auctions/"
        urlPath = urlPath + auctionID
        if let url = URL(string: urlPath) {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "accept")
            
            print("request의 allheadFields", request.allHTTPHeaderFields)
            print("request의 url",request.url)
            print("request의 httpBody : ", request.httpBody)
            print(urlPath)
            
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                if let data = data {
                    print("task 실행 잘 된거 확인하기.")
                    print("task 에서  data : ",data)
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
        }
        
        
    }//fuct get AuctionPage
    // 받아온 response을 JSON으로 parse
    func parseJSON(_ data: Data) {
//        let decoder = JSONDecoder()
        
        do {
            print("parsonJSON 왔을까?")
            print("data : ",data)
            
            let basicResult = try JSONDecoder().decode(AuctionPageRsJSONModel.self, from: data)
            
            
            //print("basicResult result: )" , basicResult.result)
//            let auctionData = try decoder.decode(AuctionJsonModel.self, from: basicResult.result) // 만들어놓은 Json모델과 연결
            let locations  = basicResult.result
            let rsmessage : String = basicResult.message
            print("rsmessage : ", rsmessage)

            
                let location = AuctionPageModel(
                    auctionid: locations.auctionid,
                    seller_id: locations.seller_id,
                    title: locations.title,
                    content: locations.content,
                    pic: locations.pic,
                    fish: locations.pic,
                    view: locations.view,
                    pricestart: locations.pricestart,
                    pricenow: locations.pricenow,
                    insertdate: locations.insertdate,
                    deletedate: locations.deletedate,
                    issuccessed: locations.issuccessed
                )
            

            DispatchQueue.main.async {
                self.delegate.getAuctionPage(item: location)
                
                return
            }//dispatchQue
        } catch {
            print("Error decoding JSON: \(error)")
        }//catch
    }//parseJSON
    
    
}// struct
