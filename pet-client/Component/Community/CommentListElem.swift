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
    
    var body: some View{
        HStack(alignment: .top) {
            Image(systemName: "hare")
                .resizable()
                .foregroundColor(.white)
                .background(Color.yellow.opacity(0.5))
                .frame(width: 50, height: 50)
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
                    Image(systemName: "bubble.left")
                        .foregroundColor(.gray)
                        .imageScale(.small)
                        .padding(.trailing,5)
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.gray)
                        .imageScale(.small)
                        .padding(.trailing,25)
                }
                
                Text(comment.comment)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
        }
        .frame(height: 80)
        .padding(.horizontal, 5)
        .padding(.vertical,2)
        
        Divider()
    }
}
