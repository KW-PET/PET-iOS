//
//  Login.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/20.
//

import SwiftUI
import Alamofire

struct Test: Codable {
    let result: String
}

class Network:ObservableObject {
    func test() {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ?? ""
        guard let url = URL(string: "\(baseURL)/test?msg=hello") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        
        // Task 만들기
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            print("response=",response);
            // 응답 상태코드가 200(성공)일 경우에만 디코딩
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedData = try JSONDecoder().decode(Test.self, from: data)
                        print(decodedData)
                        print("this is parsing test = ", decodedData.result)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        // Task 수행하기
        dataTask.resume()
    }
}
