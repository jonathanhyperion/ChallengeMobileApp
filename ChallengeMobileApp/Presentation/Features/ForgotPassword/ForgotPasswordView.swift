//
//  ForgotPasswordView.swift
//  ChallengeMobileApp
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var viewModel: ForgotPasswordViewModel = .make()
    
    @State var email = ""
    
    let goToBack: () -> Void
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                ZStack {
                    BackgroundView(reader: reader.size)
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 65.0) {
                            Asset.backIcon.swiftUIImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40.0, height: 40.0, alignment: .leading)
                                .onTapGesture {
                                    goToBack()
                                }
                                .padding(.leading, 20.0)
                            
                            HStack {
                                Spacer()
                                
                                Asset.logoWhite.swiftUIImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(
                                        width: reader.size.width * 0.50,
                                        height: reader.size.height * 0.10,
                                        alignment: .center
                                    )
                                
                                Spacer()
                            }
                            .frame(width: reader.size.width)
                        }
                        
                        VStack(alignment: .center, spacing: 50.0) {
                            Text(L10n.enterEmailReset)
                                .font(.custom(FontFamily.Neuzeit.book, fixedSize: 17.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .foregroundColor(.gray)
                                .padding()
                            
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
                                
                                Button(
                                    action: {
                                        viewModel.sendEmailForgotPassword()
                                        goToBack()
                                    }
                                ) {
                                    VStack(alignment: .center) {
                                        Text(L10n.reset)
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
                            .frame(
                                width: reader.size.width
                            )
                        }
                        .padding(.vertical, 20.0)
                        
                        Spacer()
                        
                    }
                    .frame(
                        width: reader.size.width,
                        height: reader.size.height * 0.85
                    )
                }
            }
        }
        .ignoresSafeArea()
        .background(.black)
        .navigationBarBackButtonHidden(true)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(goToBack: {})
    }
}
