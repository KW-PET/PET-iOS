//
//  CommunityPostView.swift
//  pet-client
//
//  Created by 김지수 on 2022/11/15.
//

import SwiftUI

enum PostCategory: String, CaseIterable, Identifiable {
    case 같이해요
    case 궁금해요
    case 얘기해요
    case 찾습니다

    var id: Self { self }
}

struct CommunityPostView: View{
    enum Field {
        case tag
        case title
        case content
    }
    
    @State var tag: String = ""
    @State var title: String = ""
    @State var content: String = ""
    @State private var category = PostCategory.같이해요
    @State var movePage: Bool = false

    @FocusState private var focusField: Field?
    
    var body: some View{
        NavigationView{
            VStack{
                HStack{
                    Image("CommunityIcon")
                    Text("게시글 작성")
                        .font(.system(size: 20).weight(.bold))
                        .foregroundColor(Color.black)
                    Spacer()
                }
                
                VStack{
                        Picker("카테고리", selection: $category) {
                            Text("같이해요").tag(PostCategory.같이해요)
                            Text("궁금해요").tag(PostCategory.궁금해요)
                            Text("얘기해요").tag(PostCategory.얘기해요)
                            Text("찾습니다").tag(PostCategory.찾습니다)
                        }
                        .padding(10)
                        .background(Color(.white))
                        .cornerRadius(15)
                        .shadow(color: .gray, radius: 2)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)

                    TextField("태그를 입력하세요 (1개만 입력 가능)", text: $tag)
                        .padding(15)
                        .background(Color(.white))
                        .cornerRadius(15)
                        .shadow(color: .gray, radius: 2)
                        .focused($focusField, equals: .tag)
                        .submitLabel(.next)

                    TextField("제목을 입력하세요", text: $title)
                        .padding(15)
                        .background(Color(.white))
                        .cornerRadius(15)
                        .shadow(color: .gray, radius: 2)
                        .focused($focusField, equals: .title)
                        .submitLabel(.next)
                    
                    TextEditor(text: $content)
                        .padding(15)
                        .background(Color(.white))
                        .cornerRadius(15)
                        .shadow(color: .gray, radius: 2)
                        .focused($focusField, equals: .content)
                }.onSubmit {
                    if(focusField == .tag) {
                        focusField = .title
                    }
                    else if(focusField == .title) {
                        focusField = .content
                    }
                }

                
                VStack{
                    NavigationLink(destination: CommunityView(), isActive: $movePage) {
                        Button(action:{
                            Task {
                                movePage = try await CommunityManager().addPost(category: category.rawValue, tag: tag, title: title, content: content).success ?? false
                            }
                        }){
                            Text("작성 완료")
                                .font(.system(size: 15).weight(.medium))
                                .foregroundColor(Color.white)
                                .frame(maxWidth:.infinity)
                        }
                        .padding(.vertical, 15)
                        .padding(.horizontal, 7)
                        .frame(maxWidth:.infinity)
                        .background(ColorManager.OrangeColor)
                        .cornerRadius(30)
                    }
                }
            }
            .padding(.vertical, 18)
            .padding(.horizontal, 28)
            .onTapGesture {
                focusField = nil
            }
        }
    }
}

//struct CommunityPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityPostView()
//    }
//}
