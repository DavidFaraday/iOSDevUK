//
//  LinkRowView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 15/03/2024.
//

import SwiftUI

struct LinkRowView: View {
    let name: String
    let url: URL

    var body: some View {
        Link(destination: url) {
            HStack(spacing: 10) {
                Image(systemName: "link")
                    .tint(Color(.purple300))
                    .roundBackgroundView(color: Color(.linkButton))

                Text(name)
                    .semiboldAppFont(size: 16)
                    .foregroundStyle(Color(.mainText))
                
                Spacer()
            }
            .roundBackgroundView(color: Color(.speakerCardBackground))
        }
    }
}

#Preview {
    LinkRowView(name: "", url: URL(string: "")!)
}
