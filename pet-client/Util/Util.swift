//
//  Util.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/01.
//

import Foundation
extension Date {
    func makeTime(created_at:[Int]) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.date(from: "\(created_at[0])/\(created_at[1])/\(created_at[2]) \(created_at[3]):\(created_at[4]):\(created_at[5])") ?? Date()
    }
    
    var relativeTime: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
