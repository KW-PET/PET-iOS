//
//  Util.swift
//  pet-client
//
//  Created by 김지수 on 2022/10/01.
//

import Foundation
import UIKit

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
    
    func calculateDays(created_at:[Int]) -> Int {
        var daysCount:Int = 0
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let startDate = formatter.date(from: "\(created_at[0])-\(created_at[1])-\(created_at[2])")
        daysCount = days(from: startDate!)
        return daysCount
    }
        
    func days(from date: Date) -> Int {
        let calendar = Calendar.current
        let currentDate = Date()

        return calendar.dateComponents([.day], from: date, to: currentDate).day! + 1
    }
}


extension UINavigationController: UIGestureRecognizerDelegate,UINavigationControllerDelegate {
   open override func viewDidLoad() {
       super.viewDidLoad()
       interactivePopGestureRecognizer?.delegate = self
   }

   public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
       return viewControllers.count > 1
   }
}
