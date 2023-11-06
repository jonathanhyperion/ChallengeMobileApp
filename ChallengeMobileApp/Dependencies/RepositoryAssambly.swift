//
//  RepositoryAssambly.swift
//  ChallengeMobileApp
//

import Moya
import Swinject
import Foundation
import SwinjectAutoregistration

public struct RepositoryAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.autoregister(AuthRepository.self, initializer: AuthRepositoryImpl.init)
        container.autoregister(UserRepository.self, initializer: UserRepositoryImpl.init)
        container.autoregister(SurveyRepository.self, initializer: SurveyRepositoryImpl.init)
    }
}
