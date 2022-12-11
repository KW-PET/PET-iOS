//
//  PlaceInfo.swift
//  pet-client
//
//  Created by 박수연 on 2022/12/11.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct PlaceInfo: View {
    let place: PlaceResult
    var body: some View {

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
