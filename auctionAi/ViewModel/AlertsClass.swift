//
//  AlertsClass.swift
//  Sol_SwiftUI_Login
//
//  Created by user on 2023/10/24.
//

import Foundation
import SwiftUI

struct Alerts{
    
    func loginfailed() -> Alert{
        let failAlert = Alert(
            title: Text("로그인 실패"),
            message: Text("로그인에 실패하였습니다."),
            primaryButton: .default(Text("확인"), action: {
                            // 확인 버튼을 탭했을 때 수행할 작업 추가
            }), secondaryButton: .cancel(Text("취소"))
        )
        
        return failAlert
        
    }
    
    
    func openfailed() -> Alert{
        let failAlert = Alert(
            title: Text("경매 실패"),
            message: Text("경매 시작에 실패하였습니다."),
            primaryButton: .default(Text("확인"), action: {
                            // 확인 버튼을 탭했을 때 수행할 작업 추가
            }), secondaryButton: .cancel(Text("취소"))
        )
        
        return failAlert
        
    }
}

//    Alert(
//            title: Text(self.title),
//            message: Text(self.message),
//            primaryButton: .default(Text("확인"),action: {
//                //확인버튼 누르고 동작.
//            }),
//            secondaryButton: .cancel(Text("취소"))
//
//        )
//    
//    
//
