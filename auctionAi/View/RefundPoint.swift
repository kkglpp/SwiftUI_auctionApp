//
//  RefundPoint.swift
//  auctionAi
//
//  Created by user on 2023/10/30.
//

import SwiftUI

struct RefundPoint: View {
    
    var nowPoint :Int
    @State var exchagePoint : Int = 0
    @State var showingAlert : Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    init(nowPoint: Int) {
        self.nowPoint = nowPoint
        
        
    }
    
    
    var body: some View {
        
        VStack(alignment: .center){
            HStack{
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
                    .font(.system(size: 24, weight: .bold) )
                    .frame(width: 150)
                Spacer()
                
            } //HStack
            .frame(height: 50)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            
            HStack{
                Spacer()
                
                Label {
                    Text("Exchange amount :  ")
                        .font(.system(size: 15, weight: .bold) )
                } icon: {
                    Image(systemName: "pesetasign.circle.fill")
                        .resizable()
                        .frame(width: 20,height: 20)
                }
                
                Text(String(exchagePoint))
                    .font(.system(size: 24, weight: .bold) )
                    .frame(width: 150)
                Spacer()
                
            } //HStack
            .frame(height: 50)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            
            
            HStack{
                Spacer()
                
                Label {
                    Text("After Exchange :  ")
                        .font(.system(size: 20, weight: .bold) )
                } icon: {
                    Image(systemName: "pesetasign.circle.fill")
                        .resizable()
                        .frame(width: 20,height: 20)
                }
                
                Text(String(nowPoint - exchagePoint))
                    .font(.system(size: 24, weight: .bold) )
                    .frame(width: 150)
                Spacer()
                
            } //HStack
            .frame(height: 50)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 50, trailing: 20))
            
            HStack(alignment: .bottom){
                Spacer()
                
                Button(action: {
                    exchagePoint -= 10000
                }, label: {
                    Text("- 10,000 won")
                        .font(.system(size: 20, weight: .bold))
                })
              
                Spacer(minLength: 40)
                Button(action: {
                    exchagePoint += 10000
                }, label: {
                    Text("+ 10,000 won")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.red)
                })
                Spacer()
            }//HStack
            .frame(height: 50)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            


            
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
                    chargePoint.chargeAction(method: "convert", amount:exchagePoint )
                    
                }, label: {
                    Text("Exchange")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.red)
                })

                Spacer()
                
            } //HStack
            .frame(height: 50)
            .padding(EdgeInsets(top: 10, leading: 40, bottom: 50, trailing: 40))
            
        } //Vstack
        .alert(isPresented: $showingAlert){
            Alert(
                title: Text("Success"),
                message: Text("Success refund"),
                dismissButton: .default(Text("확인"),
                                        action: {
                                            presentationMode.wrappedValue.dismiss()
                                        }//actioin
                                       )//dissmissbutton
            )}// Alert  //alert
    }//body
    
}//struct

extension RefundPoint : ChargingPointProtocol{
    func chargingPoint(item: BaseSimpleModel) {
        if item.message != "Success"{
            print("Faild")
            
        }else{
            self.showingAlert.toggle()
        }
        
        
    }
    
    
}
//#Preview {
//    RefundPoint()
//}
