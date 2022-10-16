//
//  ListView.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/16.
//

import SwiftUI

struct ListView: View {
    @State private var firstIsPresented = true
    
    var body: some View {
        ZStack{
            MainView()
                .sheet(isPresented: $firstIsPresented){
                    VStack{
                        ScrollView(.horizontal){
                            HStack{
                                PlaceCard(placeType: PlaceType(image: "HospitalIcon", name: "병원"))
                                PlaceCard(placeType: PlaceType(image: "PharmacyIcon", name: "약국"))
                                PlaceCard(placeType: PlaceType(image: "SalonIcon", name: "미용"))
                                PlaceCard(placeType: PlaceType(image: "HotelIcon", name: "호텔"))
                                PlaceCard(placeType: PlaceType(image: "PharmacyIcon", name: "약국"))
                                PlaceCard(placeType: PlaceType(image: "SalonIcon", name: "미용"))
                                PlaceCard(placeType: PlaceType(image: "HotelIcon", name: "호텔"))
                            }
                            .padding()
                            .padding(.top, 20)
                        }
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
                        }
                        .listStyle(.plain)
                        .listRowSeparator(.hidden)
                    }
                    .presentationDetents([.fraction(0.2), .medium,.large])
                    .background(Color.clear)
                }
        }
    }
}
