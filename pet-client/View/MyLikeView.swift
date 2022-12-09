//
//  MyLikeView.swift
//  pet-client
//
//  Created by 김지수 on 2022/11/06.
//

import SwiftUI

struct MyLikeView: View{
    @State var selectedId:Int = 1
    
    var body: some View{
        NavigationView{
            VStack{
                HStack{
                    Text("공감한 글")
                        .font(.system(size: 20).weight(.bold))
                        .foregroundColor(Color.black)
                    Spacer()
                }
                .padding(.vertical, 18)
                .padding(.horizontal, 28)

                List{
//                    CommunityListElem(communityPost: <#Binding<CommunityPostResponseModel>#>)
//                    CommunityListElem()
//                    CommunityListElem()
//                    CommunityListElem()
                }.listStyle(.plain)
            }
        }
    }
}
