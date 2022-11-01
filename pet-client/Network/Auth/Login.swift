//
//  Login.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/20.
//

import SwiftUI
import Alamofire

func login(accessToken: String, fcmToken: String) {
    let param = [
        accessToken: accessToken,
        fcmToken: fcmToken
    ]
    
    let request = AF.request("\(Bundle.main.infoDictionary?["BASE_URL"])/kakao/login", method: .post, parameters: param, encoding: JSONEncoding.default)
    request.responseJSON { (data) in
        print(data)
    }
}
