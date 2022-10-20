//
//  PlaceListElement.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/16.
//

import SwiftUI

struct PlaceListElem: View {
    let place: PlaceTemporary
    
    var body: some View{
        VStack{
            HStack{
                Text(place.name)
                    .font(.system(size: 20).weight(.bold))
                Spacer()
                Text("10:00 ~ 18:00")
                    .font(.system(size: 14).weight(.regular))
                    .foregroundColor(ColorManager.GreyColor)
            }
            
            HStack{
                Text(place.address)
                    .font(.system(size: 16).weight(.regular))
                Spacer()
                Text("800m")
                    .font(.system(size: 16).weight(.bold))
                    .foregroundColor(ColorManager.OrangeColor)
            }
        }
        .padding(.vertical,23)
    }
}

