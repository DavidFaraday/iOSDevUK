//
//  CustomNavigationView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct CustomNavigationView<Content: View>: View {
    @ViewBuilder
    private let content: () -> Content
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        //TODO: Change to navigation stack
        NavigationStack {
            content()
        }
    }
}
