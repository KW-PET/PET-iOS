//
//  Place.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/16.
//

import Foundation

public struct Place: Hashable{
    let placeid: Int
    let xpos: Double
    let ypos: Double
    let category: String
    let name: String
    let address: String
    let phone: String
}
