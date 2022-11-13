//
//  MainView.swift
//  pet-client
//
//  Created by 박수연 on 2022/10/04.
//

import Combine
import SwiftUI
import NMapsMap
import UIKit

struct PlaceInfo: View {
    let place: Place
    
    var body: some View{
        VStack{
            VStack{
                Spacer()
                HStack{
                    Text(place.name)
                        .font(.system(size: 23).weight(.bold))
                        .padding(1)
                    Spacer()
                    Text("10:00 ~ 18:00")
                        .font(.system(size: 14).weight(.regular))
                        .foregroundColor(ColorManager.GreyColor)
                }
                
                HStack{
                    Text(place.address)
                        .font(.system(size: 17).weight(.regular))
                    Spacer()
                    Text("800m")
                        .font(.system(size: 16).weight(.bold))
                        .foregroundColor(ColorManager.OrangeColor)
                }
            }.padding(23)
            
            HStack{
                Button(action: {
                
                }){
                    HStack{
                            Image(systemName:"phone") .foregroundColor(.black)
                                .imageScale(.large)
                                .padding(5)
                            
                            Text("전화")
                                .font(.system(size:18))
                                .fontWeight(.medium)
                                .foregroundColor(Color.black)
                                .padding(5)
                        }
                        .frame(width:110, height:60)
                }
                Button(action: {
                
                }){
                    HStack{
                            Image(systemName:"bookmark") .foregroundColor(.black)
                                .imageScale(.large)
                                .padding(5)
                            
                            Text("찜")
                                .font(.system(size:18))
                                .fontWeight(.medium)
                                .foregroundColor(Color.black)
                                .padding(5)
                        }
                        .frame(width:110, height:60)
                }

                Button(action: {
                
                }){
                    HStack{
                            Image(systemName:"tray.and.arrow.up") .foregroundColor(.black)
                                .imageScale(.large)
                                .padding(5)
                            
                            Text("공유")
                                .font(.system(size:18))
                                .fontWeight(.medium)
                                .foregroundColor(Color.black)
                                .padding(5)
                        }
                        .frame(width:110, height:60)
                }

            }
        }
    }
}


struct MainView: View {
    @State var coord: (Double, Double) = (126.9784147, 37.5666805)
    @State var selectedId:Int = 10000
    @State var text : String = ""
    
    class SheetMananger: ObservableObject{
        @Published var curPlace : Place = Place(placeid: 0, xpos: 0, ypos: 0, category: 0, name: "", address: "", phone: "")
        @Published var ifView : Bool = false
    }
    

    @StateObject var sheetManager = SheetMananger()
    
    init(){
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                VStack {
                    
                    /*
                     Button(action: {coord = (129.05562775, 35.1379222)}) {
                     Text("Move to Busan")
                     }
                     Button(action: {coord = (126.9784147, 37.5666805)}) {
                     Text("Move to Seoul somewhere")
                     }
                     */
                    NavigationLink(destination: SearchView()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                    ) {
                        TextField("위치를 검색하세요",text: $text)
                                .multilineTextAlignment(.leading) 
                                .padding(15)
                                .padding(.horizontal,35)
                                .background(Color(.white))
                                .cornerRadius(15)
                                .shadow(color: .gray, radius: 2)
                                .padding(10)
                                
                                .overlay(
                                    HStack{
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            .padding(30)
                                    })
                        }
                    
                    
                    Spacer()
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
                }
                .zIndex(1)
                
                
                .sheet(isPresented: $sheetManager.ifView) {
                    PlaceInfo(place: sheetManager.curPlace)
                    .presentationDetents([.height(200)])}
                
                UIMapView(coord: coord, selectedId: selectedId, curPlace: $sheetManager.curPlace, ifView: $sheetManager.ifView)
                    .edgesIgnoringSafeArea(.vertical)
            }
        }
    }
}

struct UIMapView: UIViewRepresentable {
    var coord: (Double, Double)
    var selectedId : Int
    @Binding var curPlace:Place
    @Binding var ifView:Bool
    @State var mapview:NMFNaverMapView =  NMFNaverMapView()
    @State var markerList:[NMFMarker] = []
    @ObservedObject var viewModel = MainViewModel()
    
    func addMarker(_ mapView: NMFNaverMapView ) {
        
        let p = [
            Place( placeid: 1, xpos: 126.9783740, ypos:37.5800135, category: 1,name:"마루 동물병원",address: "서울특별시 노원구 석계로 13길 11",phone: "010-0000-0000"),
            Place( placeid: 1, xpos: 126.9763740, ypos:37.5870135, category: 1,name:"마루 동물병원2",address: "서울특별시 노원구 석계로 13길 11",phone: "010-0000-0000"),
            Place( placeid: 1, xpos: 126.9743740, ypos:37.5670135, category: 2,name:"마루 동물병원3",address: "서울특별시 노원구 석계로 13길 11",phone: "010-0000-0000"),
            Place( placeid: 1, xpos: 126.9663740, ypos:37.5970135, category: 3,name:"마루 동물병원4",address: "서울특별시 노원구 석계로 13길 11",phone: "010-0000-0000"),
            Place( placeid: 4, xpos: 126.9763240, ypos:37.5870135, category: 4,name:"마루 동물병원5",address: "서울특별시 노원구 석계로 13길 11",phone: "010-0000-0000"),
            Place( placeid: 1, xpos: 126.9763740, ypos:37.5955135, category: 5,name:"마루 동물병원6",address: "서울특별시 노원구 석계로 13길 11",phone: "010-0000-0000"),
            Place( placeid: 1, xpos: 126.7763740, ypos:37.5873135, category: 1,name:"마루 동물병원7",address: "서울특별시 노원구 석계로 13길 11",phone: "010-0000-0000") ]
        
        for place in p {
            if(selectedId == 10000){
                let marker = NMFMarker()
                
                marker.position = NMGLatLng(lat: (place.ypos), lng: (place.xpos))
                marker.mapView = mapView.mapView
                marker.iconTintColor = UIColor.red
                marker.userInfo = ["name" : place.name as String,
                                   "category": place.category as Int,
                                   "place": place]
                
                //터치 이벤트 등록해
                marker.touchHandler = { (overlay) -> Bool in
                    print("마커 터치")
                    curPlace = overlay.userInfo["place"] as! Place
                    ifView = true

                    //   viewModel.place = place
                    //  viewModel.placeId = overlay.userInfo["placeId"] as! String
                    //   viewModel.isBottomPageUp = true
                    return true
                }
            }
        }
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        //let view = NMFNaverMapView()
        mapview.showZoomControls = false
        mapview.mapView.positionMode = .direction
        mapview.mapView.zoomLevel = 13
        let coord = NMGLatLng(lat: coord.1, lng: coord.0)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        mapview.mapView.moveCamera(cameraUpdate)
        addMarker(mapview)
        
        print(ifView)
        
        return mapview
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        /*
        coord 값 변경 -> 카메라이동
        let coord = NMGLatLng(lat: coord.1, lng: coord.0)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        uiView.mapView.moveCamera(cameraUpdate)
         */
    }
    
    
}

class MainViewModel: ObservableObject{
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

