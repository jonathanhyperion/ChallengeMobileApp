//
//  AccessToken.swift
//  ChallengeMobileApp
//

import Foundation

// MARK: - AccessToken
struct AccessToken: Codable {
    let id: String?
    let accessToken: String?
    let expiresIn: Int?
    let refreshToken: String?
    let createdAt: Int?
}
