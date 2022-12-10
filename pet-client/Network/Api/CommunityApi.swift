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

struct CommunityGetResponse: Codable {
    let status:Int?
    let data: CommunityGetResponseModel?
    let success:Bool?
}

struct LikePostResponse: Codable {
    let status:Int?
    let data: Bool?
    let success:Bool?
}
struct CommentPostResponse: Codable {
    let status:Int?
    let data: Int?
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
    
    func getPostDetail(postid:Int) async throws -> CommunityGetResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/post/\(postid)", method: .get, parameters: nil, encoding: JSONEncoding.default,  headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(CommunityGetResponse.self).value
    }
    
    func postLike(postid:Int) async throws -> LikePostResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/like/\(postid)", method: .post, parameters: nil, encoding: JSONEncoding.default,  headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(LikePostResponse.self).value
    }
    
    func postComment(postid:Int, comment: String) async throws -> CommentPostResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/post/comment", method: .post, parameters: ["comment":comment, "post":postid], encoding: JSONEncoding.default,  headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(CommentPostResponse.self).value
    }
    
    func postReply(postid:Int, comment: String, parentid: Int) async throws -> CommentPostResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/post/comment/reply", method: .post, parameters: ["comment":comment, "post":postid, "parentId": parentid], encoding: JSONEncoding.default,  headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(CommentPostResponse.self).value
    }
    
    
}
