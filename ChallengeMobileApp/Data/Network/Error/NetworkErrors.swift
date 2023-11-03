//
//  NetworkErrors.swift
//  ChallengeMobileApp
//

import Foundation

struct NetworkErrors: Error, Codable {
    var code: Int?
    var detail: String?
}
