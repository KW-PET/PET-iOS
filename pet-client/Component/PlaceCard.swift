//
//  PlaceCard.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/16.
//

import SwiftUI

struct PlaceCard: View {
    var placeType: PlaceType
    
    var body: some View{
        Button(action:{
            print("클릭")
        }){
            VStack{
                Image(placeType.image)
                Text(placeType.name)
                    .font(.system(size:11))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
            }
            .frame(width:70, height:70)
            .cornerRadius(15)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(ColorManager.LightGreyColor)
                    .shadow(color:Color.black.opacity(0.1),radius: 5, x:0, y:2)
            )
        }
    }
}
