//
//  CommunityApi.swift
//  pet-client
//
//  Created by 김지수 on 2022/12/09.
//

import SwiftUI
import Alamofire

struct CommunityPostResponse: Codable {
    let status:Int?
    let data: [CommunityPostResponseModel]?
    let success:Bool?
}

struct CommunityWriteResponse: Codable {
    let status:Int?
    let success:Bool?
}

class CommunityManager: ObservableObject {
    @StateObject var viewModel = ContentVM()
    
    func addPost(category: String, tag: String, title: String, content: String) async throws -> CommunityWriteResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/post", method: .post, parameters: [ "category": category, "title": title, "content": content, "tag": tag], encoding: JSONEncoding.default, headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(CommunityWriteResponse.self).value
    }
    
    func getPostList(category: String) async throws -> CommunityPostResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/community", method: .post, parameters: [ "category": category ], encoding: JSONEncoding.default, headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(CommunityPostResponse.self).value
    }
    
    func getMyPostList() async throws -> CommunityPostResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/mypost", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(CommunityPostResponse.self).value
    }
    
    func getMyLikePostList() async throws -> CommunityPostResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/likepost", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(CommunityPostResponse.self).value
    }
}
