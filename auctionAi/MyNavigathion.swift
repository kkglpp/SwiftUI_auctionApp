//
//  MyNavigathion.swift
//  test
//
//  Created by AHNJAEWON1 on 2023/10/19.
//

import SwiftUI

struct MyNavigathion: View {
    var body: some View {
        
        NavigationView{
            ContentView()
                .navigationTitle("안녕하세요")
                .navigationBarItems(trailing: Text("확인"))

        }
    }
}
 
#Preview {
    MyNavigathion()
}
