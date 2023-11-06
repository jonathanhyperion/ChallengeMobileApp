//
//  ForgotPasswordResponse.swift
//  ChallengeMobileApp
//

import Foundation

// MARK: - ForgotPasswordResponse
struct ForgotPasswordResponse: Codable {
    let meta: MetaInfo?
}

// MARK: - MetaInfo
struct MetaInfo: Codable {
    let message: String?
}
