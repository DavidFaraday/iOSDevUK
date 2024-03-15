//
//  AppFontModifier.swift
//  iOSDevUK
//
//  Created by David Kababyan on 15/03/2024.
//

import SwiftUI

struct AppFontModifier: ViewModifier {
    enum Weight {
        case light
        case regular
        case semibold
        case bold
    }

    let size: CGFloat
    let weight: Weight

    init(weight: Weight, size: CGFloat) {
        self.size = size
        self.weight = weight
    }

    func body(content: Content) -> some View {
        switch weight {
        case .regular:
            content.font(.custom("SFProDisplay-Regular", size: size))
        case .bold:
            content.font(.custom("SFProDisplay-Bold", size: size))
        case .light:
            content.font(.custom("SFProDisplay-Light", size: size))
        case .semibold:
            content.font(.custom("SFProDisplay-Semibold", size: size))

        }
    }
}

extension View {
    func appFont(weight: AppFontModifier.Weight = .regular, size: CGFloat) -> some View {
        modifier(AppFontModifier(weight: weight, size: size))
    }

    func boldAppFont(size: CGFloat) -> some View {
        appFont(weight: .bold, size: size)
    }

    func semiboldAppFont(size: CGFloat) -> some View {
        appFont(weight: .semibold, size: size)
    }

    func lightAppFont(size: CGFloat) -> some View {
        appFont(weight: .light, size: size)
    }
}



