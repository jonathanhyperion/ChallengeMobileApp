//
//  GetProfileUseCase.swift
//  ChallengeMobileApp
//

import Combine
import Foundation

struct GetProfileUseCase {
    let repository: UserRepository

    func getUser() -> AnyPublisher<UserProfile, Error> {
        repository.getUser()
    }
}
