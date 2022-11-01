//
//  CommentListElem.swift
//  pet-client
//
//  Created by 박수연 on 2022/11/01.
//

import Foundation

import SwiftUI

struct CommentListElem: View {
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
                    Text("말티즈 님")
                        .font(Font.system(size: 17))
                        .bold()
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
                
                Text("저희 아이도 말티즈인데 같이 놀고 싶어요~!! ㅎㅎ")
                    .font(.body)
                // 여러줄일 경우 정렬을 왼쪽정렬로 선택
                    .multilineTextAlignment(.leading)
                // 여러줄로 보여줄 수 있고, 옆으로 쭉 길게 보여주는건 비활성화 처리함
                    .fixedSize(horizontal: false, vertical: true)
            }
            
        }
        .frame(height: 80)
        .padding(5)
        
        Divider()
    }
}
