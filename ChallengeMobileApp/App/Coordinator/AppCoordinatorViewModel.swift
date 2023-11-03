//
//  AppCoordinatorViewModel.swift
//  ChallengeMobileApp
//

import SwiftUI
import FlowStacks

class AppCoordinatorViewModel: ObservableObject {
    @Published var routes: Routes<Screen>
    
    init(isUserLoggedUseCase: IsUserLoggedUseCase) {
        if isUserLoggedUseCase.execute() {
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
    
    func goBack() {
        routes.goBack()
    }
}

extension AppCoordinatorViewModel {
    static func make() -> AppCoordinatorViewModel {
        AppCoordinatorViewModel(isUserLoggedUseCase: Injector.resolve(IsUserLoggedUseCase.self))
    }
}
