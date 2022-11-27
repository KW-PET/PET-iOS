//
//  Login.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/20.
//

import SwiftUI
struct LoginResult: Codable {
    let status:Int
    let data: String
    let success:Bool
}

class LoginManager: ObservableObject {
    @Published var isLoggedIn = false
    @State var accessToken = UserDefaults.standard.string(forKey: "accessToken")
    
    func signIn(accessToken: String) {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        guard let url = URL(string: "\(baseURL)/kakao/login?access_Token=\(accessToken)") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: {[weak self] data, response, error in
            if let error = error { return }
            let response = response as? HTTPURLResponse
            let data = data
            DispatchQueue.main.async {
                if(response?.statusCode == 200) {
                    do{
                        self?.isLoggedIn = true
                        let decodedData = try JSONDecoder().decode(LoginResult.self, from: data!)
                        UserDefaults.standard.set(decodedData.data, forKey: "accessToken")
                    } catch{
                        print(error)
                    }
                }
            }
        })
        dataTask.resume()
    }
    
    func getAccessToken() -> String {
        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    
    func authCheck() -> Bool {
        var token = UserDefaults.standard.string(forKey: "accessToken")
        return token == "" || token == nil ? false : true
    }
}
