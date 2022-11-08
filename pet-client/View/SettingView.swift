//
//  SettingView.swift
//  pet-client
//
//  Created by 김지수 on 2022/11/06.
//

import SwiftUI

struct SettingView: View{
    @State private var alarmToggle = true
    
    var body: some View{
        NavigationView{
            VStack{
                HStack{
                    Text("설정")
                        .font(.system(size: 20).weight(.bold))
                        .foregroundColor(Color.black)
                    Spacer()
                }
                .padding(.vertical, 18)
                .padding(.horizontal, 28)
                
                Divider()

                VStack {
                    Toggle("알림", isOn: $alarmToggle)
                        .font(.system(size: 16).weight(.bold))
                        .foregroundColor(Color.black)

                    HStack{
                        Text("~에 대한 각종 알림을 받습니다.")
                            .font(.system(size: 12).weight(.bold))
                            .foregroundColor(Color.gray)
                        Spacer()
                    }
                }
                .padding(.vertical, 18)
                .padding(.horizontal, 28)
                Spacer()
            }
        }
    }
}
