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

                Button(action:{print("clicked!")}){
                    Text("작성 완료")
                        .font(.system(size: 15).weight(.medium))
                        .foregroundColor(Color.white)
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 7)
                .frame(maxWidth:.infinity)
                .background(ColorManager.OrangeColor)
                .cornerRadius(30)
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
