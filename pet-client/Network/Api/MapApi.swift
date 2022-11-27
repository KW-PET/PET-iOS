//
//  MapApi.swift
//  pet-client
//
//  Created by 박수연 on 2022/11/27.
//

import Foundation
import SwiftUI
import Alamofire

struct Response: Codable {
    let status:Int?
    let data: [PlaceResult]
    let success:Bool?
}


public struct PlaceResult: Codable, Identifiable{
    public let id = UUID()
    let name : String
    let address : String
    let distance : Double
    let category : String
    let place_id : Int
    let phone : String
    let xpos : Double
    let ypos : Double
    let like_cnt : Int
    
    init(name : String,
         address : String,
         distance : Double,
         category : String,
         place_id : Int,
         phone : String,
         xpos : Double,
         ypos : Double,
         like_cnt : Int) {
        self.name = name
        self.address = address
        self.distance = distance
        self.category = category
        self.place_id = place_id
        self.phone = phone
        self.xpos = xpos
        self.ypos = ypos
        self.like_cnt = like_cnt
    }
    
}

//MARK: VIEWMODEL
class FetchData: ObservableObject {
    @Published var datas: [PlaceResult] = []
    
    init() {
        setData()
    }
    
    func setData() {
        getData() { returnedData in
            DispatchQueue.main.async { [weak self] in
                self?.datas = returnedData
            }
            //print(returnedData[0])
        }
    }
    
    func getData(escapingHandler: @escaping (_ data:  [PlaceResult])->Void){
        
        AF.request("http://49.50.164.40:8080/place", method: .post, parameters:  ["lon" : 126.9783740, "lat": 37.5800135, "sort" : 1], encoder: JSONParameterEncoder.default).responseJSON { response in
            //   print("response: \(response)")
            
            var routines: [PlaceResult]
            do {
                let decoder = JSONDecoder()
                switch (response.result) {
                case .success:
                    let result  = try decoder.decode(Response.self, from: response.data!)
                    routines = result.data
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
    
}


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
