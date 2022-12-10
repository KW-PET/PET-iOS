//
//  CommunityListElem.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/22.
//

import SwiftUI

struct CommunityListElem: View {
    @Binding var communityPost: CommunityPostResponseModel
    var nowTime = Date()
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("# \(communityPost.post.tag)")
                    .font(.system(size: 15).weight(.medium))
                    .foregroundColor(ColorManager.GreyColor)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 9)
                    .cornerRadius(4)
                    .background(RoundedRectangle(cornerRadius: 4, style: .continuous).fill(ColorManager.YellowColor))
                Spacer()
                Text("\(Date().makeTime(created_at: communityPost.post.created_at!).relativeTime)")
                    .font(.system(size: 15).weight(.medium))
                    .foregroundColor(ColorManager.GreyColor)
            }.padding(.bottom, 6)
            Text("\(communityPost.post.title)")
                .font(.system(size: 18).weight(.bold))
                .foregroundColor(Color.black)
                .padding(.bottom, 4)
            Text("\(communityPost.post.content)")
                .font(.system(size: 17).weight(.medium))
                .foregroundColor(Color.black)
                .padding(.bottom, 10)
                .multilineTextAlignment(.leading)
            HStack{
                Text("👍 \(communityPost.countLike)")
                    .font(.system(size: 16).weight(.medium))
                    .foregroundColor(Color.black)

                Text("✏️ \(communityPost.countComment)")
                    .font(.system(size: 16).weight(.medium))
                    .foregroundColor(Color.black)
            }
        }
        .padding(18)
    }
}
