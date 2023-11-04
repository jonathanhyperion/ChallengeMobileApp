//
//  LogoutRequest.swift
//  ChallengeMobileApp
//

import Foundation

// MARK: - LogoutRequest
struct LogoutRequest: Codable {
    let token, clientID, clientSecret: String?

    enum CodingKeys: String, CodingKey {
        case token
        case clientID = "client_id"
        case clientSecret = "client_secret"
    }
}
