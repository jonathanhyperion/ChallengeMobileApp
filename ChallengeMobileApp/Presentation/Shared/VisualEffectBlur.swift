//
//  VisualEffectBlur.swift
//  ChallengeMobileApp
//

import SwiftUI

struct VisualEffectBlur: View {
    var blurStyle: UIBlurEffect.Style
    var vibrancyStyle: UIVibrancyEffectStyle?
    
    var body: some View {
        EmptyView()
            .background(
                VisualEffectBlurRepresentable(
                    blurStyle: blurStyle,
                    vibrancyStyle: vibrancyStyle
                )
            )
    }
}

struct VisualEffectBlurRepresentable: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    var vibrancyStyle: UIVibrancyEffectStyle?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        if let vibrancyStyle = vibrancyStyle {
            let vibrancyEffect = UIVibrancyEffect(blurEffect: uiView.effect as! UIBlurEffect, style: vibrancyStyle)
            let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
            uiView.contentView.addSubview(vibrancyView)
        }
    }
}
