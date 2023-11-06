//
//  ContentView.swift
//  ChallengeMobileApp
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel = .make()
    
    @State private var keyboardHeight: CGFloat = 0.0
    
    let pushHome: () -> Void
    let pushForgotPassword: () -> Void
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                ZStack {
                    BackgroundView(reader: reader.size)
                    
                    VStack {
                        Asset.logoWhite.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: reader.size.width * 0.50,
                                height: reader.size.height * 0.10
                            )
                        
                        Spacer ()
                        
                        VStack(spacing: 28.0) {
                            
                            CustomTextField(
                                text: $viewModel.email,
                                placeholder: L10n.email,
                                backgroundColor: .white,
                                foregroundColor: .black,
                                cornerRadius: 10.0,
                                isPassword: false,
                                pushNext: {}
                            )
                            .frame(
                                width: reader.size.width * 0.90,
                                height: 56.0
                            )
                            
                            CustomTextField(
                                text: $viewModel.password,
                                placeholder: L10n.password,
                                backgroundColor: .white,
                                foregroundColor: .black,
                                cornerRadius: 10,
                                isPassword: true,
                                pushNext: {
                                    pushForgotPassword()
                                }
                            )
                            .frame(
                                width: reader.size.width * 0.90,
                                height: 56.0
                            )
                            
                            Button(
                                action: {
                                    viewModel.login()
                                }
                            ) {
                                VStack(alignment: .center) {
                                    Text(L10n.login)
                                        .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 17.0))
                                        .foregroundColor(.black)
                                }
                                .frame(
                                    width: reader.size.width * 0.90,
                                    height: 56.0
                                )
                                .background(.white)
                                .cornerRadius(10.0)
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .frame(
                        width: reader.size.width,
                        height: reader.size.height * 0.60
                    )
                }
            }
            
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .onChange(of: viewModel.validCredentials, perform: { navigate in
            if navigate {
                if !Storage.shared.getTokenAuth().isEmpty {
                    pushHome()
                }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(pushHome: {}, pushForgotPassword: {})
    }
}
