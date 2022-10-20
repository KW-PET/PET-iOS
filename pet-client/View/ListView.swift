//
//  ListView.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/16.
//

import SwiftUI

struct ListView: View {
    @State private var firstIsPresented = true
    @State var selectedId:Int = 10000

    var body: some View {
        ZStack{
            MainView()
                .sheet(isPresented: $firstIsPresented){
                    VStack{
                        ScrollView(.horizontal){
                            HStack{
                                PlaceCard(placeType: PlaceType(id: 1, image: "HospitalIcon", name: "병원"), selectedId: $selectedId)
                                PlaceCard(placeType: PlaceType(id: 2, image: "PharmacyIcon", name: "약국"), selectedId: $selectedId)
                                PlaceCard(placeType: PlaceType(id: 3, image: "SalonIcon", name: "미용"), selectedId: $selectedId)
                                PlaceCard(placeType: PlaceType(id: 4, image: "HotelIcon", name: "호텔"), selectedId: $selectedId)
                                PlaceCard(placeType: PlaceType(id: 5, image: "PharmacyIcon", name: "약국"), selectedId: $selectedId)
                                PlaceCard(placeType: PlaceType(id: 6, image: "SalonIcon", name: "미용"), selectedId: $selectedId)
                                PlaceCard(placeType: PlaceType(id: 7, image: "HotelIcon", name: "호텔"), selectedId: $selectedId)
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
