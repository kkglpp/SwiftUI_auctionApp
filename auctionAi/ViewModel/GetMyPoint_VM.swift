//
//  GetMyPoint_VM.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import Foundation

protocol GetMyPointProtocol{
    func GetMyPoint(item : PointModel )
}

struct GetMyPoint_VM{
    var delegate : GetMyPointProtocol!
    let urlPath = "\(HOST)/balance/" //Login_Func 파일에서 선언해두었음.
    
    func getPoint(){
        if let url = URL(string: urlPath) {
            let access_token = UserDefaults.standard.value(forKey: "access_token")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue("Bearer \(access_token)", forHTTPHeaderField:"Authorization")
            print("Bearer : ", access_token)
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
    } //func
    
    
    // 받아온 response을 JSON으로 parse
    func parseJSON(_ data: Data) {
        do {
            print("parsonJSON 왔을까?")
            print("data : ",data)
            let basicResult = try JSONDecoder().decode(PointJSONModel.self, from: data)
            print("sold's basicResult result: )" , basicResult.result)
    //            let auctionData = try decoder.decode(AuctionJsonModel.self, from: basicResult.result) // 만들어놓은 Json모델과 연결
            let rsmessage : String = basicResult.message
            print("rsmessage : ", rsmessage)
            let location = PointModel(
                message: basicResult.message,
                result: basicResult.result
            )
            
            DispatchQueue.main.async {
                self.delegate.GetMyPoint(item: location)
                return
            }//dispatchQue
        } catch {
            print("Error decoding JSON: \(error)")
        }//catch
    }//parseJSON

}
