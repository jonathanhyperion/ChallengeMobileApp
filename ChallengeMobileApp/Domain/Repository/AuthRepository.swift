//
//  AuthRepository.swift
//  ChallengeMobileApp
//

import Foundation
import Moya
import Combine

protocol AuthRepository {
    func login(params: LoginRequest) -> AnyPublisher<AccessToken, Error>
}
