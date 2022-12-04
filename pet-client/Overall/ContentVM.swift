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
    }

    let authService = AuthService()
    @Published var authorized: Bool? = nil

    var viewMode: ViewMode {
        if let authorized = authorized {
            if authorized == true {
                return .main
            } else {
                return .signUp
            }
        } else {
            return .launching
        }
    }

    func checkAuthSession() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let result = self.authService.authCheck()
            self.authorized = result
        }
    }
}
