//
//  CommunityPostView.swift
//  pet-client
//
//  Created by 김지수 on 2022/11/15.
//

import SwiftUI

struct CommunityPostView: View{
    enum Field {
        case tag
        case title
        case content
    }
    
    @State var tag: String = ""
    @State var title: String = ""
    @State var content: String = ""
    @State var category: String = "같이해요"
    @State var requested: Bool = false
    @State var movePage: Bool = false
    @FocusState private var focusField: Field?

    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.gray
        let attributes: [NSAttributedString.Key:Any] = [.foregroundColor : UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
 
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
                
                Picker(selection: $category, label: Text("카테고리"), content: {
                    Text("같이해요").tag("같이해요")
                    Text("궁금해요").tag("궁금해요")
                    Text("얘기해요").tag("얘기해요")
                    Text("찾습니다").tag("찾습니다")
                })
                .pickerStyle(SegmentedPickerStyle())

                VStack{
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
                                movePage = try await CommunityManager().addPost(category: category, tag: tag, title: title, content: content).success ?? false
                                requested = true
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
                        .alert("작성 실패", isPresented:
                                Binding<Bool>(get: { !self.movePage && self.requested },
                                              set: {  self.movePage = !$0 })
                        ) {
                            Button("확인") {}
                        } message: {
                            Text("게시글 작성에 실패했습니다.")
                        }
                    }
                }
            }
            .padding(.vertical, 18)
            .padding(.horizontal, 28)
            .background(
                Color.white
                    .onTapGesture {
                        focusField = nil
                    }
            )
        }
    }
}
