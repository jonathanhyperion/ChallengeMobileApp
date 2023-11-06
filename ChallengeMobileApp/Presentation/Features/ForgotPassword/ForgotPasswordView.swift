//
//  ForgotPasswordView.swift
//  ChallengeMobileApp
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email = ""
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
                        
                        Text("Enter your email to receive instructions for resetting your password.")
                        
                        Spacer()
                        
                        VStack(spacing: 28.0) {
                            
                            CustomTextField(
                                text: $email,
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
                            
                            Button(
                                action: {
                                    
                                }
                            ) {
                                VStack(alignment: .center) {
                                    Text("Reset")
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
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
