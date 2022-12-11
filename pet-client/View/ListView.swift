//
//  ListView.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/16.
//

import SwiftUI

struct ListView: View {
    @State var placeList: [PlaceResult] = []
    @State var selectedId: Int = 0

    class SheetMananger: ObservableObject{
        @Published var isPresent : Bool = false
    }
    @StateObject var sheetManager = SheetMananger()
    
    func filterPlaceList() -> [PlaceResult] {
        if(selectedId == 0) {
            return placeList
        }
        var category: String
        switch selectedId {
        case 1:
            category = "동물병원"
        case 2:
            category = "동물약국"
        case 3:
            category = "동물미용업"
        case 4:
            category = "동물위탁관리업"
        case 5:
            category = "동물운송업"
        default:
            category = "동물장묘업"
        }
        
        return self.placeList.filter {
            $0.category == category
        }
    }

    var body: some View {
        ZStack{
            MainView(selectedId: $selectedId, isPresent: $sheetManager.isPresent, placeList: $placeList)
                .sheet(isPresented: $sheetManager.isPresent){
                    VStack{
                        Divider()
                        List{
                            ForEach(0..<filterPlaceList().count, id: \.self) { i in
                                PlaceListElem(place: filterPlaceList()[i])
                            }
                        }
                        .listStyle(.plain)
                        .listRowSeparator(.hidden)
                    }
                    .presentationDetents([.fraction(0.5), .medium,.large])
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
