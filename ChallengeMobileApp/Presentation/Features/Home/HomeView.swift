//
//  LoginView.swift
//  ChallengeMobileApp
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .make()
    @State private var isMenuOpen = false
    
    var goToLogin: () -> Void
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                HomeContetView(isMenuOpen: $isMenuOpen, viewModel: viewModel, reader: reader.size)
                
                if isMenuOpen {
                    Color.black.opacity(0.4).onTapGesture {
                        isMenuOpen.toggle()
                    }
                }
                
                SideNav(
                    reader: reader.size,
                    user: viewModel.user,
                    goToLogin: goToLogin
                ) {
                    viewModel.logout()
                }
                .offset(x: isMenuOpen ? 0 : reader.size.width * 0.65)
                .animation(.easeInOut)
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            if isMenuOpen {
                isMenuOpen.toggle()
            }
        }
        .onAppear {
            viewModel.getProfile()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(goToLogin: {})
    }
}
