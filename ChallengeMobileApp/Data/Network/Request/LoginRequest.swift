//
//  LoginRequest.swift
//  ChallengeMobileApp
//

import Foundation

// MARK: - LoginRequest
struct LoginRequest: Codable {
    let grantType, email, password, clientID: String?
    let clientSecret: String?
}
