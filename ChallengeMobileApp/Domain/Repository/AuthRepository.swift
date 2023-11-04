//
//  AuthRepository.swift
//  ChallengeMobileApp
//

import Foundation
import Moya
import Combine

protocol AuthRepository {
    func login(params: LoginRequest) -> AnyPublisher<AccessToken, Error>
    func isUserLogged() -> Bool
    func refeshToken(params: RefreshTokenRequest) -> AnyPublisher<AccessToken, Error>
}
