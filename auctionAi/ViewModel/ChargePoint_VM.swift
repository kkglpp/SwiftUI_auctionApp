//
//  ChargePoint_VM.swift
//  auctionAi
//
//  Created by user on 2023/10/30.
//

import Foundation

protocol ChargingPointProtocol {
    
    func chargingPoint(item: BaseSimpleModel)
}

struct ChargingPoint_VM{
    var delegate: ChargingPointProtocol!
    let urlPath = "\(HOST)/balance/" //Login_Func 파일에서 선언해두었음.
    
    func chargeAction(method : String, amount : Int){
        let amount = String(amount)
        if let url = URL(string: urlPath) {
            let access_token = UserDefaults.standard.value(forKey: "access_token")!
            var request = URLRequest(url: url)
            

            let postData : [String: Any] = [
                "method" : method,
                "amount" : String(amount)
            ]
            do{
                // JSON 형식으로 인코딩
    print("리퀘스트의 : JSON 인코딩 시작전")
                let jsonData = try JSONSerialization.data(withJSONObject: postData)
    print("리퀘스트의 JSON 인코딩 되었음?")
                
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
            
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
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
    } //func

    func parseJSON(_ data: Data) {
//        let decoder = JSONDecoder()
        do {
//            print("parsonJSON 왔을까?")
//            print("data : ",data)
            
            let basicResult = try JSONDecoder().decode(BaseSimpleJSONModel.self, from: data)
            
            
            //print("basicResult result: )" , basicResult.result)
//            let auctionData = try decoder.decode(AuctionJsonModel.self, from: basicResult.result) // 만들어놓은 Json모델과 연결\
            let rsmessage : String = basicResult.result
            print("rsmessage : ", rsmessage)

            let location = BaseSimpleModel(
                message: basicResult.result,
                amount: basicResult.Amount
            )
            DispatchQueue.main.async {
                self.delegate.chargingPoint(item: location)
                return
            }//dispatchQue
        } catch {
            print(error)
            print("Error decoding JSON: \(error)")
        }//catch
    }//parseJSON
    
    
}
