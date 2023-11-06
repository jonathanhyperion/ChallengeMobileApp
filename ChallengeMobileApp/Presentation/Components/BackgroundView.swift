//
//  BackgroundView.swift
//  ChallengeMobileApp
//

import SwiftUI

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
