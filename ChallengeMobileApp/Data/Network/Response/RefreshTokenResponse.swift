//
//  RefreshTokenResponse.swift
//  ChallengeMobileApp
//

import Foundation

// MARK: - RefreshTokenResponse
struct RefreshTokenResponse: Codable {
    let data: DataClass?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}
