//
//  UserProfile.swift
//  ChallengeMobileApp
//

import Foundation

struct UserProfile: Codable {
    let email, name: String?
    let avatarURL: String?
    
    static let placeholders: UserProfile = UserProfile(email: nil, name: nil, avatarURL: nil)
}
