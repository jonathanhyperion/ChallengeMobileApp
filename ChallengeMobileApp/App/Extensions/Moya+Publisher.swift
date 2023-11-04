//
//  Moya+Publisher.swift
//  ChallengeMobileApp
//

import Foundation
import Moya
import Combine

extension MoyaProvider {
    func requestPublisher<T: Codable>(_ target: Target) -> AnyPublisher<T, Error> {
        self
            .requestPublisher(target)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
