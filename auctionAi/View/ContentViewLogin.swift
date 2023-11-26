//
//  ContentView.swift
//  Sol_SwiftUI_Login
//
//  Created by user on 2023/10/24.
//

import SwiftUI

struct ContentViewLogin: View {
    var imgList:[Image] = [Image("배낚시01"), Image("배낚시02"), Image("배낚시03"), Image("배낚시04")]
    
    var body: some View {
    
        NavigationView{
            
            VStack {
                Spacer()
                Text("Do You Long to \n Fishing? / Eating?")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                
                Spacer()
                imgList[Int.random(in: 0...3)]
                    .resizable()
                    .frame(width: 350,height: 300)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .font(.system(size: 150))
                    .padding()
                    .background(Color(red: .random(in: 0...0.3), green: .random(in: 0.3...0.9), blue: .random(in: 0.8...1), opacity: .random(in: 0.8...1)))
                    .cornerRadius(10)
                Spacer()
                NavigationLink(destination: Login_main(),
                               label: {
                        HStack{
                            Spacer()
                            Text("로그인 하러가기")
                            Spacer()
                        }//Hstack
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }//Label
                )//NaviLink
                NavigationLink(destination: Register_main(),
                               label: {

                        HStack{
                            Spacer()
                            Text("회원가입 하러가기")
                            Spacer()
                        }//Hstack
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                }//Label
                
                )//NaviLink
                Spacer()
                
    
                
                
                
            }//VStack
            .padding()
//            .navigationBarTitle(Text("환영합니다."))
            
        }//NavigationStack

     
    }
}

struct ContentViewLogin_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewLogin()
    }
}
