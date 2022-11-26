//
//  SectionHeaderView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/11/2022.
//

import SwiftUI

struct SectionHeaderView: View {
    @Environment(\.font) private var font

    private let title: String

    init(title: String) {
        self.title = title
    }

    var body: some View {
        HStack {
            Text(title)
                .font(font)
        }
        .padding(.bottom, 8)
        .textCase(nil)
    }
}
