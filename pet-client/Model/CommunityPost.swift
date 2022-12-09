//
//  CommunityPost.swift
//  pet-client
//
//  Created by 김지수 on 2022/12/09.
//

import Foundation

public struct CommunityPostModel: Codable{
    var created_at: [Int]?
    var modified_at: [Int]?
    var postId: Int
    var title: String
    var content: String
    var writer: String
    var tag: String
    var category: String
    var view: Int
    var pic: String?
    var user: UserModel
}

public struct CommunityPostResponseModel: Codable{
    var post: CommunityPostModel
    var countLike: Int
    var countComment: Int
}
