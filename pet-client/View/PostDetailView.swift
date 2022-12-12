//
//  PostDetailView.swift
//  pet-client
//
//  Created by 박수연 on 2022/11/01.
//

import Foundation
import SwiftUI

struct PostDetailView: View{
    var postId: Int
    @State var postDetail: CommunityGetResponseModel = CommunityGetResponseModel(post: CommunityPostModel(created_at: [0,0,0,0,0,0], modified_at: [], postId: 0, title: "", content: "", writer: "", tag: "", category: "", view: 0, pic: "", user: UserModel(created_at: [], modified_at: [], userId: 0, uuid: "", name: "_", nickname: "", email: "", token: "")), countLike: 0, countComment:0, comments: [])

    @State var petData : [PetModel] = [PetModel(petid: 0, name: "", pic: "", sort: "", age: 0, start_date: [0,0,0,0,0,0], user: UserModel(created_at: [], modified_at: [], userId: 0, uuid: "", name: "", nickname: "", email: "", token: ""))]
    @State var isReply: Int = 0
    
    var body: some View{
        NavigationView{            
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
                    PostView(postId : postId, postDetail: $postDetail, petData: $petData )
                    if(postDetail.countComment>0){
                        CommentView(postId: postId, postDetail: $postDetail ,isReply: $isReply)
                    }
                    Spacer()
                }
                commentBar(postId : postId, postDetail: $postDetail, isReply: $isReply )
            }
        }
        .onAppear{
            Task{
                let result = try await CommunityManager().getPostDetail(postid: postId)
                postDetail = result.data ?? CommunityGetResponseModel(post: CommunityPostModel(created_at: [], modified_at: [], postId: 0, title: "", content: "", writer: "", tag: "", category: "", view: 0, pic: "", user: UserModel(created_at: [], modified_at: [], userId: 0, uuid: "", name: "", nickname: "", email: "", token: "")), countLike: 0, countComment:0, comments: [])
                                
                let result_ = try await UserManager().getPetInfoFromID(userid: result.data!.post.user.userId!)
                petData = result_.data!.count == 0 ?  [PetModel(petid: 0, name: "", pic: "", sort: "", age: 0, start_date: [0,0,0,0,0,0], user: UserModel(created_at: [], modified_at: [], userId: 0, uuid: "", name: "", nickname: "", email: "", token: ""))] : result_.data!
                
                //   print(result_.data!)
                
            }
        }
   
    }
}



struct CommentView: View {
    var postId:Int
    @Binding var postDetail: CommunityGetResponseModel
    @Binding var isReply:Int
    
    var body: some View{
        VStack(alignment: .leading){
            if(postDetail.countComment>0){
                ForEach(0..<postDetail.comments!.count, id: \.self) { i in
                    CommentListElem(comment: postDetail.comments![i], isReply: $isReply)
                    
                    ForEach(postDetail.comments![i].childComments!) { line in
                        ReplyListElem(comment: line)
                    }
                    
                }
            }
        
        }
    }
}

struct commentBar: View {
    var postId:Int
    @Binding var postDetail: CommunityGetResponseModel
    @State var text:String = ""
    @Binding var isReply:Int
    
