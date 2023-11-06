//
//  GetSurveysUseCase.swift
//  ChallengeMobileApp
//

import Combine
import Foundation

struct GetSurveysUseCase {
    let repository: SurveyRepository

    func getSurveys(pageNumber: Int, pageSize: Int) -> AnyPublisher<[SurveyItemList], Error> {
        repository.getSurveys(pageNumber: pageNumber, pageSize: pageSize)
    }
}
