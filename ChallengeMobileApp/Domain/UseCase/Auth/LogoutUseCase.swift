//
//  LogoutUseCase.swift
//  ChallengeMobileApp
//

import Combine
import Foundation

struct LogoutUseCase {
    let repository: AuthRepository

    func logout(params: LogoutRequest) -> AnyPublisher<LogoutResponse, Error> {
        repository.logout(params: params)
    }
}
