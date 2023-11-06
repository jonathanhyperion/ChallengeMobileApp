//
//  ChallengeMobileAppApp.swift
//  ChallengeMobileApp
//

import SwiftUI

@main
struct ChallengeMobileApp: App {
    let appCoordinatorViewModel: AppCoordinatorViewModel = .make()
    @StateObject var surveyEnviroment = SurveyEnviroment()
    var body: some Scene {
        WindowGroup {
            AppCoordinator(viewModel: appCoordinatorViewModel)
                .environmentObject(surveyEnviroment)
        }
    }
}
