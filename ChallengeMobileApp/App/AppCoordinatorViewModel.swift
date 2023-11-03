//
//  AppCoordinatorViewModel.swift
//  ChallengeMobileApp
//

import SwiftUI
import FlowStacks

class AppCoordinatorViewModel: ObservableObject {
    @Published var routes: Routes<Screen>
    @Published var homeRoutes: Bool = false
    
    init() {
        routes = [.root(.login)]
    }
    
    func goToHome() {
        withAnimation(.spring()) {
            homeRoutes = true
        }
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
        AppCoordinatorViewModel()
    }
}


enum Screen {
    case home
    case login
}
