//
//  PlaceApi.swift
//  pet-client
//
//  Created by 김지수 on 2022/12/10.
//

import SwiftUI
import Alamofire

struct PlaceResponse: Codable {
    let status:Int?
    var data: [PlaceResult]?
    let success:Bool?
}

struct LikeResponse: Codable {
    let status:Int?
    var data: Int?
    let success:Bool?
}


class PlaceManager: ObservableObject {
    @StateObject var viewModel = ContentVM()
    
    func getPlaceList(lon: Double, lat: Double, sort: Int) async throws -> PlaceResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/place", method: .post, parameters: [ "lon": lon, "lat": lat, "sort": sort ], encoding: JSONEncoding.default, headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(PlaceResponse.self).value
    }
    
    func getSearchPlaceList(lon: Double, lat: Double, name: String) async throws -> PlaceResponse {
        print(lon)
        print(lat)
        print(name)
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/place/search", method: .post, parameters: [ "lon": lon, "lat": lat, "name": name ], encoding: JSONEncoding.default, headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(PlaceResponse.self).value
    }
    
    func postLikePlace(placeid: Int) async throws -> LikeResponse {
        print(placeid)
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/place/like", method: .post, parameters: [ "place_id": placeid ], encoding: JSONEncoding.default, headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(LikeResponse.self).value
    }
}
