//
//  RefreshTokenUseCase.swift
//  ChallengeMobileApp
//

import Combine
import Foundation

struct RefreshTokenUseCase {
    let repository: AuthRepository

    func refeshToken(params: RefreshTokenRequest) -> AnyPublisher<AccessToken, Error> {
        repository.refeshToken(params: params)
    }
}
