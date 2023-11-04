//
//  String+DataEncoded.swift
//  ChallengeMobileApp
//

import Foundation

extension String {
    var dataEncoded: Data {
        data(using: String.Encoding.utf8)!
    }
}
