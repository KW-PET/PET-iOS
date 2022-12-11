//
//  UserApi.swift
//  pet-client
//
//  Created by 김지수 on 2022/12/04.
//

import SwiftUI
import Alamofire

struct UserInfo: Codable {
    let status:Int?
    var data: UserModel?
    let success:Bool?
}

struct PetInfo: Codable{
    let status: Int?
    var data: [PetModel]?
    let sucess:Bool?
}

class UserManager: ObservableObject {
    @StateObject var viewModel = ContentVM()
    
    func getUserInfo() async throws -> UserInfo {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/user", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken()]).serializingDecodable(UserInfo.self).value
    }
    
    func getPetInfo() async throws -> PetInfo {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/pet", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken()]).serializingDecodable(PetInfo.self).value
    }
}
