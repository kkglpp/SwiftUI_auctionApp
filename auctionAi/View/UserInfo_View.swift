//
//  UserInfo_View.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import SwiftUI

struct UserInfo_View: View {
    @State var email : String = ""
    @State var name : String = ""
    @State var nick : String = ""
    @State var phone : String = ""
    @State var address : String = ""
    @State var bankAccount : String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss

    init(email: String = "", name: String = "", nick: String = "", phone: String = "", address: String = "", bankAccount: String = "", showAlert: Bool = false, alertMessage: String = "") {
        self.email = email

        self.name = name
        self.nick = nick
        self.phone = phone
        self.address = address
        self.bankAccount = bankAccount
        self.showAlert = showAlert
        self.alertMessage = alertMessage
    }
    var body: some View {
        
        VStack{
            Text("정보 수정 하기")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(30)
            Form{
                //이메일
                Section(header: Text("email"), content: {
                    TextField("email을 입력해주세요", text: $email)
                })
                //이름
                Section(header: Text("이름"), content: {
                    TextField("이름", text: $name)
                })
                //이름
                Section(header: Text("NickName"), content: {
                    TextField("Nick", text: $nick)
                })
                //주소
                Section(header: Text("address"), content: {
                    TextField("address", text: $address)
                })
                
                //핸드폰번호
                Section(header: Text("phone"), content: {
                    TextField("핸드폰", text: $phone)
                })
                
                //통장
                Section(header: Text("Bank Account"), content: {
                    TextField("우리 1000 11 112233", text: $bankAccount)
                })
            }//Form
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
                HStack{
                    Button(action: {
//                        var registAction = RegisterFunc()
//                        registAction.delegate = self
//                        registAction.registerAction(
//                            id: email,
//                            name: name,
//                            nickname: nick,
//                            phone: phone,
//                            bankaccount: bankAccount,
//                            address: address)
                        
                        
                        //var result = registerFunc.registerAction
                    },label: {
                        Text("Modify")
                            .font(.system(size: 20, weight: .bold))
                    }//label
                    )//button
                    .padding(20)
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    },label: {
                        Text("Cancle")
                            .font(.system(size: 20, weight: .bold))
                        
                    }//label
                    )//button
                    .padding(20)
                    .foregroundColor(.red)
                }
            }
        }//body
    func showAlert(message: String) {
        self.alertMessage = message
        self.showAlert = true
    } //Func
        
    } //struct


#Preview {
    UserInfo_View()
}
