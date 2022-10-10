//
//  ContentView.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/01.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        return NavigationView{
            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all)
        
                Text("Hello world\n\n")
                
                //화면이동방법!
                NavigationLink(destination: MainView()
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                ) {
                    Text("메인 화면으로")
                }
                
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
