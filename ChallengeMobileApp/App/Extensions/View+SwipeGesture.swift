//
//  View+SwipeGesture.swift
//  ChallengeMobileApp
//

import SwiftUI

extension View {
    func swipeGesture(_ action: @escaping () -> Void) -> some View {
        highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
            .onEnded { value in
                if abs(value.translation.height) < abs(value.translation.width) {
                    if abs(value.translation.width) > 50.0 {
                        if value.translation.width < 0 {
                            action() /// Call swipeRightToLeft() function
                        } else if value.translation.width > 0 {
                            action() /// Call swipeLeftToRight() function
                        }
                    }
                }
            }
        )
    }
}
