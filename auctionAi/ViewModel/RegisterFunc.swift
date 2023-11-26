//
//  RegisterFunc.swift
//  Sol_SwiftUI_Login
//
//  Created by user on 2023/10/24.
//

import Foundation

protocol Register_protocol{
    func regist(item:baseUsersResult)
}


struct RegisterFunc{
    var delegate : Register_protocol!
    let urlPath = "\(HOST)/users" //Login_Func 파일에서 선언해두었음.

    func registerAction(id: String, password: String, name : String, nickname: String, phone : String, bankaccount : String, address : String){
        
        let userData: [String: Any] = [
            "id": id,
            "password": password,
            "name": name,
            "nickname": nickname,
            "phone": phone,
            "bankaccount": bankaccount,
            "address": address
        ]
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: userData)
            
            
            
            
            if let url = URL(string: urlPath) {
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.httpBody = jsonData
                
                
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
                                let responseData = responseString
                                print("data's String : ", responseData)
                            }
                        }
                        self.parseJSON(data)
                    }
                }
                
                task.resume()
            }// if let url end
        } catch{
          print("failed")
        }
    }//DownloadItems end
    
    
    
    
    
    // 받아온 response을 JSON으로 parse
    func parseJSON(_ data: Data) {
        

        do {
            print("parsonJSON 왔을까?")
            print("data : ",data)


            
            
            let basicResult = try JSONDecoder().decode(RegistJSONModel.self, from: data)
            
            
            print("regist' result: )" , basicResult.message)
    //            let auctionData = try decoder.decode(AuctionJsonModel.self, from: basicResult.result) // 만들어놓은 Json모델과 연결
            

                let query = baseUsersResult(
                    message: basicResult.message, id: basicResult.id
                )
            
            DispatchQueue.main.async {
                self.delegate.regist(item: query)
                return
            }//dispatchQue
        } catch {
            print("Error decoding JSON: \(error)")
        }//catch
    }//parseJSON
}//end of Struct
