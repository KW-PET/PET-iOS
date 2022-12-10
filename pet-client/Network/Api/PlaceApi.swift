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

class PlaceManager: ObservableObject {
    @StateObject var viewModel = ContentVM()
    
    func getPlaceList(lon: Double, lat: Double, sort: Int) async throws -> PlaceResponse {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        return try await AF.request("\(baseURL)/place", method: .post, parameters: [ "lon": lon, "lat": lat, "sort": sort ], encoding: JSONEncoding.default, headers: ["X_ACCESS_TOKEN": AuthService().getJwtToken(), "Content-Type":"application/json"]).serializingDecodable(PlaceResponse.self).value
    }
}