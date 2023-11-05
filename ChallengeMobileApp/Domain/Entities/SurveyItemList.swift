//
//  SurveyItemList.swift
//  ChallengeMobileApp
//

import Foundation

struct SurveyItemList: Codable, Hashable {
    let id: String
    let title, description: String
    let imageUrl: String
}
