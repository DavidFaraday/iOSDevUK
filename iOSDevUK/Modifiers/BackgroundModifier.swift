//
//  BackgroundModifier.swift
//  iOSDevUK
//
//  Created by David Kababyan on 15/03/2024.
//

import SwiftUI

struct ButtonBackgroundModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background {
                Capsule()
                    .foregroundStyle(Color(.linkButton))
                    .frame(height: 35)
            }
    }
}

extension View {
    func buttonBackgroundView() -> some View {
        self.modifier(ButtonBackgroundModifier())
    }
}

struct RoundBackgroundModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(color)
            }
    }
}

extension View {
    func roundBackgroundView(color: Color) -> some View {
        self.modifier(RoundBackgroundModifier(color: color))
    }
}
