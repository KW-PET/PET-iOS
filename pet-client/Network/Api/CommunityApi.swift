//
//  CommunityApi.swift
//  pet-client
//
//  Created by 김지수 on 2022/12/09.
//

import SwiftUI
import Alamofire

struct CommunityResponse: Codable {
    let status:Int?
    let success:Bool?
}

class CommunityManager: ObservableObject {
    @StateObject var viewModel = ContentVM()
    
    func addPost(category: String, tag: String, title: String, content: String) async throws -> CommunityResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/post", method: .post, parameters: [ "category": category, "title": title, "content": content, "tag": tag], encoding: JSONEncoding.default, headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(CommunityResponse.self).value
    }
}