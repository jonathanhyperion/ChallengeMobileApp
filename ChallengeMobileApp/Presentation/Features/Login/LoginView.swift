//
//  ContentView.swift
//  ChallengeMobileApp
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel = .make()
    @State private var keyboardHeight: CGFloat = 0.0
    let pushHome: () -> Void
    
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
                                isPassword: false
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
                                isPassword: true
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

struct BackgroundView: View {
    var reader: CGSize
    
    var body: some View {
        ZStack {
            Asset.background.swiftUIImage
                .resizable()
                .scaledToFill()
                .frame(
                    width: reader.width,
                    height: reader.height
                )
                .overlay {
                    Rectangle()
                    .foregroundColor(.clear)
                    .frame(
                        width: reader.width,
                        height: reader.height
                    )
                    .background(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.3),
                                Gradient.Stop(color: .black, location: 0.55),
                                Gradient.Stop(color: .black, location: 1.0)
                            ]),
                            startPoint: UnitPoint(x: 0.0, y: 0.0),
                            endPoint: UnitPoint(x: 0.0, y: 1.0)
                        )
                    )
                }
            Rectangle()
                .foregroundColor(.clear)
                .frame(
                    width: reader.width,
                    height: reader.height
                )
                .background(
                    VisualEffectBlur(
                        blurStyle: .systemChromeMaterialDark,
                        vibrancyStyle: .fill
                    )
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(pushHome: {})
    }
}
