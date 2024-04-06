//
//  MapPinShape.swift
//  iOSDevUK
//
//  Created by David Kababyan on 06/04/2024.
//

import SwiftUI

struct MapPinShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
        
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control: CGPoint(x: rect.maxX, y: rect.minY))

        return path
    }
}
