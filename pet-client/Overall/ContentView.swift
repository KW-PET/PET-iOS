//
//  Router.swift
//  pet-client
//
//  Created by 김지수 on 2022/11/26.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

struct ContentView: View {
    @StateObject var viewModel = ContentVM()
    @EnvironmentObject var appState: AppState
    let authService = AuthService()
    
    var body: some View {
        VStack {
            switch viewModel.viewMode {
            case .signUp:
                LoginView().onOpenURL(perform: { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        AuthController.handleOpenUrl(url: url)
                    }
                })
            case .main:
                CommonTabMenu()
            }
        }
        .onAppear {
            Task{
                viewModel.checkAuthSession()
            }
        }
        .id(appState.contentViewId)
    }
}

