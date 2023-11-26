//
//  GetAuctionList_VM.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import Foundation

protocol GetSellingListProtocol{
    func getSellingList(item: (String,[AuctionModel]))
}

struct GetSellingList_VM {
    
    var delegate: GetSellingListProtocol!

    let urlPath = "\(HOST)/auctions/" //Login_Func 파일에서 선언해두었음.
    
    
    //경매리 리스트를 불러오는 함수
    func downloadItems() {
        if let url = URL(string: urlPath) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            print(urlPath)
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                if let data = data {
                    print("task 실행 잘 된거 확인하기.")
                    print("task 에서  data : ",data)
                    self.parseJSON(data)
                }
            }
            task.resume()
        }
    }
    
    
    
    // 받아온 response을 JSON으로 parse
    func parseJSON(_ data: Data) {
//        let decoder = JSONDecoder()
        
        
        
        
        do {
            print("parsonJSON 왔을까?")
            print("data : ",data)
            
            let basicResult = try JSONDecoder().decode(BasicJSONmodel.self, from: data)
            
            
            //print("basicResult result: )" , basicResult.result)
//            let auctionData = try decoder.decode(AuctionJsonModel.self, from: basicResult.result) // 만들어놓은 Json모델과 연결
            var locations: [AuctionModel] = []
            let rsmessage : String = basicResult.message
            print("rsmessage : ", rsmessage)

            for index in basicResult.result {
                let query = AuctionModel(
                    auctionid: index.auctionid,
                    seller_id: index.seller_id,
                    buyer_id: index.buyer_id ?? "진행중",
                    title: index.title,
                    content: index.content,
                    pic: index.pic,
                    fish: index.fish,
                    view: index.view,
                    pricestart: index.pricestart,
                    pricenow: index.pricenow,
                    insertdate: index.insertdate,
                    deletedate: index.deletedate ?? "진행중",
                    endeddate: index.endeddate ?? "진행중",
                    issuccessed: index.issuccessed
                )
                locations.append(query)
            }

            DispatchQueue.main.async {
                self.delegate.getSellingList(item: (rsmessage,locations))
                
                return
            }//dispatchQue
        } catch {
            print("Error decoding JSON: \(error)")
        }//catch
    }//parseJSON
    
    
}
