//
//  LoginResponse.swift
//  ChallengeMobileApp
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let data: DataClass?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, type: String?
    let attributes: Attributes?
    
    private enum CodingKeys: String, CodingKey {
        case id, type, attributes
    }
}

// MARK: - Attributes
struct Attributes: Codable {
    let accessToken, tokenType: String?
    let expiresIn: Int?
    let refreshToken: String?
    let createdAt: Int?
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"
    }
}
