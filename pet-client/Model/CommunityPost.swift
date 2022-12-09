//
//  CommunityPost.swift
//  pet-client
//
//  Created by 김지수 on 2022/12/09.
//

import Foundation

public struct CommunityPostModel: Codable{
    var post_id: Int
    var created_at: [Int]?
    var modified_at: [Int]?
    var category: String
    var content: String
    var tag: String?
    var title: String
    var view: Int
    var writer: String
    var user_id: Int
}