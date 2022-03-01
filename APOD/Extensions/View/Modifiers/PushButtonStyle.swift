//
//  PushButtonStyle.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import SwiftUI

struct PushButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
