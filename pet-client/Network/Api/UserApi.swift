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
    let success:Bool?
}

struct PostPetResponse: Codable{
    let status: Int?
    var data: PetModel?
    let success:Bool?
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
    
    func postPet(newPetData: newPetModel) async throws -> PostPetResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        let url = "\(baseURL)/pet"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        print(dateFormatter.string(from: newPetData.start_date))
        
        let header: HTTPHeaders = [
            "X_ACCESS_TOKEN": AuthService().getJwtToken(),
            "Content-Type": "multipart/form-data"
        ]
        
        let parameters = [
            "name" : newPetData.name,
            "age" : newPetData.age,
            "start_date" : dateFormatter.string(from: newPetData.start_date),
            "sort" : newPetData.sort
        ]
        
        return try await AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
            }
            
            multipartFormData.append(newPetData.file!, withName: "file", fileName: "\(dateFormatter.string(from: Date()))_\(newPetData.name)).jpg", mimeType: "image/png")
        }, to: url, method: .post, headers: header).serializingDecodable(PostPetResponse.self).value
        
        
    }
    
}
