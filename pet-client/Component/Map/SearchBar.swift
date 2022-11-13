//
//  SearchBar.swift
//  pet-client
//
//  Created by 박수연 on 2022/10/25.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var text : String
    @State var editText : Bool = false
    
    var body: some View {
     
        HStack{
       

          
            TextField("위치를 검색하세요" , text : $text)
                .multilineTextAlignment(.leading)
                .padding(15)
                .padding(.horizontal,35)
                .background(Color(.white))
 
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(20)
                        
                        if self.editText{
                            //x버튼이미지를 클릭하게되면 입력되어있던값들을 취소하고
                            //키입력 이벤트를 종료해야한다.
                            Button(action : {
                                self.editText = false
                                self.text = ""
                                //키보드에서 입력을 끝내게하는 코드
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }){
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(Color(.black))
                                    .padding(20)
                            }
                        }
                       
                    }
                ).onTapGesture {
                    self.editText = true
                }
        }
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
        .padding(10)

        
    }
}

