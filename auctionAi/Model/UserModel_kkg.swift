//
//  UserModel_kkg.swift
//  Sol_SwiftUI_Login
//
//  Created by user on 2023/10/24.
//

import Foundation

struct UserModel {
    
    var email: String
    var name: String
    var phone: String
    var address: String
    var nickname: String
    var message : String
    
    init(email: String, name: String, phone: String, address: String, nickname: String, message: String) {
        self.email = email
        self.name = name
        self.phone = phone
        self.address = address
        self.nickname = nickname
        self.message = message
    }
}
