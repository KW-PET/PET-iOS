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
import CoreLocation


struct MainView: View {
    @State var text : String = ""
    @Binding var selectedId: Int
    @Binding var isPresent: Bool
    @Binding var placeList: [PlaceResult]
    @StateObject var locationManager = LocationManager()
    
    class SheetMananger: ObservableObject{
        @Published var curPlace : PlaceResult = PlaceResult(name: "", address: "", distance: 0, category: "", place_id: 0, phone: "", lon: 0, lat:0, like_cnt: 0)
        @Published var ifView : Bool = false
    }
    
    var userLatitude: Double {
        return locationManager.lastLocation?.coordinate.latitude ?? 0
    }
    
    var userLongitude: Double {
        return locationManager.lastLocation?.coordinate.longitude ?? 0
    }
    
    @StateObject var sheetManager = SheetMananger()
  
    init(selectedId: Binding<Int>, isPresent: Binding<Bool>, placeList: Binding<[PlaceResult]>){
        UINavigationBar.setAnimationsEnabled(false)
        _selectedId = selectedId
        _isPresent = isPresent
        _placeList = placeList
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
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

                    Button(action: {
                            self.isPresent = true
                    }) {
                        Text("목록 보기")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .foregroundColor(ColorManager.GreyColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(ColorManager.LightGreyColor)
                                    .shadow(color:Color.black.opacity(0.1),radius: 5, x:0, y:2)
                            )
                            .background(RoundedRectangle(cornerRadius: 30, style: .continuous).fill(Color.white))
                    }
                    
                    ScrollView(.horizontal){
                        HStack{
                            PlaceCard(placeType: PlaceType(id: 0, image: "AllIcon", name: "전체"), selectedId: $selectedId)
                            PlaceCard(placeType: PlaceType(id: 1, image: "HospitalIcon", name: "병원"), selectedId: $selectedId)
                            PlaceCard(placeType: PlaceType(id: 2, image: "PharmacyIcon", name: "약국"), selectedId: $selectedId)
                            PlaceCard(placeType: PlaceType(id: 3, image: "SalonIcon", name: "미용"), selectedId: $selectedId)
                            PlaceCard(placeType: PlaceType(id: 4, image: "HotelIcon", name: "호텔"), selectedId: $selectedId)
                            PlaceCard(placeType: PlaceType(id: 5, image: "TaxiIcon", name: "운송"), selectedId: $selectedId)
                            PlaceCard(placeType: PlaceType(id: 6, image: "FuneralIcon", name: "장묘"), selectedId: $selectedId)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                    }
                }
                .zIndex(10)
                                
                .sheet(isPresented: $sheetManager.ifView) {
                    PlaceInfo(place: $sheetManager.curPlace)
                    .presentationDetents([.height(200)])}

                UIMapView(lat: userLatitude, lon: userLongitude, selectedId: selectedId, curPlace: $sheetManager.curPlace, ifView: $sheetManager.ifView, placeList: $placeList)
                    .edgesIgnoringSafeArea(.vertical)
                    .padding(.bottom, 0)
                    .zIndex(1)
            }
        }
    }
}

struct UIMapView: UIViewRepresentable {
    var lat : Double
    var lon : Double
    var selectedId : Int
    var set : Bool = false
    @Binding var curPlace: PlaceResult
    @Binding var ifView: Bool
    @Binding var placeList: [PlaceResult]
    @State var mapview:NMFNaverMapView =  NMFNaverMapView()
    @State var markerlist : [NMFMarker] = []
    
    func makeCoordinator() -> Coordinator {
        Coordinator(placeList: $placeList, markerlist: $markerlist, curPlace: $curPlace, ifView : $ifView)
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        mapview.showZoomControls = false
        mapview.mapView.positionMode = .direction
        mapview.mapView.zoomLevel = 15
        mapview.showLocationButton = true
        mapview.mapView.addCameraDelegate(delegate: context.coordinator)
        
        return mapview
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        if(markerlist.isEmpty){
            if(lat != 0.0 && lon != 0.0){
                let coord = NMGLatLng(lat: lat, lng: lon)
                let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
                mapview.mapView.moveCamera(cameraUpdate)
            }
        }
        
        for marker in self.markerlist {
            let a = marker.userInfo["place"] as! PlaceResult
            if(self.selectedId == 0 ){
                marker.mapView = mapview.mapView
            }
            else if(self.selectedId == 1 ){
                marker.mapView =  a.category == "동물병원" ? mapview.mapView : nil
            }
            else if(self.selectedId == 2){
                marker.mapView =  a.category == "동물약국" ? mapview.mapView : nil
            }
            else if (self.selectedId == 3 ){
                marker.mapView =  a.category == "동물미용업" ? mapview.mapView : nil
            }
            else if (self.selectedId == 4 ){
                marker.mapView =  a.category == "동물위탁관리업" ? mapview.mapView : nil
            }
            else if (self.selectedId == 5 ){
                marker.mapView =  a.category == "동물운송업" ? mapview.mapView : nil
            }
            else if (self.selectedId == 6 ){
                marker.mapView =  a.category == "동물장묘업" ? mapview.mapView : nil
            }
            else {
                marker.mapView = mapview.mapView
            }
        }
        
    }
    
    class Coordinator: NSObject, NMFMapViewTouchDelegate, NMFMapViewCameraDelegate {
       // var parent :UIMapView
        @Binding var placeList : [PlaceResult]
        @Binding var markerlist : [NMFMarker]
        @Binding var curPlace : PlaceResult
        @Binding var ifView : Bool

        init(placeList: Binding<[PlaceResult]> , markerlist : Binding<[NMFMarker]>, curPlace : Binding<PlaceResult> , ifView: Binding<Bool>){
            //self.parent = parent
            _placeList = placeList
            _markerlist = markerlist
            _curPlace = curPlace
            _ifView = ifView
        }
        
        func setMarker (){
//            for marker in markerlist {
//                marker.mapView = nil   // 기존에 있던 마커 지우기
//            }
            
            for place in placeList {
                if(markerlist.contains(where: {$0.userInfo["id"] as! Int == place.place_id})){ continue } // 중복은 넣지 않음

                if(place.lat != nil && place.lon != nil){
                    let marker = NMFMarker()
                    marker.position = NMGLatLng(lat: Double(place.lat ?? 0), lng: Double( place.lon ?? 0))
                    
                    if(place.category=="동물병원"){
                        marker.iconTintColor = UIColor.red}
                    else if (place.category=="동물약국"){
                        marker.iconTintColor = UIColor.purple}
                    else if(place.category=="동물미용업"){
                        marker.iconTintColor = UIColor.systemRed}
                    else if (place.category=="동물위탁관리업"){
                        marker.iconTintColor = UIColor.systemPurple }
                    else if(place.category=="동물운송업"){
                        marker.iconTintColor = UIColor.green}
                    else if (place.category=="동물장묘업"){
                        marker.iconTintColor = UIColor.gray}
                    
                    
                    marker.userInfo = ["place": place, "id" : place.place_id ]
                                        
                    marker.touchHandler = { (overlay) -> Bool in
                        self.curPlace = overlay.userInfo["place"] as! PlaceResult
                        self.ifView = true
                        return true
                    }
                    markerlist.append(marker)
                }
                
            }
            
        }
        func mapViewCameraIdle(_ mapView: NMFMapView){
            Task{
                let result = try await PlaceManager().getPlaceList(lon: mapView.cameraPosition.target.lng, lat: mapView.cameraPosition.target.lat, sort: 1)
                self.placeList = result.data ?? []
                setMarker()
                
            }
        }
    }
}
