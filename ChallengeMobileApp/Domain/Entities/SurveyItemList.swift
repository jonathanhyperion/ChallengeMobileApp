//
//  SurveyItemList.swift
//  ChallengeMobileApp
//

import Foundation

struct SurveyItemList: Codable, Hashable {
    let id: String
    let title, description: String
    let imageUrl: String
    
    static let placeholders: [SurveyItemList] = (0 ..< 4).map {
        SurveyItemList(
            id: "\($0)",
            title: "Placeholder Title \($0)",
            description: "Placeholder Description \($0)",
            imageUrl: "placeholder_image_url\($0)"
        )
    }
}
