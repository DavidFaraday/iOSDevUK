//
//  AnimatedButtonView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 18/04/2024.
//

import SwiftUI

struct AnimatedButtonView: View {
    @State var isAnimating = false
    @State var doneAnimation = false
    @State var submitScale: CGFloat = 1

    let animationDuration: TimeInterval = 0.20

    let title: String
    let color: Color
    let shouldAnimate: Bool
    let buttonAction: () -> Void

    init(title: String, color: Color, shouldAnimate: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.color = color
        self.shouldAnimate = shouldAnimate
        self.buttonAction = action
    }

    
    var body: some View {
        ZStack {
            Capsule()
                .fill(color)
                .frame(maxWidth: self.isAnimating ? (52) : .infinity)
                .scaleEffect(submitScale, anchor: .center)

            Tick(scaleFactor: 0.2)
                .trim(from: 0, to: self.doneAnimation ? 1 : 0)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                .foregroundColor(Color(.buttonTitle))
                .frame(width: 16)
                .offset(x: -4, y: 4)
                .animation(.easeOut(duration: 0.35), value: self.doneAnimation)

            Text(title)
                .semiboldAppFont(size: 18)
                .foregroundColor(Color(.buttonTitle))
                .opacity(self.isAnimating ? 0 : 1)
                .animation(.easeOut(duration: animationDuration), value: self.isAnimating)
                .scaleEffect(self.isAnimating ? 0.7 : 1)
                .animation(.easeOut(duration: animationDuration), value: self.isAnimating)
                .padding(10)
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            if shouldAnimate && !self.isAnimating {
                toggleIsAnimating()
                resetSubmit()
                self.doneAnimation = true
            }
            buttonAction()
        }
    }
    
    func resetSubmit() {
        Timer.scheduledTimer(withTimeInterval: animationDuration * 4.5, repeats: false) { _ in
            self.doneAnimation.toggle()
        }
        Timer.scheduledTimer(withTimeInterval: animationDuration * 5.5, repeats: false) { _ in
            toggleIsAnimating()
        }
    }

    func toggleIsAnimating() {
        withAnimation(Animation.spring(response: animationDuration * 1.25, dampingFraction: 0.9, blendDuration: 1)) {
            self.isAnimating.toggle()
        }
    }
}




struct Tick: Shape {
    let scaleFactor: CGFloat

    func path(in rect: CGRect) -> Path {
        let cX = rect.midX + 4
        let cY = rect.midY - 3

        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.move(to: CGPoint(x: cX - (42 * scaleFactor), y: cY - (4 * scaleFactor)))
        path.addLine(to: CGPoint(x: cX - (scaleFactor * 18), y: cY + (scaleFactor * 28)))
        path.addLine(to: CGPoint(x: cX + (scaleFactor * 40), y: cY - (scaleFactor * 36)))
        return path
    }
}
