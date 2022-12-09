//
//  CommunityView.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/22.
//

import SwiftUI

struct CommunityView: View{
    @State var selectedId:Int = 1
    @State var postList: [CommunityPostResponseModel] = []
    
    var body: some View{
        NavigationView{
            ZStack{
                NavigationLink(destination: CommunityPostView()
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                ){
                    Image("PencilIcon")
                        .frame(width:70, height:70)
                        .cornerRadius(35)
                        .background(RoundedRectangle(cornerRadius: 35, style: .continuous).fill(ColorManager.YellowColor))
                        .overlay(
                            RoundedRectangle(cornerRadius: 35)
                                .stroke(ColorManager.LightGreyColor)
                                .shadow(color:Color.black.opacity(0.1),radius: 5, x:0, y:2)
                        )
                }
                .zIndex(10)
                .offset(x:120, y:270)

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
                            TabElem(selectedId: $selectedId, postList: $postList, title: "같이해요", id: 1)
                            TabElem(selectedId: $selectedId, postList: $postList, title: "궁금해요", id: 2)
                            TabElem(selectedId: $selectedId, postList: $postList, title: "얘기해요", id: 3)
                            TabElem(selectedId: $selectedId, postList: $postList, title: "찾습니다", id: 4)
                        }
                        Divider()
                    }
                    
                    TabView{
                        List{
                            ForEach(0..<postList.count, id: \.self) { i in
                                NavigationLink(destination: PostDetailView()
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true)
                                ){
                                    CommunityListElem(communityPost: $postList[i])
                                }
                            }
                        }
                        .listStyle(.plain)
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
        }.navigationBarBackButtonHidden(true)
        .onAppear{
            Task{
                let result = try await CommunityManager().getPostList(category: "같이해요")
                postList = result.data ?? []
            }
        }        
    }
}
