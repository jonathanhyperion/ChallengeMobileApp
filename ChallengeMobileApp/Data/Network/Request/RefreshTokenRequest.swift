//
//  RefreshTokenRequest.swift
//  ChallengeMobileApp
//

import Foundation

// MARK: - RefreshTokenRequest
struct RefreshTokenRequest: Codable {
    let grantType, clientID, refreshToken, clientSecret: String

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case refreshToken = "refresh_token"
    }
}
