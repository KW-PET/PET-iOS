//
//  PlaceCard.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/16.
//

import SwiftUI

struct PlaceCard: View {
    var placeType: PlaceType
    @Binding var selectedId: Int

    var body: some View{
        Button(action:{
            selectedId = placeType.id
        }){
            VStack{
                Image(placeType.image)
                    .resizable()
                    .frame(width: 35, height: 35)
                Text(placeType.name)
                    .font(.system(size:11))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
            }
            .frame(width:70, height:70)
            .cornerRadius(15)
            .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(selectedId==placeType.id ? ColorManager.YellowColor : Color.white))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(ColorManager.LightGreyColor)
                    .shadow(color:Color.black.opacity(0.1),radius: 5, x:0, y:2)
            )
        }
    }
}
