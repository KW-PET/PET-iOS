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
                        Divider()
                        
                        List{
//                            PlaceListElem(place: PlaceTemporary(name:"마루 동물병원", address:"서울시 노원구 석계로 13"))
//                            PlaceListElem(place: PlaceTemporary(name:"마루 동물병원2", address:"서울시 노원구 석계로 14"))
//                            PlaceListElem(place: PlaceTemporary(name:"마루 동물병원3", address:"서울시 노원구 석계로 15"))
//                            PlaceListElem(place: PlaceTemporary(name:"마루 동물병원", address:"서울시 노원구 석계로 13"))
//                            PlaceListElem(place: PlaceTemporary(name:"마루 동물병원2", address:"서울시 노원구 석계로 14"))
//                            PlaceListElem(place: PlaceTemporary(name:"마루 동물병원3", address:"서울시 노원구 석계로 15"))
//                            PlaceListElem(place: PlaceTemporary(name:"마루 동물병원", address:"서울시 노원구 석계로 13"))
//                            PlaceListElem(place: PlaceTemporary(name:"마루 동물병원2", address:"서울시 노원구 석계로 14"))
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
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
