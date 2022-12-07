//
//  Login.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/20.
//

import SwiftUI
import Alamofire

struct LoginResponse: Codable {
    let status:Int?
    let data: String?
    let success:Bool?
}

class LoginManager: ObservableObject {
    @StateObject var viewModel = ContentVM()
    
    func getJwtToken(accessToken: String) async throws -> LoginResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/kakao/login?access_Token=\(accessToken)", method: .get, parameters: nil, encoding: JSONEncoding.default).serializingDecodable(LoginResponse.self).value
    }
    
    func updateNickname(nickname: String) async throws -> LoginResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/updateNickname", method: .post, parameters: [ "nickname": nickname ], encoding: JSONEncoding.default, headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(LoginResponse.self).value
    }
}
