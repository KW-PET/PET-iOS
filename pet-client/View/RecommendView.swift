//
//  RecommendView.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/16.
//

import SwiftUI
import CoreLocation

struct RecommendView: View {
    @State var sortOrder: String = "recommend"
    @State var placeList: [PlaceResult] = []
    @StateObject var locationManager = LocationManager()
    
    var userLatitude: Double {
        return locationManager.lastLocation?.coordinate.latitude ?? 0
    }
    
    var userLongitude: Double {
        return locationManager.lastLocation?.coordinate.longitude ?? 0
    }

    var body: some View {
        NavigationView{
            VStack{
                Divider()
                VStack{
                    Text("\(UserDefaults.standard.string(forKey: "nickname") ?? "") 님!\n이런 곳은 어떠세요?")
                        .font(.system(size: 20).weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        Button(action: {
                            Task{
                                self.sortOrder = "recommend"
                                let result = try await PlaceManager().getPlaceList(lon: userLongitude, lat: userLatitude, sort: 2)
                                placeList = result.data ?? []
                            }
                        }) {
                            Text("추천 순")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .foregroundColor(self.sortOrder == "recommend" ? ColorManager.OrangeColor : ColorManager.GreyColor)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(self.sortOrder == "recommend" ? ColorManager.OrangeColor : ColorManager.LightGreyColor, lineWidth: 1)
                                )
                        }
                        Button(action: {
                            Task{
                                self.sortOrder = "distance"
                                let result = try await PlaceManager().getPlaceList(lon: userLongitude, lat: userLatitude, sort: 1)
                                placeList = result.data ?? []
                            }
                        }) {
                            Text("가까운 순")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .foregroundColor(self.sortOrder == "recommend" ? ColorManager.GreyColor : ColorManager.OrangeColor)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(self.sortOrder == "recommend" ? ColorManager.LightGreyColor : ColorManager.OrangeColor, lineWidth: 1)
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
                    ForEach(0..<placeList.count, id: \.self) { i in
                        PlaceListElem(place: placeList[i])
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("주변추천")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear{
            Task{
                let result = try await PlaceManager().getPlaceList(lon: userLongitude, lat: userLatitude, sort: 2)
                placeList = result.data ?? []
                sortOrder = "recommend"
            }
        }
    }
}

struct RecommendView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendView()
    }
}
