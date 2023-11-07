//
//  ContentView.swift
//  ChallengeMobileApp
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel = .make()
    
    @State private var keyboardHeight: CGFloat = 0.0
    @State var isAnimating: Bool = false
    
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
                            
                            if viewModel.errorLogin {
                                withAnimation {
                                    Text(L10n.errorLogin)
                                        .font(.custom(FontFamily.Neuzeit.book, fixedSize: 17.0))
                                        .foregroundColor(.red)
                                        .padding(.horizontal, 16.0)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
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
                                ZStack {
                                    if viewModel.isLoading {
                                        Asset.loadingIcon.swiftUIImage
                                            .renderingMode(.template)
                                            .resizable()
                                            .foregroundColor(.gray.opacity(0.3))
                                            .frame(
                                                width: 20,
                                                height: 20
                                            )
                                            .rotationEffect(Angle(degrees: isAnimating ? 360.0 : 0.0))
                                            .animation(.linear(duration: 1.0).repeatForever(autoreverses: false), value: isAnimating)
                                            .onAppear {
                                                self.isAnimating = true
                                            }
                                    } else {
                                        Text(L10n.login)
                                            .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 17.0))
                                            .foregroundColor(.black)
                                    }
                                }
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
