//
//  Router.swift
//  pet-client
//
//  Created by 김지수 on 2022/11/26.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

enum ViewRouter {
    case main
    case login
}

struct CustomRouter: View {
    @State private var page: ViewRouter = ViewRouter.login

    var body: some View {
        switch page {
            case .main:
                MainView()
            case .login:
                LoginView().onOpenURL(perform: { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        AuthController.handleOpenUrl(url: url)
                    }
                })
        }
    }
}
