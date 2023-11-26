//
//  GetPredict_VM.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import Foundation
import SwiftUI
//import UIKit

protocol GetPredictProtocol{
    func getpredict(item:[PredictModel])
}
struct GetPredict_VM{
    
    var delegate:GetPredictProtocol!
    let urlPath = "\(HOST)/ai/" //Login_Func 파일에서 선언해두었음.
    
    func predictFish(paramName: String, fileName: String, img: UIImage){
        
        // 바운더리를 구분하기 위한 임의의 문자열. 각 필드는 `--바운더리`의 라인으로 구분된다.
        let boundary = UUID().uuidString
        //let session = URLSession.shared
        let url: URL = URL(string: urlPath)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"  // Post 방식 설정
        var data = Data()

        
       
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        let fileField = "file"
        //let imageFieldName = "image"
        data.append("Content-Disposition: form-data; name=\"\(fileField)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//        data.append("file=".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        
        if let imageData = img.pngData() {
             data.append(imageData)
         }
//        data.append(";type=image/png\r\n\r\n".data(using: .utf8)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        
//        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        
        print("accept: ", "application/json")
//        print("Authorization: ", "Bearer \(access_token)")
        print("buy's url은 완성")
        print("request의 allheadFields", request.allHTTPHeaderFields)
        print("request의 url",request.url)
        
        // Send a POST request to the URL, with the data we created earlier
        let task = URLSession.shared.dataTask(with: request){ (responseData, response, error) in
            if let error = error {
                print("error 발생")
                print(error)
                return
            }
            if let responseData = responseData {
                print("responseData = responseData 실행")
                print("responseData : ", responseData)
                if let responseString = String(data: responseData, encoding: .utf8) {
                    DispatchQueue.main.async {
                        let rs = responseString
                        print("data's String : ", rs)
                    }// if let responseData
                }
                self.parseJSON(responseData)
            }
        }
        task.resume()
        
        
        
        
        // 모든 내용 끝나는 곳에 --(boundary)--로 표시해준다.
    } //func Get Predict
    
    
    
    // 받아온 response을 JSON으로 parse
    
    func parseJSON(_ data: Data) {
        
        let decoder = JSONDecoder()
            print("parsonJSON 왔을까?")
            print("data : ",data)
        do {
            
            
            // JSON 디코딩
            let decodedData = try decoder.decode(PredictJSONModel.self, from: data)
            var locations : [PredictModel] = []
            for index in decodedData.result{
                let location = PredictModel(
                    name: index.name,
                    prob: index.prob
                )
                locations.append(location)
            }

        
        DispatchQueue.main.async {
            //print("MODELcount: \(count)")

            self.delegate.getpredict(item: locations) // delegate를 통해 프로토콜에 파싱한 데이터를 넘겨준다
            return
        }
        } catch {
                print("JSON 파싱에 실패했습니다: \(error)")
            }
    }//parseJSON
    
    
}//Struct


