//
//  IsUserLoggedUseCase.swift
//  ChallengeMobileApp
//

import Foundation

struct IsUserLoggedUseCase {
    let repository: AuthRepository

    func execute() -> Bool {
        repository.isUserLogged()
    }
}
