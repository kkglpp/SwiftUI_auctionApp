//
//  Login_main.swift
//  Sol_SwiftUI_Login
//
//  Created by user on 2023/10/24.
//

import Foundation
import SwiftUI


struct Register_main  :View {
    
    @State var email : String = ""
    @State var password : String = " "
    @State var password2 : String = " "
    @State var name : String = ""
    @State var nick : String = ""
    @State var phone : String = ""
    @State var address : String = ""
    @State var bankAccount : String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss

    
    var body: some View{
        
        VStack{
            Text("회원 가입 하기")
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
                //비밀번호
                Section(header: Text("비밀번호"), content: {
                    TextField("비밀번호", text: $password)
                })
                //비밀번호 확인
                Section(header: Text("비밀번호 확인"), content: {
                    TextField("비밀번호 확인", text: $password2)
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
                        var registAction = RegisterFunc()
                        registAction.delegate = self
                        registAction.registerAction(
                            id: email,
                            password: password,
                            name: name,
                            nickname: nick,
                            phone: phone,
                            bankaccount: bankAccount,
                            address: address)
                        
                        
                        //var result = registerFunc.registerAction
                    },label: {
                        Text("Register")
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

extension Register_main :Register_protocol{
    func regist(item: baseUsersResult) {
        if item.message == "User already exists"{
            showAlert(message: "User already exists")
            
        }
        if item.message == "User created successfully"
        {
            showAlert(message: "User created successfully")
        }
        
    }
}