    var body: some View{
        HStack{
            if(isReply == 0){
                TextField("댓글을 입력하세요" , text: $text)
                    .padding(15)
                    .padding(.horizontal,5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal,10)
                    .padding(.top,2)
                    .overlay(
                        VStack{
                            Button(action: {
                                if(text != ""){
                                    Task{
                                        let result = try await CommunityManager().postComment(postid: postId, comment:text).success ?? false
                                        if(result){
                                            let result_ = try await CommunityManager().getPostDetail(postid: postId)
                                            postDetail = result_.data ?? CommunityGetResponseModel(post: CommunityPostModel(created_at: [], modified_at: [], postId: 0, title: "", content: "", writer: "", tag: "", category: "", view: 0, pic: "", user: UserModel(created_at: [], modified_at: [], userId: 0, uuid: "", name: "", nickname: "", email: "", token: "")), countLike: 0, countComment:0, comments: [])
                                            if(result_.success ?? false){
                                                text = ""
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                            ){ Image(systemName: "paperplane")
                                    .foregroundColor(.black)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                    .padding(30)
                            }
                        }
                    )
            }
            else{
                TextField("대댓글을 입력하세요" , text: $text)
                    .padding(15)
                    .padding(.horizontal,5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal,10)
                    .padding(.top,2)
                    .overlay(
                        HStack{
                                 Spacer()

                                Button(action : {
                                    self.text = ""
                                    self.isReply = 0
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }){
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(Color(.black))
                                        .frame(minWidth: 0, maxWidth: 10, alignment: .trailing)
                                }
                            Button(action: {
                                if(text != ""){
                                    Task{
                                        let result = try await CommunityManager().postReply(postid: postId, comment:text, parentid: isReply).success ?? false
                                        if(result){
                                            let result_ = try await CommunityManager().getPostDetail(postid: postId)
                                            postDetail = result_.data ?? CommunityGetResponseModel(post: CommunityPostModel(created_at: [], modified_at: [], postId: 0, title: "", content: "", writer: "", tag: "", category: "", view: 0, pic: "", user: UserModel(created_at: [], modified_at: [], userId: 0, uuid: "", name: "", nickname: "", email: "", token: "")), countLike: 0, countComment:0, comments: [])
                                            if(result_.success ?? false){
                                                text = ""
                                                self.isReply = 0
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                            ){ Image(systemName: "paperplane")
                                    .foregroundColor(.black)
                                    .frame(minWidth: 0, maxWidth:5, alignment: .trailing)
                                    .padding(30)
                            }
                        }
                        
                    )
            }
        }
    }
}


struct PostView: View {
    var postId:Int
    @Binding var postDetail: CommunityGetResponseModel
    @Binding var petData: [PetModel]

    var body: some View{
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                HStack{
                    Text("#" + postDetail.post.tag)
                        .font(.system(size: 15).weight(.medium))
                        .foregroundColor(ColorManager.GreyColor)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 9)
                        .cornerRadius(4)
                        .background(RoundedRectangle(cornerRadius: 4, style: .continuous).fill(ColorManager.YellowColor))
                    Spacer()
                }.padding(.bottom, 6)
                
                Text(postDetail.post.title)
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(Color.black)
                    .padding(.vertical, 10)
                Text(postDetail.post.content)
                    .font(.system(size: 19).weight(.medium))
                    .foregroundColor(Color.black)
                    .padding(.bottom, 10)
                HStack(){
                    Text( String(postDetail.post.created_at![0]) + "-\(postDetail.post.created_at![1])-\(postDetail.post.created_at![2]) \(postDetail.post.created_at![3]):\(postDetail.post.created_at![4])")
                        .font(.system(size: 15).weight(.medium))
                        .foregroundColor(ColorManager.GreyColor)
                        .padding(.bottom, 4)
                    Spacer()
                    Text("조회 "+String(postDetail.post.view) )
                        .font(.system(size: 12))
                        .foregroundColor(ColorManager.GreyColor)
                        .padding(.bottom, 4)
                }
                
                
                HStack() {
                    if((petData[0].pic) != nil && petData[0].pic != ""){
                        AsyncImage(url: URL(string: petData[0].pic!.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)! ,
                                   content:
                            { image in  image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                },
                                   placeholder:{
                            
                            })
                            .frame(width: 80, height: 80)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .padding(15)
                    }
                    else{
                        
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
                    }

                            VStack(alignment: .leading) {
                                Text(String(postDetail.post.user.nickname) + "님")
                              .font(Font.system(size: 20))
                              .bold()
                              .padding(.top, 5)
                              .padding(.bottom,1)
                                
                                if(petData[0].name != "" ){
                                    Text("\(petData[0].name) / \(petData[0].sort) ( \(petData[0].age)세 )")
                                        .font(Font.system(size: 17))
                                        .padding(.bottom,5)
                                }
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
                Button(action: {
                    Task {
                        let result = try await CommunityManager().postLike(postid: postId).data ?? false
                        // success-> post 성공여부 / data->늘리기 성공 여부 (이미 공감한 글은 false가 반환됨)
                        if(result){
                            let result_ = try await CommunityManager().getPostDetail(postid: postId)
                            postDetail = result_.data ?? CommunityGetResponseModel(post: CommunityPostModel(created_at: [], modified_at: [], postId: 0, title: "", content: "", writer: "", tag: "", category: "", view: 0, pic: "", user: UserModel(created_at: [], modified_at: [], userId: 0, uuid: "", name: "", nickname: "", email: "", token: "")), countLike: 0, countComment:0, comments: [])
                        }
                    }
                }){
                    Image(systemName: "heart.circle.fill")
                        .foregroundColor(ColorManager.GreyColor)
                        .imageScale(.large)
                    Text("공감하기 " + String(postDetail.countLike))
                        .font(.system(size: 17).weight(.medium))
                        .foregroundColor(ColorManager.GreyColor)
                        .padding(.trailing,10)
                    
                }

                Image(systemName: "bubble.left.circle.fill")
                    .foregroundColor(ColorManager.GreyColor)
                    .imageScale(.large)
                
                Text("댓글 " + String(postDetail.countComment))
                    .font(.system(size: 17).weight(.medium))
                    .foregroundColor(ColorManager.GreyColor)
            }
            .padding(.vertical, 8)
            .padding(.horizontal,20)
            Divider()
        }
       
    }
       
    }

