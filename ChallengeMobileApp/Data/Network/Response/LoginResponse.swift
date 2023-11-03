//
//  LoginResponse.swift
//  ChallengeMobileApp
//

import Foundation

// MARK: - LoginRequest
struct LoginResponse: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, type: String?
    let attributes: Attributes?
}

// MARK: - Attributes
struct Attributes: Codable {
    let accessToken, tokenType: String?
    let expiresIn: Int?
    let refreshToken: String?
    let createdAt: Int?
}
