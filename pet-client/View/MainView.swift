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
import UniformTypeIdentifiers



struct PlaceInfo: View {
    let place: PlaceResult
    
    var body: some View{
        VStack{
            VStack{
                Spacer()
                HStack{
                    Text(place.name)
                        .font(.system(size: 23).weight(.bold))
                        .padding(1)
                    Spacer()
                    Text(place.category)
                        .font(.system(size: 14).weight(.regular))
                        .foregroundColor(ColorManager.GreyColor)
                }
                
                HStack{
                    Text(place.address)
                        .font(.system(size: 13).weight(.regular))
                    Spacer()
                    Text(String(place.distance) + "km")
                        .font(.system(size: 16).weight(.bold))
                        .foregroundColor(ColorManager.OrangeColor)
                }
            }.padding(23)
            
            HStack{
                Button(action: {
                    if(place.phone != "") {
                        let phone = "tel://" + place.phone
                        guard let url = URL(string: phone) else { return }
                        UIApplication.shared.open(url)
                    }
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
                    //post API
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
                    //정보 복사
                    UIPasteboard.general.setValue(place.name,
                        forPasteboardType: UTType.plainText.identifier)
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
    @State var selectedId:Int = 0
    @State var text : String = ""
    
    
    class SheetMananger: ObservableObject{
        @Published var curPlace : PlaceResult = PlaceResult(name: "", address: "", distance: 0, category: "", place_id: 0, phone: "", xpos: 0, ypos:0, like_cnt: 0)
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
                            PlaceCard(placeType: PlaceType(id: 0, image: "HospitalIcon", name: "전체"), selectedId: $selectedId)
                            PlaceCard(placeType: PlaceType(id: 1, image: "HospitalIcon", name: "병원"), selectedId: $selectedId)
                            PlaceCard(placeType: PlaceType(id: 2, image: "PharmacyIcon", name: "약국"), selectedId: $selectedId)
                            PlaceCard(placeType: PlaceType(id: 3, image: "SalonIcon", name: "미용"), selectedId: $selectedId)
                            PlaceCard(placeType: PlaceType(id: 4, image: "HotelIcon", name: "호텔"), selectedId: $selectedId)
                            PlaceCard(placeType: PlaceType(id: 5, image: "HospitalIcon", name: "운송"), selectedId: $selectedId)
                            PlaceCard(placeType: PlaceType(id: 6, image: "HospitalIcon", name: "장묘"), selectedId: $selectedId)
                        }
                        .padding()
                        .padding(.top, 20)
                    }
                }
                .zIndex(10)
                
                
                .sheet(isPresented: $sheetManager.ifView) {
                    PlaceInfo(place: sheetManager.curPlace)
                    .presentationDetents([.height(200)])}
                
                UIMapView(coord: coord, selectedId: selectedId, curPlace: $sheetManager.curPlace, ifView: $sheetManager.ifView)
                    .edgesIgnoringSafeArea(.vertical)
                    .zIndex(1)
            }
        }
    }
}

struct UIMapView: UIViewRepresentable {
    var coord: (Double, Double)
    var selectedId : Int
    @Binding var curPlace:PlaceResult
    @Binding var ifView:Bool
    @State var mapview:NMFNaverMapView =  NMFNaverMapView()
    @State var markerlist : [NMFMarker] = []
    @StateObject var list : FetchData  // API GET!!!

    init(coord: (Double, Double), selectedId: Int, curPlace: Binding<PlaceResult>, ifView: Binding<Bool>) {
        self.coord = coord
        self.selectedId = selectedId
        _curPlace = curPlace
        _ifView = ifView
        _list = StateObject(wrappedValue: FetchData())
     }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> NMFNaverMapView {
        mapview.showZoomControls = false
        mapview.mapView.positionMode = .direction
        mapview.mapView.zoomLevel = 13
        mapview.showLocationButton = true
        mapview.mapView.addCameraDelegate(delegate: context.coordinator)
         
        return mapview
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        if(markerlist.isEmpty){
            let coord = NMGLatLng(lat: coord.1, lng: coord.0)
            let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
            cameraUpdate.animation = .fly
            cameraUpdate.animationDuration = 1
            mapview.mapView.moveCamera(cameraUpdate)
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
        }

    }
    
        class Coordinator: NSObject, NMFMapViewTouchDelegate, NMFMapViewCameraDelegate {
            var parent :UIMapView
            var count: Int = 1 // 추후 지움
            init(_ parent: UIMapView){
                self.parent = parent
            }
            
            func mapViewCameraIdle(_ mapView: NMFMapView){
//                print( mapView.cameraPosition.target.lat, mapView.cameraPosition.target.lng)

                self.parent.list.setData(lon: Double(  mapView.cameraPosition.target.lng), lat:Double( mapView.cameraPosition.target.lat) )


                for marker in self.parent.markerlist {
                    marker.mapView = nil
                }
                self.parent.markerlist = []
                
                for place in self.parent.list.datas {
             //       print(place)
            
                         let marker = NMFMarker()
                    marker.position = NMGLatLng(lat:37.5666805  + ( 0.0003 * Double(count) ) , lng:  126.9784147 )
                   // marker.position = NMGLatLng(lat: place.ypos, lng:  place.xpos)
                    
                    if(place.category=="동물병원"){
                        marker.iconTintColor = UIColor.red}
                    else if (place.category=="동물약국"){
                        marker.iconTintColor = UIColor.blue}
                        
                        marker.userInfo = ["place": place ]
                    marker.mapView = self.parent.mapview.mapView

                        marker.touchHandler = { (overlay) -> Bool in
                            self.parent.curPlace = overlay.userInfo["place"] as! PlaceResult
                            self.parent.ifView = true
                            return true
                        }
                    parent.markerlist.append(marker)
                    count = count + 1 //

                }
                
            }
            
        }
    
    
}
 

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

