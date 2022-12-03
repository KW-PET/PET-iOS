//
//  Login.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/20.
//

import SwiftUI
import Alamofire

struct LoginResponse: Codable {
    let status:Int?
    let data: String
    let success:Bool?
}

class LoginManager: ObservableObject {
    @Published var jwtToken: String
    @StateObject var viewModel = ContentVM()

    init() {
        jwtToken = ""
    }
    
    func setJwtToken(accessToken: String) {
        getJwtToken(accessToken: accessToken) { returnedData in
            DispatchQueue.main.async { [weak self] in
                self?.jwtToken = returnedData
                UserDefaults.standard.set(returnedData, forKey: "jwtToken")
            }
        }
    }
    
    func getJwtToken(accessToken:String, escapingHandler: @escaping (_ data: String)->Void){
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        AF.request("\(baseURL)/kakao/login?access_Token=\(accessToken)", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
            var routines: String
            do {
                let decoder = JSONDecoder()
                switch (response.result) {
                case .success:
                    let result  = try decoder.decode(LoginResponse.self, from: response.data!)
                    routines = result.data
                    escapingHandler(routines)
                case .failure(let error):
                    print("login error")
                }
            } catch let parsingError {
                print("login parsing Error:")
            }
        }.resume()
    }
    
}
