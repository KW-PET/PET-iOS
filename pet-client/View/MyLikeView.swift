//
//  MyLikeView.swift
//  pet-client
//
//  Created by 김지수 on 2022/11/06.
//

import SwiftUI

struct MyLikeView: View{
    @State var placeList: [PlaceResult] = []

    var body: some View{
        NavigationView{
            VStack{
                HStack{
                    Text("찜한 매장")
                        .font(.system(size: 20).weight(.bold))
                        .foregroundColor(Color.black)
                    Spacer()
                }
                .padding(.vertical, 18)
                .padding(.horizontal, 28)
                
                if(placeList.isEmpty){
                    Spacer()
                    Text("찜한 매장이 없습니다.")
                        .font(.system(size: 16).weight(.bold))
                        .foregroundColor(ColorManager.GreyColor)
                    Spacer()
                } else{
                    List{
                        ForEach(0..<placeList.count, id: \.self) { i in
                            PlaceListElem(place: placeList[i])
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        .onAppear{
            Task{
                let result = try await PlaceManager().getMyLikePlaceList()
                 placeList = result.data ?? []
            }
        }
    }
}
