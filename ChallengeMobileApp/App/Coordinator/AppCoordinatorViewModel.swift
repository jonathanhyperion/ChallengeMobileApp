//
//  AppCoordinatorViewModel.swift
//  ChallengeMobileApp
//

import SwiftUI
import FlowStacks
import Combine

class AppCoordinatorViewModel: ObservableObject {
    @Published var routes: Routes<Screen> = []
    
    private let isUserLoggedUseCase: IsUserLoggedUseCase
    private let refreshTokenUseCase: RefreshTokenUseCase
    private var cancellable = Set<AnyCancellable>()
    
    init(
        isUserLoggedUseCase: IsUserLoggedUseCase,
        refreshTokenUseCase: RefreshTokenUseCase
    ) {
        self.isUserLoggedUseCase = isUserLoggedUseCase
        self.refreshTokenUseCase = refreshTokenUseCase
        self.navigation()
    }
    
    func navigation() {
        if (isUserLoggedUseCase.execute()) {
            if (Storage.shared.isTokenExpired()) {
                refreshToken()
            }
            routes = [.root(.home)]
        } else {
            routes = [.root(.login)]
        }
    }
    
    func goToHome() {
        routes.push(.home)
    }
    
    func goToLogin() {
        routes.push(.login)
    }
    
    func goToSurvey() {
        routes.push(.survey)
    }
    
    func goToForgotPassword() {
        routes.push(.forgotPassword)
    }
    
    func goBack() {
        routes.goBack()
    }
    
    private func refreshToken() {
        refreshTokenUseCase.refeshToken(
            params: RefreshTokenRequest(
                grantType: "refresh_token",
                clientID: K.clientID,
                refreshToken: Storage.shared.getRefreshToken(),
                clientSecret: K.clientSecret
            )
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { error in
            switch error {
            case let .failure(error):
                    if let networkError = error as? NetworkRequestError {
                        let result: NetworkErrors? = networkError.associatedValue()
                        if result != nil {}
                    }
                    print("❌ Error \(error)")
            case .finished:
                break
            }
        }, receiveValue: { [weak self] _ in })
        .store(in: &cancellable)
    }
}

extension AppCoordinatorViewModel {
    static func make() -> AppCoordinatorViewModel {
        AppCoordinatorViewModel(
            isUserLoggedUseCase: Injector.resolve(IsUserLoggedUseCase.self),
            refreshTokenUseCase: Injector.resolve(RefreshTokenUseCase.self)
        )
    }
}
