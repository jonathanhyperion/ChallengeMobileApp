//
//  String+ToDate.swift
//  ChallengeMobileApp
//

import Foundation

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            /// In this case, the current date and time is returned as the default value
            return Date()
        }
    }
}
