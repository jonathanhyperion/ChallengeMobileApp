//
//  UseCaseAssembly.swift
//  ChallengeMobileApp
//

import Moya
import Swinject
import Foundation
import SwinjectAutoregistration

public struct UseCaseAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.autoregister(LoginUseCase.self, initializer: LoginUseCase.init)
        container.autoregister(IsUserLoggedUseCase.self, initializer: IsUserLoggedUseCase.init)
        container.autoregister(RefreshTokenUseCase.self, initializer: RefreshTokenUseCase.init)
        container.autoregister(LogoutUseCase.self, initializer: LogoutUseCase.init)
        container.autoregister(GetProfileUseCase.self, initializer: GetProfileUseCase.init)
        container.autoregister(GetSurveysUseCase.self, initializer: GetSurveysUseCase.init)
        container.autoregister(ForgotPasswordUseCase.self, initializer: ForgotPasswordUseCase.init)
    }
}
