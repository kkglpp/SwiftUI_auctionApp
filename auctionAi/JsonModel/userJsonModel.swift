//
//  userJsonModel.swift
//  Sol_SwiftUI_Login
//
//  Created by user on 2023/10/24.
//

import Foundation

struct LoginJSON: Codable{
    
    var name: String
    var nickname: String
    var message : String

}

struct RegistJSONModel : Codable{
    
    var message : String
    var id : String
}

struct baseUsersResult : Hashable{
    var message : String
    var id : String
    
    init(message: String, id: String) {
        self.message = message
        self.id = id
    }
}
