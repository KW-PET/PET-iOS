//
//  SearchBar.swift
//  pet-client
//
//  Created by 박수연 on 2022/10/25.
//

import Foundation
import SwiftUI
import CoreLocation
      
struct SearchBar: View {
    @Binding var text : String
    @State var editText : Bool = false
    @StateObject var locationManager = LocationManager()
    @Binding var placeList : [PlaceResult]
    
    var userLatitude: Double {
        return locationManager.lastLocation?.coordinate.latitude ?? 0
    }
    
    var userLongitude: Double {
        return locationManager.lastLocation?.coordinate.longitude ?? 0
    }

    var body: some View {
     
        HStack{
       

          
            TextField("위치를 검색하세요" , text : $text)
                .multilineTextAlignment(.leading)
                .padding(15)
                .padding(.horizontal,35)
                .background(Color(.white))
 
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(20)
                        
                        if self.editText{
                            Button(action : {
                                self.editText = false
                                self.text = ""
                                self.placeList = []
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }){
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(Color(.black))
                                    .frame(minWidth: 0, maxWidth: 10, alignment: .trailing)
                                    .padding(10)
                            }
                            
                        }
                        
                        Button(action: {
                            if(text != ""){
                                Task{
                                    let result = try await PlaceManager().getSearchPlaceList(lon: userLongitude, lat:userLatitude, name: self.text)
                                        placeList = result.data ?? []
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }
                                }
                            }
                            ){ Image(systemName: "paperplane")
                                    .foregroundColor(.black)
                                    .frame(minWidth: 0, maxWidth:5, alignment: .trailing)
                                    .padding(30)
                            }
                            
                     

                        
                       
                    }
                ).onTapGesture {
                    self.editText = true
                }
        }
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
        .padding(10)

        
    }
}

