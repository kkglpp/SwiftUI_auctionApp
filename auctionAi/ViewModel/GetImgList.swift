//
//  GetImgList.swift
//  auctionAi
//
//  Created by user on 2023/10/30.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseStorage
import SwiftUI

protocol GetImgListProtocol{
    func getImgList(item : [Image])
}

struct GetImgList{
    
    var delegate : GetImgListProtocol!
    
    func downLoads(nameList : [String]){
        var rsList : [Image] = []
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // 이미지 파일의 경로 생성
        for name in nameList{
                let pathReference = storageRef.child(name) // 여기에 이미지 파일 이름을 지정해야 합니다.
                pathReference.downloadURL { (url, error) in
                    if let url = url {
                        print("if let url == url ")
                        // 다운로드 URL로부터 이미지 가져오기
                        
                        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                            if let data = data, let uiImage = UIImage(data: data) {
                                print("if let data = data", "let Uiimage = Uiimage")
                                // SwiftUI Image로 변환
                                
                                let image = Image(uiImage: uiImage)
                                DispatchQueue.main.async {
                                    rsList.append(image)
                                    print("리스트에 추가 성공")
                                }
                            }
                        }// task
                        task.resume()
                    } else {
                        print("이미지 다운로드 URL을 가져오는데 실패했습니다:", error?.localizedDescription ?? "Unknown error")
                        rsList.append(Image("woman\(String(format: "%02d", Int.random(in: 1...12)))"))
                    }
                }//DownLoadURL 문
            
        }//for
    }//func
}//struct
