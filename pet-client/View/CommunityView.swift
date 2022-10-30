//
//  CommunityView.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/22.
//

import SwiftUI

struct CommunityView: View{
    @State var selectedId:Int = 1
    
    var body: some View{
        NavigationView{
            VStack{
                HStack{
                    Image("CommunityIcon")
                    Text("커뮤니티")
                        .font(.system(size: 20).weight(.bold))
                        .foregroundColor(Color.black)
                    Spacer()
                }
                .padding(.vertical, 18)
                .padding(.horizontal, 28)
                
                ZStack(alignment: .bottom){
                    HStack{
                        TabElem(selectedId: $selectedId, title: "같이해요", id: 1)
                        TabElem(selectedId: $selectedId, title: "궁금해요", id: 2)
                        TabElem(selectedId: $selectedId, title: "얘기해요", id: 3)
                        TabElem(selectedId: $selectedId, title: "찾습니다", id: 4)
                    }
                    Divider()
                }
                TabView{
                    List{
                        CommunityListElem()
                        CommunityListElem()
                        CommunityListElem()
                        CommunityListElem()
                    }.listStyle(.plain)
                        .tabItem {
                            Text("같이해요")
                        }
                    CommunityListElem()
                        .tabItem {
                            Text("궁금해요")
                        }
                    CommunityListElem()
                        .tabItem {
                            Text("얘기해요")
                        }
                    CommunityListElem()
                        .tabItem {
                            Text("찾습니다")
                        }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }
}
