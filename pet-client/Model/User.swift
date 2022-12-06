//
//  User.swift
//  pet-client
//
//  Created by 김지수 on 2022/12/04.
//

import Foundation
public struct UserModel: Codable{
    var created_at: [Int]?
    var modified_at: [Int]?
    var userId: Int?
    var uuid: String?
    var name: String?
    var nickname: String?
    var email: String?
    var token: String?
    
    init(created_at: [Int], modified_at: [Int], userId: Int, uuid: String, name: String, nickname: String, email: String, token: String) {
        self.created_at = created_at
        self.modified_at = modified_at
        self.userId = userId
        self.uuid = uuid
        self.name = name
        self.nickname = nickname
        self.email = email
        self.token = token
    }
}
