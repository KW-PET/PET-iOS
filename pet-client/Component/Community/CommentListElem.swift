//
//  CommentListElem.swift
//  pet-client
//
//  Created by 박수연 on 2022/11/01.
//

import Foundation

import SwiftUI

struct CommentListElem: View {
    var comment: CommentModel
    @Binding var isReply: Int
    var Icon : [String] = ["🐶", "🐱", "🐹", "🐰", "🐤"]

    
    var body: some View{
        
        HStack(alignment: .top) {
            
            VStack{
                Text(Icon[comment.nickname.count % 5])
                
            }
                .frame(width: 50, height: 50)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .padding(10)
            
            
            
            VStack(alignment: .leading){
                HStack(){
                    Text(comment.nickname + " 님")
                        .font(Font.system(size: 17))
                        .bold()
                        .padding(.top, 10)
                        .padding(.bottom, 1)
                    Text("\(Date().makeTime(created_at: comment.createdDate!).relativeTime)")
                        .font(.system(size: 13))
                        .foregroundColor(ColorManager.GreyColor)
                        .padding(.top, 10)
                        .padding(.bottom, 1)


                    
                    Spacer()
                    Button( action: {
                        isReply = comment.id
                    }){
                        HStack{
                            Image(systemName: "bubble.left")
                                .foregroundColor(ColorManager.GreyColor.opacity(0.7))
                                .imageScale(.small)
                            Text("답글")
                                .font(.system(size: 12).weight(.medium))
                                .foregroundColor(ColorManager.GreyColor.opacity(0.8))
                        }.frame(width:64,height:29)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(5)
                            .padding(.trailing,10)


                          
                    }
//
//                    Image(systemName: "exclamationmark.circle")
//                        .foregroundColor(ColorManager.GreyColor)
//                        .imageScale(.medium)
//                        .padding(.trailing,25)
                }
                
                Text(comment.comment)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
        }
        .frame(height: 78)
        .padding(.horizontal, 5)
        Divider()
    }
}


struct ReplyListElem: View {
    var comment: ReplyModel
    var Icon : [String] = ["🐶", "🐱", "🐹", "🐰", "🐤"]
    
    var body: some View{
        VStack(){
            HStack(alignment: .center) {
                Image(systemName: "arrow.turn.down.right")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                    .padding(.leading, 10)
                    .padding(.trailing, 0)

                
                VStack{
                    Text(Icon[comment.nickname.count % 5])
                    
                }
                    .frame(width: 50, height: 50)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .padding(10)
                
                
                VStack(alignment: .leading){
                    HStack(){
                        Text(comment.nickname + " 님")
                            .font(Font.system(size: 17))
                            .bold()
                            .padding(.top, 10)
                            .padding(.bottom, 1)
                        Text("\(Date().makeTime(created_at: comment.createdDate!).relativeTime)")
                            .font(.system(size: 13))
                            .foregroundColor(ColorManager.GreyColor)
                            .padding(.top, 10)
                            .padding(.bottom, 1)
                        
                        
                        
                        Spacer()
                    }
                    
                    Text(comment.comment)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
            }
            .frame(height: 78)
            .padding(.horizontal, 5)
            Divider()
        }

    }

}
