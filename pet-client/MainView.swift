//
//  MainView.swift
//  pet-client
//
//  Created by 박수연 on 2022/10/04.
//

import SwiftUI
import NMapsMap

struct MainView: View {
    var body: some View {
      ZStack {
    UIMapView()
        .edgesIgnoringSafeArea(.vertical)
}
}
}


struct UIMapView: UIViewRepresentable {
func makeUIView(context: Context) -> NMFNaverMapView {
let view = NMFNaverMapView()
view.showZoomControls = false
view.mapView.positionMode = .direction
view.mapView.zoomLevel = 17

return view
}

func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
