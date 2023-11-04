//
//  NetworkRequestError.swift
//  ChallengeMobileApp
//

import Foundation

enum NetworkRequestError: Error {
    case invalidRequest(_ data: NetworkErrors?)
    case invalidResponse(_ data: NetworkErrors?)
    case badRequest(_ data: NetworkErrors?)
    case unauthorized(_ data: NetworkErrors?)
    case forbidden(_ data: NetworkErrors?)
    case notFound(_ data: NetworkErrors?)
    case error4xx(_ code: Int)
    case serverError(_ data: NetworkErrors?)
    case error5xx(_ code: Int)
    case decodingError(_ data: NetworkErrors?)
    case urlSessionFailed(_ error: URLError)
    case unknownError(_ data: NetworkErrors?)
    case timeout(_ data: NetworkErrors?)

    func associatedValue<T: Codable>() -> T? {
        switch self {
        case let .badRequest(data),
             let .forbidden(data),
             let .invalidRequest(data),
             let .invalidResponse(data),
             let .unauthorized(data),
             let .notFound(data),
             let .serverError(data),
             let .decodingError(data),
             let .unknownError(data),
             let .timeout(data):
            return data as? T
        default:
            return "" as? T
        }
    }
}
