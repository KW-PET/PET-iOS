//
//  PostDetailView.swift
//  pet-client
//
//  Created by 박수연 on 2022/11/01.
//

import Foundation
import SwiftUI

struct PostDetailView: View{
    @State var selectedId:Int = 1
    
    var body: some View{
            VStack(){
                
                HStack{
                    Image("CommunityIcon")
                    Text("커뮤니티")
                        .font(.system(size: 20).weight(.bold))
                        .foregroundColor(Color.black)
                    Spacer()
                }
                .padding(.vertical, 18)
                .padding(.horizontal, 28)
            
                
                Divider()
                ScrollView() {

                PostView()
                CommentView()
                Spacer()
            }
                commentBar()

        }
    }
}



struct CommentView: View {
    var body: some View{
        VStack(alignment: .leading){
            CommentListElem()
            CommentListElem()
            CommentListElem()
        }
    }
}

struct commentBar: View {
    @State var text:String = ""
    @State var editText : Bool = false
    
    var body: some View{
        HStack{
            TextField("댓글을 입력하세요" , text: $text)
                .padding(15)
                .padding(.horizontal,5)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal,10)
                .padding(.top,2)
                .overlay(
                    VStack{
                       
                        if self.editText{
                                }
                        Image(systemName: "paperplane")
                            .foregroundColor(.black)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                            .padding(30)
                        }
                        
                ).onTapGesture {
                    self.editText = true
                }
        }
    }
}


struct PostView: View {
    var body: some View{
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                HStack{
                    Text("# 노원구")
                        .font(.system(size: 15).weight(.medium))
                        .foregroundColor(ColorManager.GreyColor)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 9)
                        .cornerRadius(4)
                        .background(RoundedRectangle(cornerRadius: 4, style: .continuous).fill(ColorManager.YellowColor))
                    Spacer()
                }.padding(.bottom, 6)
                
                Text("월계동 중랑천에서 같이 산책하실 분~")
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(Color.black)
                    .padding(.vertical, 10)
                Text("오늘 8시에 같이 어울려 놀 분 없으실까요? 저희 아이는 말티즈입니다~")
                    .font(.system(size: 19).weight(.medium))
                    .foregroundColor(Color.black)
                    .padding(.bottom, 10)
                Text("2022-10-31 11:23")
                    .font(.system(size: 15).weight(.medium))
                    .foregroundColor(ColorManager.GreyColor)
                    .padding(.bottom, 5)
                
                
                HStack() {
                    Image(systemName: "hare")
                            .resizable()
                            .foregroundColor(.white)
                            .background(Color.cyan.opacity(0.5))
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .padding(15)


                            VStack(alignment: .leading) {
                              Text("말티즈 님")
                              .font(Font.system(size: 20))
                              .bold()
                              .padding(.top, 5)
                              .padding(.bottom,1)
                              Text("초코 (5세)")
                              .font(Font.system(size: 17))
                              .padding(.bottom,5)
                          }
                          Spacer()
    
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .padding(.top, 25)
            }
            .padding(25)
            
            
            Divider()
            
            HStack{
                Image(systemName: "heart.circle.fill")
                    .foregroundColor(.black)
                    .imageScale(.large)

                Text("공감하기 3")
                    .font(.system(size: 17).weight(.medium))
                    .foregroundColor(Color.black)
                    .padding(.trailing,10)

                Image(systemName: "bubble.left.circle.fill")
                    .foregroundColor(.black)
                    .imageScale(.large)
                
                Text("댓글 5")
                    .font(.system(size: 17).weight(.medium))
                    .foregroundColor(Color.black)
            }
            .padding(.vertical, 8)
            .padding(.horizontal,20)
            Divider()
        }
     
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView()
    }
}
