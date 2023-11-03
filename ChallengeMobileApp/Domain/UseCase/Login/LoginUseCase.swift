//
//  LoginUseCase.swift
//  ChallengeMobileApp
//

import Combine
import Foundation

struct LoginUseCase {
    let repository: AuthRepository

    func login(params: LoginRequest) -> AnyPublisher<AccessToken, Error> {
        repository.login(params: params)
    }
}
