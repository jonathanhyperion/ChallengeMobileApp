//
//  SideNav.swift
//  ChallengeMobileApp
//

import SwiftUI

struct SideNav: View {
    let reader: CGSize
    var body: some View {
        HStack {
            Spacer()
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Mai")
                            .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 34.0))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Asset.background.swiftUIImage
                            .resizable()
                            .frame(width: 35.0, height: 35.0)
                            .clipShape(Circle())
                            .shadow(radius: 5.0)
                    }
                    .padding(.vertical, 20.0)
                    
                    Divider()
                        .background(.white)
                    
                    Button(
                        action: {
                            
                        }, label: {
                            Text("Logout")
                                .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 20.0))
                                .kerning(0.38)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding(.vertical, 16.0)
                        }
                    )
                    
                    Spacer()
                }
                .padding(.horizontal, 20.0)
                .frame(
                    width: reader.width * 0.65,
                    height: reader.height * 0.80
                )
                
                Text("v0.1.0 (1562903885)")
                    .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 11.0))
                    .kerning(0.07)
                    .foregroundColor(.white)
                    .frame(width: 200.0, alignment: .topLeading)
            }
            .frame(
                width: reader.width * 0.65,
                height: reader.height
            )
            .background(Asset.darkGray.swiftUIColor)
        }
    }
}
