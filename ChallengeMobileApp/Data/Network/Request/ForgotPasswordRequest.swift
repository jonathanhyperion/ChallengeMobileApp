//
//  ForgotPasswordRequest.swift
//  ChallengeMobileApp
//

import Foundation

// MARK: - ForgotPasswordRequest
struct ForgotPasswordRequest: Codable {
    let user: User?
    let clientID, clientSecret: String?

    enum CodingKeys: String, CodingKey {
        case user
        case clientID = "client_id"
        case clientSecret = "client_secret"
    }
}

// MARK: - User
struct User: Codable {
    let email: String?
}
