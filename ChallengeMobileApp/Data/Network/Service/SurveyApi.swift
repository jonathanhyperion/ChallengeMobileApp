//
//  SurveyApi.swift
//  ChallengeMobileApp
//

import Moya
import RxSwift
import Foundation

enum SurveyApi {
    case getSurveys(pageNumber: Int, pageSize: Int)
}

extension SurveyApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: K.baseUrl) else {
            fatalError("baseURL could not be configurated.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getSurveys:
            return "/surveys"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSurveys:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .getSurveys(pageNumber, pageSize):
            return .requestParameters(parameters: [
                "page[number]": pageNumber,
                "page[size]": pageSize
            ], encoding: URLEncoding())
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        return [
            "Content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer \(Storage.shared.getTokenAuth())",
        ]
    }
}
