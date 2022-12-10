//
//  MyPostView.swift
//  pet-client
//
//  Created by 김지수 on 2022/11/06.
//

import SwiftUI

struct MyPostView: View{
    @State var postList: [CommunityPostResponseModel] = []

    var body: some View{
        NavigationView{
            VStack{
                HStack{
                    Text("내가 쓴 글")
                        .font(.system(size: 20).weight(.bold))
                        .foregroundColor(Color.black)
                    Spacer()
                }
                .padding(.vertical, 18)
                .padding(.horizontal, 28)

                if(postList.isEmpty){
                    Spacer()
                    Text("작성한 글이 없습니다.")
                        .font(.system(size: 16).weight(.bold))
                        .foregroundColor(ColorManager.GreyColor)
                    Spacer()
                } else{
                    List{
                        ForEach(0..<postList.count, id: \.self) { i in
                            NavigationLink(destination: PostDetailView(postId: postList[i].post.postId)
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                            ){
                                CommunityListElem(communityPost: $postList[i])
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        .onAppear{
            Task{
                let result = try await CommunityManager().getMyPostList()
                postList = result.data ?? []
            }
        }
    }
}

