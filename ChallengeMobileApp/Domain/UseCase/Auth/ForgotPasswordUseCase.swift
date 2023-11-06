//
//  ForgotPasswordUseCase.swift
//  ChallengeMobileApp
//

import Foundation
import Combine

struct ForgotPasswordUseCase {
    let repository: AuthRepository

    func forgotPassword(params: ForgotPasswordRequest) -> AnyPublisher<String, Error> {
        repository.forgotPassword(params: params)
    }
}
