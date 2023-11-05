//
//  SurveyRepository.swift
//  ChallengeMobileApp
//

import Foundation
import Moya
import Combine

protocol SurveyRepository {
    func getSurveys(pageNumber: Int, pageSize: Int) -> AnyPublisher<[SurveyItemList]?, Error>
}
