//
//  String+ToDate.swift
//  ChallengeMobileApp
//

import Foundation

extension String {
    func toDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            /// In this case, the current date and time is returned as the default value
            return Date()
        }
    }
}
