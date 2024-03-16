//
//  LinkRowView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 15/03/2024.
//

import SwiftUI

struct InfoRowView: View {
    let text: String
    let imageName: String

    var body: some View {
        
        HStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(Color(.icon))
                .roundBackgroundView(color: Color(.linkButton))
            
            Text(text)
                .boldAppFont(size: 16)
                .foregroundStyle(Color(.mainText))
            
            Spacer()
        }
        .roundBackgroundView(color: Color(.speakerCardBackground))

    }
}

#Preview {
    InfoRowView(text: "", imageName: "")
}
