//
//  ListView.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/16.
//

import SwiftUI

struct ListView: View {
    @State var placeList: [PlaceResult] = []

    class SheetMananger: ObservableObject{
        @Published var isPresent : Bool = false
    }
    @StateObject var sheetManager = SheetMananger()
    
    var body: some View {
        ZStack{
            MainView(isPresent: $sheetManager.isPresent, placeList: $placeList)
                .sheet(isPresented: $sheetManager.isPresent){
                    VStack{
                        Divider()
                        
                        List{
                            ForEach(0..<placeList.count, id: \.self) { i in
                                PlaceListElem(place: placeList[i])
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
