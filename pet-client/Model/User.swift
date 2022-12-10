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
    var nickname: String
    var email: String?
    var token: String?
}
