//
//  BackgroundModifier.swift
//  iOSDevUK
//
//  Created by David Kababyan on 15/03/2024.
//

import SwiftUI

struct CapsuleBackgroundModifier: ViewModifier {
    
    let height: CGFloat
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background {
                Capsule()
                    .foregroundStyle(color)
                    .frame(height: height)
            }
    }
}

extension View {
    func capsuleBackgroundView(height: CGFloat = 35, color: Color = Color(.linkButton)) -> some View {
        self.modifier(CapsuleBackgroundModifier(height: height, color: color))
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


struct CapsuleOutlineModifier: ViewModifier {
    
    let height: CGFloat
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background {
                Capsule()
                    .stroke(color, lineWidth: 2)
                    .frame(height: height)
            }
    }
}

extension View {
    func capsuleOutlineView(height: CGFloat = 40, color: Color = Color(.outline)) -> some View {
        self.modifier(CapsuleOutlineModifier(height: height, color: color))
    }
}
