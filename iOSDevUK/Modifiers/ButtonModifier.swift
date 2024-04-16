//
//  ButtonModifier.swift
//  iOSDevUK
//
//  Created by David Kababyan on 16/03/2024.
//

import SwiftUI

struct AppButtonStyle: ButtonStyle {
    let color: Color
    let fontSize: CGFloat
    let height: CGFloat
    
    init(color: Color, fontSize: CGFloat = 15, height: CGFloat = 16) {
        self.color = color
        self.fontSize = fontSize
        self.height = height
    }

    

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .boldAppFont(size: fontSize)
            .foregroundStyle(Color(.buttonTitle))
            .padding(.horizontal, 30)
            .padding(.vertical, height)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(color)
            )
    }
}

extension ButtonStyle where Self == AppButtonStyle {
    static func primary(with color: Color) -> AppButtonStyle {
        return AppButtonStyle(color: color)
    }

    static var appPrimary: AppButtonStyle {
        return primary(with: Color(.buttonBackground))
    }
    
    static func customButton(fontSize: CGFloat = 24, height: CGFloat = 15) -> AppButtonStyle {
        return AppButtonStyle(color: Color(.buttonBackground), fontSize: fontSize, height: height)
    }
}
