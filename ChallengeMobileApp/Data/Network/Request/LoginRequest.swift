//
//  LoginRequest.swift
//  ChallengeMobileApp
//

import Foundation

// MARK: - LoginRequest
struct LoginRequest: Codable {
    let grantType, email, password, clientID, clientSecret: String

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case email
        case password
        case clientID = "client_id"
        case clientSecret = "client_secret"
    }
}
