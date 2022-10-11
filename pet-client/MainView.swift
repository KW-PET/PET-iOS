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


struct Place: Codable {
    var name: String
    var placeId: Int
    var lon: Double
    var lat: Double
    var category: String
    var address: String
    var phone: String
    var like: Bool
    
    init(_name: String, _placeID: Int, _lon: Double, _lat: Double, _category: String, _address:String, _phone: String, _like: Bool){
        name=_name
        placeId=_placeID
        lon = _lon
        lat = _lat
        category = _category
        address = _address
        phone = _phone
        like = _like
    }
}

struct MainView: View {
    @State var coord: (Double, Double) = (126.9784147, 37.5666805)
        var body: some View {
            ZStack {
                VStack {
                    Button(action: {coord = (129.05562775, 35.1379222)}) {
                        Text("Move to Busan")
                    }
                    Button(action: {coord = (126.9784147, 37.5666805)}) {
                        Text("Move to Seoul somewhere")
                    }
                    Spacer()
                }
                .zIndex(1)
                VStack {
                    Spacer()

                }
                .zIndex(1)
                
                UIMapView(coord: coord)
                    .edgesIgnoringSafeArea(.vertical)
            }
        }
    }



struct UIMapView: UIViewRepresentable {
    var coord: (Double, Double)
    @ObservedObject var viewModel = MainViewModel()
    
    
    func addMarker(_ mapView: NMFNaverMapView ) {
        
        let p = [ Place(_name:"sample", _placeID: 1, _lon: 126.9783740, _lat:37.5970135, _category: "HOSPITAL",_address: "",_phone: "010-0000-0000",_like: false),
                  
            Place(_name:"sample", _placeID: 1, _lon: 126.9763740, _lat:37.5870135, _category: "HOSPITAL",_address: "",_phone: "010-0000-0000",_like: false),
                  
            Place(_name:"sample", _placeID: 1, _lon: 126.9780740, _lat:37.5770135, _category: "HOSPITAL",_address: "",_phone: "010-0000-0000",_like: false),
                  
            Place(_name:"sample", _placeID: 1, _lon: 126.9483740, _lat:37.5870135, _category: "HOSPITAL",_address: "",_phone: "010-0000-0000",_like: false),
                  
                  
            Place(_name:"sample", _placeID: 1, _lon: 126.9483740, _lat:37.5876135, _category: "HOSPITAL",_address: "",_phone: "010-0000-0000",_like: false),
                  
                  
            Place(_name:"sample", _placeID: 1, _lon: 126.9473740, _lat:37.5870135, _category: "HOSPITAL",_address: "",_phone: "010-0000-0000",_like: false),
                  
                  
            Place(_name:"sample", _placeID: 1, _lon: 126.9883740, _lat:37.5870135, _category: "HOSPITAL",_address: "",_phone: "010-0000-0000",_like: false)
            
                  ]
        
        for place in p {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: (place.lat), lng: (place.lon))
            marker.mapView = mapView.mapView
            marker.iconTintColor = UIColor.red
            marker.userInfo = ["name" : place.name ]
            
            //터치 이벤트 등록해
            marker.touchHandler = { (overlay) -> Bool in
                 print("마커 터치")
                 print(overlay.userInfo["name"] ?? "name없음")
                
              //   viewModel.place = place
               //  viewModel.placeId = overlay.userInfo["placeId"] as! String
              //   viewModel.isBottomPageUp = true
                 return true
               }
        }
      
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 13
        
        addMarker(view)
        
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        let coord = NMGLatLng(lat: coord.1, lng: coord.0)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        uiView.mapView.moveCamera(cameraUpdate)}
    
    
}

class MainViewModel: ObservableObject{
    
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
