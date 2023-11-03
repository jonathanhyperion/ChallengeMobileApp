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
                        HomeView()
                    case .login:
                        LoginView(pushHome: viewModel.goToHome)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
