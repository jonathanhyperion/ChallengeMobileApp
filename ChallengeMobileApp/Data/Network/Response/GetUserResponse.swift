//
//  GetUserResponse.swift
//  ChallengeMobileApp
//

import Foundation

// MARK: - GetUserResponse
struct GetUserResponse: Codable {
    let data: DataUser?
}

// MARK: - DataUser
struct DataUser: Codable {
    let id, type: String?
    let attributes: AttributesUser?
}

// MARK: - AttributesUser
struct AttributesUser: Codable {
    let email, name: String?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case email, name
        case avatarURL = "avatar_url"
    }
}
