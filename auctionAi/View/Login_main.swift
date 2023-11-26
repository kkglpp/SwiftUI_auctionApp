//
//  Login_main.swift
//  Sol_SwiftUI_Login
//
//  Created by user on 2023/10/24.
//

import Foundation
import SwiftUI

struct Login_main  :View {


    @State var lgResult: Bool = false
    
    
//    init(tag : Binding<Int?> = .constant(0)){
//        _tag = tag
//    }
    
    let alerts = Alerts()
    var body: some View{
        
        if !lgResult{
            BeforeView(lgResult : $lgResult)
                
        }
        if lgResult{
            AfterView()
        }//if
        }//View
}//Struct Login Main
    

struct Login_main_Previews: PreviewProvider {
    static var previews: some View {
        Login_main()
    }
}





struct BeforeView: View {
    
    @State var emailInput : String
    @State var passwordInput : String
    @State var name : String
    @State var showingAlert = false
    @Binding var lgResult :Bool
    
    init(emailInput: String = "", passwordInput: String = "", name: String = "", showingAlert: Bool = false, lgResult: Binding<Bool> =  .constant(false)) {
        self.emailInput = emailInput
        self.passwordInput = passwordInput
        self.name = name
        self.showingAlert = showingAlert
        _lgResult = lgResult
    }

    var body: some View {
        VStack{
            Form{
                Section(header: Text(""), content: {
                    TextField("이메일", text: $emailInput).keyboardType(.emailAddress).autocapitalization(.none)
                    SecureField("비밀번호", text: $passwordInput).keyboardType(.default)
                })
                Section{
                    Button(action: {
                        // email 이랑 password 확인하기

                        var loginAction = LoginFunc()
                        loginAction.delegate = self
                        loginAction.loginClick(email: emailInput, password: passwordInput)
                    }, //acition
                           label: {
                        Text("로그인 하기")
                    }//label
                    )//button
                }//section ## Section 끝
            } //Form
        }//Vstack
        .alert(isPresented: $showingAlert){
            Alert(
                title: Text("로그인 실패"),
                message: Text("로그인에 실패하였습니다."),
                dismissButton: .default(Text("확인"))
            )}// Alert  //alert
        .navigationBarTitle(Text("로그인"))
    }
}
    
extension BeforeView : LoginProtocol{
    func loginCheck(item: UserModel) {
        let data = item
        print("Login Extension 왔니?")
        if data.message != "Logged in successfully"{ // 로그인 실패시 실행 코드
            self.showingAlert = true
            print("login 실패?")
        }
        else{ // 로그인 성공시 실행 코드
            self.lgResult.toggle()
            UserDefaults.standard.setValue(data.name, forKey: "user_name")
            UserDefaults.standard.setValue(data.nickname, forKey: "user_nick")
        }
    }
} //extension


struct AfterView: View {
    var body: some View {
        VStack{
            Text("로그인 성공")
                .font(.system(size: 24,weight: .bold))
                .padding(20)
            NavigationLink(
                destination: ContentView(),
                label:
                    {
                        
                        HStack{
                            
                            Text("홈화면으로 가기")
                            
                        }//Hstack
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    })
        } //VStack
//        .navigationBarTitle(Text("로그인 성공"))
        .navigationBarHidden(true)
    }
}
