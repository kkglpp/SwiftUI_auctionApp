//
//  MyPoint_View.swift
//  auctionAi
//
//  Created by user on 2023/10/26.
//

import SwiftUI

struct MyPoint_View: View {
    
    @State var nowPoint : Int = 0
    
    var body: some View {
        
        VStack(alignment: .center){
            HStack{
                Spacer()
                Text("My Point")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(EdgeInsets(top: 50, leading: 30, bottom: 0, trailing: 30))
                Spacer()
            } //HStack
            Divider()
                .frame(height: 2)
                .background(.red)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
            Spacer()
            VStack{
                Spacer()

                Label {
                    Text(String("Rest Point : "))
                        .font(.system(size: 24, weight: .bold) )
                } icon: {
                    Image(systemName: "dollarsign.circle.fill")
                        .resizable()
                        .frame(width: 20,height: 20)
                    
                }
                
                Text(String(nowPoint))
                    .font(.system(size: 24, weight: .bold) )
                    .frame(width: 180)
                Spacer()

            } //VStack
            .frame(height: 200)
            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))

            Spacer()
            
            HStack(alignment: .bottom){
                Spacer()
                NavigationLink (
                    destination : ChargingPoint(nowPoint: nowPoint),
                 label: {
                    HStack{
                        Image(systemName: "ev.charger.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                        Text("Point \n Charging")
                            .font(.system(size: 18, weight: .bold))
                            .frame(width: 100)
                            .foregroundColor(.red)
                    }//navi > label > Hstack
                }
            )
                Spacer(minLength: 50)
               
                NavigationLink (
                    destination: RefundPoint(nowPoint: nowPoint),
                 label: {
                    HStack{
                        
                        Image(systemName: "dollarsign.arrow.circlepath")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                        
                        Text("Excahnge \n Point")
                            .font(.system(size: 18, weight: .bold))
                            .frame(width: 100)
                            .foregroundColor(.blue)
                    }//navi > label > Hstack
                })
                Spacer()
            } //HStack
            .frame(height: 50)
            .padding(EdgeInsets(top: 10, leading: 40, bottom: 50, trailing: 40))
        } //Vstack
        .onAppear {
            print("onAppeart실행됨?")
            var getMyPoint = GetMyPoint_VM()
            getMyPoint.delegate = self
            getMyPoint.getPoint()
        }//onAppear
        
    }// body
} //struct

extension MyPoint_View : GetMyPointProtocol {
    func GetMyPoint(item: PointModel) {
        if item.message != "Amounts Loaded Successfully"{
            print("가져오기 실패.")
        }else {
            
            if let intValue = Int(item.result) {
                nowPoint = intValue
                
            } else {
                
            }
        }
    }
    
    
}


#Preview {
    MyPoint_View()
}
