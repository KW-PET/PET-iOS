//
//  CommunityListElem.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/22.
//

import SwiftUI

struct CommunityListElem: View {
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("# 노원구")
                    .font(.system(size: 15).weight(.medium))
                    .foregroundColor(ColorManager.GreyColor)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 9)
                    .cornerRadius(4)
                    .background(RoundedRectangle(cornerRadius: 4, style: .continuous).fill(ColorManager.YellowColor))
                Spacer()
                Text("7분 전")
                    .font(.system(size: 15).weight(.medium))
                    .foregroundColor(ColorManager.GreyColor)
            }.padding(.bottom, 6)
            Text("월계동 중랑천에서 같이 산책하실 분~")
                .font(.system(size: 18).weight(.bold))
                .foregroundColor(Color.black)
                .padding(.bottom, 4)
            Text("오늘 8시에 같이 어울려 놀 분 없으실까요? 저희 아이는 말티즈입니다~")
                .font(.system(size: 17).weight(.medium))
                .foregroundColor(Color.black)
                .padding(.bottom, 10)
            HStack{
                Text("👍 3")
                Text("✏️ 5")
            }
        }
        .padding(18)
    }
}
