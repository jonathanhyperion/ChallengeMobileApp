//
//  ChallengeMobileAppApp.swift
//  ChallengeMobileApp
//

import SwiftUI

@main
struct ChallengeMobileApp: App {
    let appCoordinatorViewModel: AppCoordinatorViewModel = .make()
    var body: some Scene {
        WindowGroup {
            AppCoordinator(viewModel: appCoordinatorViewModel)
        }
    }
}
