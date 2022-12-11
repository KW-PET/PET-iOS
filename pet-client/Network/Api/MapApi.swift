//
//  MapApi.swift
//  pet-client
//
//  Created by 박수연 on 2022/11/27.
//

//import Foundation
//import SwiftUI
//import Alamofire
//
//struct Response: Codable {
//    let status:Int?
//    let data: [PlaceResult]
//    let message : String?
//    let success:Bool?
//}
//
////
////MARK: VIEWMODEL
//class FetchData: ObservableObject {
//    @Published var datas: [PlaceResult] = []
//
//    init() {
//        //  setData(lon: 126.9784147, lat: 37.5666805)
//    }
//
//    func setData(lon : Double, lat : Double) {
//        getData(lon : lon, lat : lat) { returnedData in
//            DispatchQueue.main.async { [weak self] in
//                self?.datas = returnedData
//            }
//        }
//    }
//
//    func getData(lon : Double, lat : Double, escapingHandler: @escaping (_ data:  [PlaceResult])->Void){
//
//        AF.request("http://49.50.164.40:8080/place", method: .post, parameters:  ["lon" : lon, "lat": lat, "sort" : 1], encoder: JSONParameterEncoder.default).responseJSON { response in
//          //  print("response: \(response)")
//
//            var routines: [PlaceResult]
//            do {
//                let decoder = JSONDecoder()
//                switch (response.result) {
//                case .success:
//                    let result  = try decoder.decode(Response.self, from: response.data!)
//                    routines = result.data
//                    escapingHandler(routines)
//                case .failure(let error):
//                    print("errorCode: \(error._code)")
//                    print("errorDescription: \(error.errorDescription!)")
//                }
//            } catch let parsingError {
//                print("Error:", parsingError)
//            }
//        }.resume()
//    }
//
//}


/* POST DATA */
/*
 func getLoginResult(escapingHandler: @escaping (_ data:  [PlaceResult])->Void){
 
 AF.request("http://49.50.164.40:8080/place", method: .post, parameters:  ["lon" : 127.00000561774723, "lat": 37.562372047045585, "sort" : 1], encoder: JSONParameterEncoder.default).responseJSON { response in
 //   print("response: \(response)")
 
 var routines: [PlaceResult]
 do {
 let decoder = JSONDecoder()
 switch (response.result) {
 case .success:
 let a  = try decoder.decode(Response.self, from: response.data!)
 routines = a.data
 //     print("routines: \(routines[0])")
 escapingHandler(routines)
 case .failure(let error):
 print("errorCode: \(error._code)")
 print("errorDescription: \(error.errorDescription!)")
 }
 } catch let parsingError {
 print("Error:", parsingError)
 }
 }.resume()
 
 }
 */
