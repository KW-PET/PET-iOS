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
    
    func authCheck() -> Bool {
        var token = getJwtToken()
        return token == "" || token == nil ? false : true
    }
}
