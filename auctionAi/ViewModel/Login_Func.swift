//
//  Login_Func.swift
//  Sol_SwiftUI_Login
//
//  Created by user on 2023/10/24.
//

import Foundation

//import JWTDecode


let HOST = Bundle.main.object(forInfoDictionaryKey:"HOST") as? String ?? ""
//let PORT = Bundle.main.object(forInfoDictionaryKey:"PORT") as? String ?? ""

protocol LoginProtocol {
    func loginCheck(item: UserModel)
}

struct LoginFunc{
    var delegate : LoginProtocol!
    let urlPath = "\(HOST)/auth"
    var tokens = ""
    var email = ""
    
    func loginClick(email: String, password: String){
        
        let url: URL = URL(string: urlPath)!
        var request = URLRequest(url: url)
       
        //print("loginCheck 실행")
        request.httpMethod = "POST"  // Post 방식 설정
        
        let postData = [
            "id" : email,
            "password" : password
        ]
        
        do{
            // JSON 형식으로 인코딩
            let jsonData = try JSONSerialization.data(withJSONObject: postData)
            
            
            request.httpBody = jsonData // body 데이터
            
            //application의 json 형태 선언
            // Type 을 forHTTPHeaderField
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") //application의 json 형태 선언
            
        }catch{
            print("Json으로 바꾸기 실패. : \(error)" )
            return // Json 으로변환 실패
        }
        
        
        //URLSession request하고 response 받아오기.
        let task = URLSession.shared.dataTask(with: request) {
            (data,response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            let headers = httpResponse.allHeaderFields //response 의 모든 헤더 저장,
            
            // 예제: Content-Type 헤더 읽기
            if let access_token = headers["access_token"] as? String {
                UserDefaults.standard.setValue(access_token, forKey: "access_token")
                
                print(UserDefaults.standard.value(forKey: "access_token")!)
            }
            
            if let refresh_token = headers["refresh_token"] as? String {
                UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
            }

            // 서버로부터의 응답을 처리.
            if let data = data {
                // 데이터를 사용하거나 파싱.
                
                self.parseJSON(data,phone: "010-000-0000", address: "제주특별시 오잔동 222-2", email: email )
            }

        }
        task.resume()

    
    }
        // parserJson 함수
    
    
    
    func parseJSON(_ data: Data, phone : String, address: String, email : String){
            let decoder = JSONDecoder()
            var location = UserModel(email: "", name: "", phone: "", address: "",nickname:"", message:"")
            do{
                // JSON Array 형태이므로 배열에 맞게 인덱스별로 나누어 접근을 해야 한다.
                
                let result = try decoder.decode([LoginJSON].self, from: data) // json 풀기
                // 배열이므로 첫번째 값을 주어야한다.
                var userName = " "
                var userNick = " "
                do{
                    userName = result[0].name
                    userNick = result[0].nickname
                    
                
                }
                
                if result[0].name == "" {
                    userName = " "
                    userNick = " "
                }

                
                location = UserModel(email: "", name: userName, phone: phone, address : address, nickname: userNick , message: result[0].message )
                
            }catch{
                print("********************** 이 아래를 봐요 ******************")
                print("Fail: \(error.localizedDescription)")
                print(String(describing: error))
                print("********************** 이 위를 봐요 ******************")

                
            }
            DispatchQueue.main.async {
                //print("MODELcount: \(count)")
                UserDefaults.standard.setValue(email, forKey: "user_email")

                self.delegate.loginCheck(item: location) // delegate를 통해 프로토콜에 파싱한 데이터를 넘겨준다
                return
            }
        }
        
        
        
        
    }//end of struct

