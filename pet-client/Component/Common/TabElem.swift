//
//  TabElem.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/22.
//

import SwiftUI

struct TabElem: View{
    @Binding var selectedId: Int
    @Binding var postList: [CommunityPostResponseModel]
    var title: String
    var id: Int

    var body: some View{
        Button(action:{
            Task{
                let result = try await CommunityManager().getPostList(category: title)
                postList = result.data ?? []
                selectedId = id
            }
        }){
            Text("\(title)")
                .font(.system(size: 15).weight(.medium))
                .foregroundColor(Color.black)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 7)
        .frame(maxWidth:.infinity)
        .overlay(Rectangle().frame(height: selectedId == id ? 4 : 0).foregroundColor(Color.black), alignment: .bottom)
    }
}
