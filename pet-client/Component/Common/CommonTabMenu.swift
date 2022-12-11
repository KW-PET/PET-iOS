//
//  CommonTabMenu.swift
//  pet-client
//
//  Created by 박수연 on 2022/12/03.
//

import Foundation
import SwiftUI

struct CommonTabMenu: View {
    @State private var selection = 0
    var body: some View {
        ZStack{
            TabView(selection: $selection) {
                ListView()
                    .padding(.bottom, 8)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("홈으로")
                    }
                    .zIndex(1000)
                    .tag(0)
                
                CommunityView()
                    .padding(.bottom, 8)

                    .tabItem {
                        Image(systemName: "quote.bubble.fill")
                        Text("커뮤니티")
                    }
                    .tag(1)
                
                RecommendView()
                    .padding(.bottom, 8)

                    .font(.system(size: 30))
                    .tabItem {
                        Image(systemName: "antenna.radiowaves.left.and.right")
                        Text("주변추천")
                    }
                    .tag(2)
                
                MypageView()
                    .padding(.bottom, 8)

                    .font(.system(size: 30))
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("마이페이지")
                    }
                    .tag(3)
            }
        }.zIndex(1000)
    }
}
