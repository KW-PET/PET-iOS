//
//  RecommendView.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/16.
//

import SwiftUI

struct RecommendView: View {
    @State var isRecommendedOrder: Bool = true
    
    var body: some View {
        NavigationView{
            VStack{
                Divider()
                VStack{
                    Text("김지수 님!\n이런 곳은 어떠세요?")
                        .font(.system(size: 20).weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Button(action: {
                            self.isRecommendedOrder.toggle()
                        }) {
                            Text("추천 순")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .foregroundColor(self.isRecommendedOrder ? ColorManager.OrangeColor : ColorManager.GreyColor)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(self.isRecommendedOrder ? ColorManager.OrangeColor : ColorManager.LightGreyColor, lineWidth: 1)
                                )
                        }
                        Button(action: {
                            self.isRecommendedOrder.toggle()
                        }) {
                            Text("가까운 순")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .foregroundColor(self.isRecommendedOrder ? ColorManager.GreyColor : ColorManager.OrangeColor)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(self.isRecommendedOrder ? ColorManager.LightGreyColor : ColorManager.OrangeColor, lineWidth: 1)
                                )
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal,24)
                .padding(.top, 34)
                .padding(.bottom, 20)
                
                Divider()
                
                List{
                    PlaceListElem(place: PlaceTemporary(name:"마루 동물병원", address:"서울시 노원구 석계로 13"))
                    PlaceListElem(place: PlaceTemporary(name:"마루 동물병원2", address:"서울시 노원구 석계로 14"))
                    PlaceListElem(place: PlaceTemporary(name:"마루 동물병원3", address:"서울시 노원구 석계로 15"))
                    PlaceListElem(place: PlaceTemporary(name:"마루 동물병원", address:"서울시 노원구 석계로 13"))
                    PlaceListElem(place: PlaceTemporary(name:"마루 동물병원2", address:"서울시 노원구 석계로 14"))
                    PlaceListElem(place: PlaceTemporary(name:"마루 동물병원3", address:"서울시 노원구 석계로 15"))
                    PlaceListElem(place: PlaceTemporary(name:"마루 동물병원", address:"서울시 노원구 석계로 13"))
                    PlaceListElem(place: PlaceTemporary(name:"마루 동물병원2", address:"서울시 노원구 석계로 14"))
                    PlaceListElem(place: PlaceTemporary(name:"마루 동물병원3", address:"서울시 노원구 석계로 15"))
                }
                .listStyle(.plain)
            }
            .navigationTitle("주변추천")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
