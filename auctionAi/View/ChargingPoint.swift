//
//  ChargingPoint.swift
//  auctionAi
//
//  Created by user on 2023/10/30.
//

import SwiftUI

struct ChargingPoint: View {
    
    var nowPoint : Int
    @State var chargingPoint : Int = 0
    @State var showingAlert : Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    init(nowPoint: Int = 0) {
        self.nowPoint = nowPoint


    }

    var body: some View {
        
        VStack(alignment: .center){
            HStack(alignment: .top){
                Spacer()
                Text("My Point")
                    .font(.largeTitle)
                    .padding(EdgeInsets(top: 50, leading: 30, bottom: 0, trailing: 30))
                Spacer()
            } //HStack
            
            Divider()
                .frame(height: 2)
                .background(.red)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
            Spacer()
            HStack{
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
                    .font(.system(size: 18, weight: .bold) )
                    .frame(width: 150)
                Spacer()
                
            } //HStack
            .frame(height: 50)
            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
            
            
            
            HStack{
                Spacer()
                
                Label {
                    Text("Charge amount :  ")
                        .font(.system(size: 20, weight: .bold) )
                } icon: {
                    Image(systemName: "pesetasign.circle.fill")
                        .resizable()
                        .frame(width: 20,height: 20)
                }
                
                Text(String(chargingPoint))
                    .font(.system(size: 18, weight: .bold) )
                    .frame(width: 150)
                Spacer()
                
            } //HStack
            .frame(height: 50)
            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
            
            HStack{
                Spacer()
                
                Label {
                    Text("After Charging :  ")
                        .font(.system(size: 20, weight: .bold) )
                } icon: {
                    Image(systemName: "pesetasign.circle.fill")
                        .resizable()
                        .frame(width: 20,height: 20)
                }
                
                Text(String(nowPoint + chargingPoint))
                    .font(.system(size: 24, weight: .bold) )
                    .frame(width: 150)
                Spacer()
                
            } //HStack
            .frame(height: 50)
            .padding(EdgeInsets(top: 10, leading: 40, bottom: 50, trailing: 40))
            
            
            HStack(alignment: .bottom){
                Spacer()
                
                Button(action: {
                    chargingPoint -= 10000
                }, label: {
                    Text("- 10,000 won")
                        .font(.system(size: 20, weight: .bold))
                })
              
                Spacer(minLength: 40)
                Button(action: {
                    chargingPoint += 10000
                }, label: {
                    Text("+ 10,000 won")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.red)
                })
                Spacer()
            }//HStack

            Spacer()
            HStack(alignment: .bottom){
                Spacer()
                Button(action: {

                    
                    
                }, label: {
                    Text("Cancel")
                        .font(.system(size: 20, weight: .bold))
                })

                Spacer(minLength: 40)
                Button(action: {
                    var chargePoint = ChargingPoint_VM()
                    chargePoint.delegate = self
                    chargePoint.chargeAction(method: "charge", amount:chargingPoint )
                    
                }, label: {
                    Text("Charging")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.red)
                })

                Spacer()
            }//HStack
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
        } //Vstack
        .alert(isPresented: $showingAlert){
            Alert(
                title: Text("Success"),
                message: Text("Success Charging"),
                dismissButton: .default(Text("확인"),
                                        action: {
                                            presentationMode.wrappedValue.dismiss()
                                        }//actioin
                                       )//dissmissbutton
            )}// Alert  //alert
    } //body
}//struct

extension ChargingPoint : ChargingPointProtocol{
    func chargingPoint(item: BaseSimpleModel) {
        if item.message != "Success"{
            print("Faild")
            
        }else{
            self.showingAlert.toggle()
        }
        
        
    }
    
    
}


#Preview {
    ChargingPoint()
}
