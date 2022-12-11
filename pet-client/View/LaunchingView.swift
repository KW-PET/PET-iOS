//
//  LaunchingView.swift
//  pet-client
//
//  Created by 김지수 on 2022/12/04.
//

import SwiftUI

struct LaunchingView: View{
    @State var selectedId:Int = 1
    
    var body: some View{
        NavigationView{
            VStack{
                Image("LaunchingLogo")
                Spacer().frame(height: 200)
                Image("PetLogo")
                Spacer()
            }
        }
    }
}
