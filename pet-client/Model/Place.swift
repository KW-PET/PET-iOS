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
    let category: Int
    let name: String
    let address: String
    let phone: String
}


class PlaceType {
    var id: Int
    var image: String
    var name: String
    
    init(id: Int, image: String, name: String) {
        self.id = id
        self.image = image
        self.name = name
    }
}

public struct PlaceResult: Codable, Identifiable{
    public let id = UUID()
    let name : String
    let address : String
    let distance : Double
    let category : String
    let place_id : Int
    let phone : String
    let lon : Double?
    let lat : Double?
    var like_cnt : Int
    
    init(name : String,
         address : String,
         distance : Double,
         category : String,
         place_id : Int,
         phone : String,
         lon : Double,
         lat : Double,
         like_cnt : Int) {
        self.name = name
        self.address = address
        self.distance = distance
        self.category = category
        self.place_id = place_id
        self.phone = phone
        self.lon = lon
        self.lat = lat
        self.like_cnt = like_cnt
    }
    
}
