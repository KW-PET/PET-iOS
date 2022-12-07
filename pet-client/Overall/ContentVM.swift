//
//  ContentVM.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/01.
//

import Foundation

class ContentVM: ObservableObject {
    enum ViewMode {
        case signUp
        case main
        case launching
        case setNickname
    }
    
    let authService = AuthService()
    @Published var authorized: Bool? = nil
    @Published var hasNickname: Bool = false
    
    var viewMode: ViewMode {
        if let authorized = authorized {
            if authorized == true {
                if hasNickname == true {
                    return .main
                } else {
                    return .setNickname
                }
            } else {
                return .signUp
            }
        } else {
            return .launching
        }
    }
    
    func checkAuthSession() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let authCheck = self.authService.authCheck()
            let nicknameCheck = self.authService.nicknameCheck()
            self.authorized = authCheck
            self.hasNickname = nicknameCheck
        }
    }
}
