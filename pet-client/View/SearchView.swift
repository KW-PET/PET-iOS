//
//  SearchView.swift
//  pet-client
//
//  Created by 박수연 on 2022/11/13.
//

import Foundation
import SwiftUI
import SwiftUIFlow


struct SearchView: View {
    @State var text : String = ""
    @State var placeList: [PlaceResult] = []
    @State var list : [String] = [ "유치원", "카페", "24시", "애견호텔", "응급"]
    
    var body: some View {
        VStack(alignment: .leading){
            VStack {
                SearchBar(text: $text, placeList: $placeList)
            }
            Divider()
            if(placeList.count == 0 ){
                Text("추천 검색어")
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(ColorManager.GreyColor)
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                    .padding(.horizontal, 20)
                
                VFlow(alignment: .leading) {
                    ForEach(list, id: \.self) { s in
                        Text(s)
                            .font(.system(size: 18).weight(.medium))
                            .foregroundColor(ColorManager.GreyColor)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                            .padding(.vertical, 3)
                            .padding(.horizontal, 5)
                        
                    }
                    
                }.padding(15)
                
                
                
                Spacer()
            }
            else{
                List{
                    ForEach(0..<placeList.count, id: \.self) { i in
                        PlaceListElem(place: placeList[i])
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}
    


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

