//
//  AuthRepository.swift
//  ChallengeMobileApp
//

import Foundation
import Moya
import Combine

protocol AuthRepository {
    func isUserLogged() -> Bool
    func login(params: LoginRequest) -> AnyPublisher<AccessToken, Error>
    func logout(params: LogoutRequest) -> AnyPublisher<LogoutResponse, Error>
    func refeshToken(params: RefreshTokenRequest) -> AnyPublisher<AccessToken, Error>
    func forgotPassword(params: ForgotPasswordRequest) -> AnyPublisher<String, Error>
}
