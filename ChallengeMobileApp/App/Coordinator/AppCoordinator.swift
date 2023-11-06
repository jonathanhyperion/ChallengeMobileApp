//
//  AppCoordinator.swift
//  ChallengeMobileApp
//

import SwiftUI
import FlowStacks

struct AppCoordinator: View {
    @ObservedObject var viewModel: AppCoordinatorViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            Router($viewModel.routes) { screen, _ in
                ZStack {
                    switch screen {
                    case .home:
                        HomeView(goToLogin: viewModel.goToLogin, goToSurvey: viewModel.goToSurvey)
                    case .login:
                        LoginView(pushHome: viewModel.goToHome)
                    case .survey:
                        SurveyView(goToBack: viewModel.goBack)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
