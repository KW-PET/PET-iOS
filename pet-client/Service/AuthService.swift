//
//  AuthService.swift
//  pet-client
//
//  Created by 김지수 on 2022/12/03.
//


import Foundation

class AuthService {
    func getJwtToken() -> String {
        return UserDefaults.standard.string(forKey: "jwtToken") ?? ""
    }

    func getNickname() -> String {
        return UserDefaults.standard.string(forKey: "nickname") ?? ""
    }

    func authCheck() -> Bool {
        return getJwtToken() != ""
    }
    
    func nicknameCheck() -> Bool {
        return getNickname() != ""
    }
}
