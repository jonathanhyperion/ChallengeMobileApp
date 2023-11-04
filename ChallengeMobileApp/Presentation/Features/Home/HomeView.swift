//
//  LoginView.swift
//  ChallengeMobileApp
//

import SwiftUI

struct HomeView: View {
    @State private var isMenuOpen = true
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                ZStack {
                    if isMenuOpen {
                        Color.black.opacity(0.1).onTapGesture {
                            isMenuOpen.toggle()
                        }
                    }
                    
                    SideNav(reader: reader.size)
                        .offset(x: isMenuOpen ? 0 : reader.size.width * 0.65)
                        .animation(.easeInOut)
                }
                .onTapGesture {
                    isMenuOpen.toggle()
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
