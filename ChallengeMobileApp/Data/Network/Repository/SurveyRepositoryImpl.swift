//
//  SurveyRepositoryImpl.swift
//  ChallengeMobileApp
//

import Foundation

import Foundation
import Moya
import Combine

struct SurveyRepositoryImpl: SurveyRepository {
    
    private let api: MoyaProvider<SurveyApi>

    init(provider: MoyaProvider<SurveyApi>) {
        api = provider
    }
    
    func getSurveys(pageNumber: Int, pageSize: Int) -> AnyPublisher<[SurveyItemList]?, Error> {
        api.requestPublisher(.getSurveys(pageNumber: pageNumber, pageSize: pageSize))
            .map(\.data)
            .decode(type: SurveyListResponse.self, decoder: JSONDecoder())
            . tryMap { response in
                response.data?.compactMap { item in
                    guard let id = item.id,
                          let title = item.attributes?.title,
                          let description = item.attributes?.description,
                          let imageUrl = item.attributes?.coverImageURL
                    else {
                        return nil
                    }
                    return SurveyItemList(id: id, title: title, description: description, imageUrl: imageUrl)
                }
            }
            .eraseToAnyPublisher()
    }
}
