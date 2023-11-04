//
//  CustomTextField.swift
//  ChallengeMobileApp
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var backgroundColor: Color
    var foregroundColor: Color
    var cornerRadius: CGFloat
    var isPassword: Bool

    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(.custom(FontFamily.Neuzeit.book, fixedSize: 17.0))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 16.0)
                }
                
                if isPassword {
                    SecureField("", text: $text)
                        .padding(.horizontal, 16.0)
                        .padding(.vertical, 16.0)
                        .font(.custom(FontFamily.Neuzeit.book, fixedSize: 17.0))
                        .foregroundColor(.white)
                } else {
                    TextField("", text: $text)
                        .padding(.horizontal, 16.0)
                        .padding(.vertical, 16.0)
                        .font(.custom(FontFamily.Neuzeit.book, fixedSize: 17.0))
                        .foregroundColor(.white)
                        .keyboardType(.emailAddress)
                }
            }
            
            if isPassword {
                Button(
                    action: {}
                ) {
                    Text(L10n.forgotPassword)
                        .font(.custom(FontFamily.Neuzeit.book, fixedSize: 17.0))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 16)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.white.opacity(0.1))
        )
        .foregroundColor(foregroundColor)
    }
}
