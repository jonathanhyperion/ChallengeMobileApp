//
//  RedactedAndShimmerViewModifier.swift
//  ChallengeMobileApp
//

import SwiftUI

struct RedactedAndShimmerViewModifier: ViewModifier {
    private let condition: Bool

    init(condition: Bool) {
        self.condition = condition
    }

    public func body(content: Content) -> some View {
        if condition {
            content
                .redacted(reason: .placeholder)
                .shimmering()
        } else {
            content
        }
    }
}

public extension View {
    func redactShimmer(condition: Bool) -> some View {
        modifier(RedactedAndShimmerViewModifier(condition: condition))
    }
}
